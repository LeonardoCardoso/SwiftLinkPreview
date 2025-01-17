//
//  Cache.swift
//  SwiftLinkPreview
//
//  Created by Yehor Popovych on 1/17/17.
//  Copyright © 2017 leocardz.com. All rights reserved.
//

import Foundation

public protocol Cache {
    func slp_getCachedResponse(url: String) -> Response?

    func slp_setCachedResponse(url: String, response: Response?)
}

public final class DisabledCache: Cache {
    public static let instance = DisabledCache()

    public func slp_getCachedResponse(url: String) -> Response? { nil }

    public func slp_setCachedResponse(url: String, response: Response?) { }
}

open class InMemoryCache: Cache {
    private var cache = [String: (response: Response, date: Date)]()
    private let invalidationTimeout: TimeInterval
    private let cleanupTimer: DispatchSource?

    // High priority queue for quick responses
    private static let cacheQueue = DispatchQueue(
        label: "SwiftLinkPreviewInMemoryCacheQueue",
        qos: .userInitiated,
        target: DispatchQueue.global(qos: .userInitiated)
    )

    public init(invalidationTimeout: TimeInterval = 300.0, cleanupInterval: TimeInterval = 10.0) {
        self.invalidationTimeout = invalidationTimeout

        self.cleanupTimer = DispatchSource.makeTimerSource(queue: Self.cacheQueue) as? DispatchSource
        cleanupTimer?.schedule(deadline: .now() + cleanupInterval, repeating: cleanupInterval)

        cleanupTimer?.setEventHandler { [weak self] in
            guard let self else { return }
            self.cleanup()
        }

        cleanupTimer?.resume()
    }

    open func cleanup() {
        Self.cacheQueue.async { [weak self] in
            guard let self else { return }
            for (url, data) in self.cache {
                if data.date.timeIntervalSinceNow >= self.invalidationTimeout {
                    self.cache[url] = nil
                }
            }
        }
    }

    open func slp_getCachedResponse(url: String) -> Response? {
        return Self.cacheQueue.sync { [weak self] in
            guard let self, let response = cache[url] else { return nil }

            if response.date.timeIntervalSinceNow >= invalidationTimeout {
                slp_setCachedResponse(url: url, response: nil)
                return nil
            }
            return response.response
        }
    }

    open func slp_setCachedResponse(url: String, response: Response?) {
        Self.cacheQueue.sync { [weak self] in
            guard let self else { return }
            if let response = response {
                cache[url] = (response, Date())
            } else {
                cache[url] = nil
            }
        }
    }

    deinit {
        self.cleanupTimer?.cancel()
    }
}
