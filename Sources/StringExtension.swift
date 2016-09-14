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
        let attributedOptions: [String: AnyObject] =
            [
                NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType as AnyObject,
                NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue as AnyObject
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
        
        return self.substring(with: Range(self.characters.index(self.startIndex, offsetBy: start) ..< self.characters.index(self.startIndex, offsetBy: end)))
        
    }
    func substring(_ range: NSRange) -> String {
        
        var end = range.location + range.length
        end = end > self.characters.count ? self.characters.count - 1 : end
        
        return self.substring(range.location, end: end)
        
    }
    
    // Check if it's a valid url
    func isValidURL() -> Bool {
        
        return Regex.test(self, regex: Regex.rawUrlPattern)
        
    }
    
    // Check if url is an image
    func isImage() -> Bool {
        
        return Regex.test(self, regex: Regex.imagePattern)
        
    }
    
}
