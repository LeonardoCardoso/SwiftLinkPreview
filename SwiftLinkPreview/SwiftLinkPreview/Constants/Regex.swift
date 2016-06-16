//
//  Regex.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 09/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import Foundation

// MARK: - Regular expressions
class Regex {
    
    static let imagePattern = "(.+?)\\.(jp[e]?g|png|gif|bmp)$"
    static let imageTagPattern = "<img(.*?)src=(\"|')(.+?)(gif|jpg|png|bmp)(\"|')(.*?)(/)?>(</img>)?"
    static let iconTagPattern = "<img(.*?)src=(\"|')(.+?)(gif|jpg|png|bmp)(\"|')(.*?)(/)?>(</img>)?"
    static let iconRevTagPattern = "<img(.*?)src=(\"|')(.+?)(gif|jpg|png|bmp)(\"|')(.*?)(/)?>(</img>)?"
    static let itempropImageTagPattern = "<img(.*?)src=(\"|')(.+?)(gif|jpg|png|bmp)(\"|')(.*?)(/)?>(</img>)?"
    static let itempropImageRevTagPattern = "<img(.*?)src=(\"|')(.+?)(gif|jpg|png|bmp)(\"|')(.*?)(/)?>(</img>)?"
    static let tittlePattern = "<title(.*?)>(.*?)</title>"
    static let scriptPattern = "<script(.*?)>(.*?)</script>"
    static let metatagPattern = "<meta(.*?)>"
    static let metatagContentPattern = "content=(\"|')(.*?)(\"|')"
    static let urlPattern = "<\\b(http[s]?|ftp|file)://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]>"
    static let rawUrlPattern = "((http[s]?)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
    static let cannonicalUrlPattern = "http[s]?://(.*)[/]?"
    
    
    // Test regular expression
    static func test(string: String!, regex: String!) -> Bool {
        
        return Regex.pregMatchFirst(string, regex: regex) != nil
        
    }
    
    // Match all occurrencies
    static func pregMatchFirst(string: String!, regex: String!, index: Int = 0) -> String? {
        
        do{
            
            let rx = try NSRegularExpression(pattern: regex, options: [.CaseInsensitive])
            
            if let match = rx.firstMatchInString(string, options: [], range: NSMakeRange(0, string.characters.count)) {
                
                return string.substring(match.rangeAtIndex(index))
                
            } else {
                
                return nil
                
            }
            
        } catch {
            
            return nil
            
        }
        
    }
    
    // Match all occurrencies
    static func pregMatchAll(string: String!, regex: String!, index: Int = 0) -> [String] {
        
        do{
            
            let rx = try NSRegularExpression(pattern: regex, options: [.CaseInsensitive])
            
            if let matches: [NSTextCheckingResult] = rx.matchesInString(string, options: [], range: NSMakeRange(0, string.characters.count)) {
                
                var result: [String] = []
                
                for match in matches {
                    
                    result.append(string.substring(match.rangeAtIndex(index)))
                    
                }
                
                return result
                
            } else {
                
                return []
                
            }
            
            
        } catch {
            
            return []
            
        }
        
    }
    
}