//
//  Response.swift
//  SwiftLinkPreview
//
//  Created by Giuseppe Travasoni on 20/11/2018.
//  Copyright © 2018 leocardz.com. All rights reserved.
//

import Foundation

public struct Response {
    
    public internal(set) var url: URL?
    public internal(set) var finalUrl: URL?
    public internal(set) var canonicalUrl: String?
    public internal(set) var title: String?
    public internal(set) var description: String?
    public internal(set) var images: [String]?
    public internal(set) var image: String?
    public internal(set) var icon: String?
    public internal(set) var video: String?
    public internal(set) var price: String?
    
    public init() { }
    
}
