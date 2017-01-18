//
//  Cache.swift
//  SwiftLinkPreview
//
//  Created by Yehor Popovych on 1/17/17.
//  Copyright © 2017 leocardz.com. All rights reserved.
//

import Foundation

public protocol Cache {
    
    func slp_getCachedResponse(url: String) -> SwiftLinkPreview.Response?
    
    func slp_setCachedResponse(url: String, response: SwiftLinkPreview.Response?)
}

public class DisabledCache: Cache {
    
    public static let instance = DisabledCache()
    
    public func slp_getCachedResponse(url: String) -> SwiftLinkPreview.Response? { return nil; }
    
    public func slp_setCachedResponse(url: String, response: SwiftLinkPreview.Response?) { }
}


public class InMemoryCache: Cache {
    private var cache = Dictionary<String, (response: SwiftLinkPreview.Response, date: Date)>()
    private let invalidationTimeout: TimeInterval
    
    public init(invalidationTimeout: TimeInterval = 300.0) {
        self.invalidationTimeout = invalidationTimeout
    }
    
    public func slp_getCachedResponse(url: String) -> SwiftLinkPreview.Response? {
        guard let response = cache[url] else { return nil }
        
        if response.date.timeIntervalSinceNow >= invalidationTimeout {
            slp_setCachedResponse(url: url, response: nil)
            return nil
        }
        return response.response
    }
    
    public func slp_setCachedResponse(url: String, response: SwiftLinkPreview.Response?) {
        if let response = response {
            cache[url] = (response, Date())
        } else {
            cache[url] = nil
        }
    }
}
