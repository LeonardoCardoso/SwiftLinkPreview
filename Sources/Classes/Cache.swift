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

public class DisabledCache: Cache {

    public static let instance = DisabledCache()

    public func slp_getCachedResponse(url: String) -> Response? { return nil; }

    public func slp_setCachedResponse(url: String, response: Response?) { }
}

open class InMemoryCache: Cache {
    private var cache = Dictionary<String, (response: Response, date: Date)>()
    private let invalidationTimeout: TimeInterval
    private let cleanupTimer: DispatchSource?

    //High priority queue for quick responses
    private static let cacheQueue = DispatchQueue(label: "SwiftLinkPreviewInMemoryCacheQueue", qos: .userInitiated, target: DispatchQueue.global(qos: .userInitiated))

    public init(invalidationTimeout: TimeInterval = 300.0, cleanupInterval: TimeInterval = 10.0) {
        self.invalidationTimeout = invalidationTimeout

        self.cleanupTimer = DispatchSource.makeTimerSource(queue: type(of: self).cacheQueue) as? DispatchSource
        self.cleanupTimer?.schedule(deadline: .now() + cleanupInterval, repeating: cleanupInterval)

        self.cleanupTimer?.setEventHandler { [weak self] in
            guard let sself = self else {return}
            sself.cleanup()
        }

        self.cleanupTimer?.resume()
    }

    open func cleanup() {
        type(of: self).cacheQueue.async {
            for (url, data) in self.cache {
                if data.date.timeIntervalSinceNow >= self.invalidationTimeout {
                    self.cache[url] = nil
                }
            }
        }
    }

    open func slp_getCachedResponse(url: String) -> Response? {
        return type(of: self).cacheQueue.sync {
            guard let response = cache[url] else { return nil }

            if response.date.timeIntervalSinceNow >= invalidationTimeout {
                slp_setCachedResponse(url: url, response: nil)
                return nil
            }
            return response.response
        }
    }

    open func slp_setCachedResponse(url: String, response: Response?) {
        type(of: self).cacheQueue.sync {
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
