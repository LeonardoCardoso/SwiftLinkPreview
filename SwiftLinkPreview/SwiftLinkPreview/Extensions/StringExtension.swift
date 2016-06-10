//
//  StringExtension.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 09/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import Foundation

extension String {
    
    // Trim
    var trim: String {
        
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
    }
    
    // Replace
    func replace(search: String, with: String) -> String {
        
        if let clearWith: String = with.stringByReplacingOccurrencesOfString(" ", withString: ""),
            let replaced: String = self.stringByReplacingOccurrencesOfString(search, withString: clearWith) {
            
            return replaced
            
        } else {
            
            return self
            
        }
        
    }
    
    // Substring
    func substring(start: Int, end: Int) -> String {
        
        return self.substringWithRange(Range(self.startIndex.advancedBy(start) ..< self.startIndex.advancedBy(end)))
        
    }
    
}