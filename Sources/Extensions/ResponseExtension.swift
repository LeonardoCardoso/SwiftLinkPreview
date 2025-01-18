//
//  ResponseExtension.swift
//  SwiftLinkPreview
//
//  Created by Giuseppe Travasoni on 20/11/2018.
//  Copyright © 2018 leocardz.com. All rights reserved.
//

import Foundation

extension Response {
    var dictionary: [String: Any] {
        var responseData: [String: Any] = [:]
        responseData["baseURL"] = baseURL
        responseData["url"] = url
        responseData["finalUrl"] = finalUrl
        responseData["canonicalUrl"] = canonicalUrl
        responseData["title"] = title
        responseData["description"] = description
        responseData["images"] = images
        responseData["image"] = image
        responseData["icon"] = icon
        responseData["video"] = video
        responseData["price"] = price
        return responseData
    }

    enum Key: String {
        case url
        case finalUrl
        case canonicalUrl
        case title
        case description
        case image
        case images
        case icon
        case video
        case baseURL
        case price
    }

    mutating func set(_ value: Any, for key: Key) {
        switch key {
        case Key.baseURL:
            if let value = value as? String { baseURL = value }
        case Key.url:
            if let value = value as? URL { url = value }
        case Key.finalUrl:
            if let value = value as? URL { finalUrl = value }
        case Key.canonicalUrl:
            if let value = value as? String { canonicalUrl = value }
        case Key.title:
            if let value = value as? String { title = value }
        case Key.description:
            if let value = value as? String { description = value }
        case Key.image:
            if let value = value as? String { image = value }
        case Key.images:
            if let value = value as? [String] { images = value }
        case Key.icon:
            if let value = value as? String { icon = value }
        case Key.video:
            if let value = value as? String { video = value }
        case Key.price:
            if let value = value as? String { price = value }
        }
    }

    func value(for key: Key) -> Any? {
        switch key {
        case Key.baseURL:
            return baseURL
        case Key.url:
            return url
        case Key.finalUrl:
            return finalUrl
        case Key.canonicalUrl:
            return canonicalUrl
        case Key.title:
            return title
        case Key.description:
            return description
        case Key.image:
            return image
        case Key.images:
            return images
        case Key.icon:
            return icon
        case Key.video:
            return video
        case Key.price:
            return price
        }
    }
}
