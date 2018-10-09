//
//  StringExtension.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 09/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//
import Foundation

#if os(iOS) || os(watchOS) || os(tvOS)

    import UIKit

#elseif os(OSX)

    import Cocoa

#endif

extension String {

    // Trim
    var trim: String {

        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

    }

    // Remove extra white spaces
    var extendedTrim: String {

        let components = self.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ").trim

    }

    // Decode HTML entities
    var decoded: String {

        let encodedData = self.data(using: String.Encoding.utf8)!
        let attributedOptions: [NSAttributedString.DocumentReadingOptionKey: Any] =
            [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: NSNumber(value: String.Encoding.utf8.rawValue)
        ]

        do {

            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)

            return attributedString.string

        } catch _ {

            return self

        }

    }

    // Strip tags
    var tagsStripped: String {

        return self.deleteTagByPattern(Regex.rawTagPattern)

    }

    // Delete tab by pattern
    func deleteTagByPattern(_ pattern: String) -> String {

        return self.replacingOccurrences(of: pattern, with: "", options: .regularExpression, range: nil)

    }

    // Replace
    func replace(_ search: String, with: String) -> String {

        let replaced: String = self.replacingOccurrences(of: search, with: with)

        return replaced.isEmpty ? self : replaced

    }

    // Substring
    func substring(_ start: Int, end: Int) -> String {

        return self.substring(NSRange(location: start, length: end - start))

    }

    func substring(_ range: NSRange) -> String {

        var end = range.location + range.length
        end = end > self.count ? self.count - 1 : end

        return self.substring(range.location, end: end)

    }

    // Check if url is an image
    func isImage() -> Bool {

        return Regex.test(self, regex: Regex.imagePattern)

    }
    
    func isVideo() -> Bool {
        return Regex.test(self, regex: Regex.videoTagPattern)
    }

    // Split into substring of equal length
    func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()

        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }

        return results.map { String($0) }
    }

}
