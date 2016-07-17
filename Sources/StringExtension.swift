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
        
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
    }
    
    // Remove extra white spaces
    var extendedTrim: String {
        
        let components = self.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return components.filter { !$0.isEmpty }.joinWithSeparator(" ").trim
        
    }
    
    // Decode HTML entities
    var decoded: String {
        
        let encodedData = self.dataUsingEncoding(NSUTF8StringEncoding)!
        let attributedOptions: [String: AnyObject] =
            [
                NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
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
    func deleteTagByPattern(pattern: String) -> String {
        
        return self.stringByReplacingOccurrencesOfString(pattern, withString: "", options: .RegularExpressionSearch, range: nil)
        
    }
    
    // Replace
    func replace(search: String, with: String) -> String {
        
        if let replaced: String = self.stringByReplacingOccurrencesOfString(search, withString: with) {
            
            return replaced
            
        } else {
            
            return self
            
        }
        
    }
    
    // Substring
    func substring(start: Int, end: Int) -> String {
        
        return self.substringWithRange(Range(self.startIndex.advancedBy(start) ..< self.startIndex.advancedBy(end)))
        
    }
    func substring(range: NSRange) -> String {
        
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