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
    
    static let imagePattern = "(.+?)\\.(gif|jpg|jpeg|png|bmp)$"
    static let imageTagPattern = "<img(.+?)src=\"([^\"]+)\"(.+?)[/]?>"
    static let titlePattern = "<title(.*?)>(.*?)</title>"
    static let metatagPattern = "<meta(.*?)>"
    static let metatagContentPattern = "content=(\"(.*?)\")|('(.*?)')"
    static let cannonicalUrlPattern = "([^\\+&#@%\\?=~_\\|!:,;]+)"
    static let rawUrlPattern = "((http[s]?|ftp|file)://)?((([-a-zA-Z0-9]+\\.)|\\.)+[-a-zA-Z0-9]+)[-a-zA-Z0-9+&@#/%?=~_|!:,\\.;]*"
    static let rawTagPattern = "<[^>]+>"
    static let inlineStylePattern = "<style(.*?)>(.*?)</style>"
    static let inlineScriptPattern = "<script(.*?)>(.*?)</script>"
    static let linkPattern = "<link(.*?)>"
    static let scriptPattern = "<script(.*?)>"
    static let commentPattern = "<!--(.*?)-->"
    
    // Test regular expression
    static func test(_ string: String!, regex: String!) -> Bool {
        
        return Regex.pregMatchFirst(string, regex: regex) != nil
        
    }
    
    // Match first occurrency
    static func pregMatchFirst(_ string: String!, regex: String!, index: Int = 0) -> String? {
        
        do{
            
            let rx = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            
            if let match = rx.firstMatch(in: string, options: [], range: NSMakeRange(0, string.characters.count)) {
                
                var result: [String] = Regex.stringMatches([match], text: string, index: index)
                return result.count == 0 ? nil : result[0]
                
            } else {
                
                return nil
                
            }
            
        } catch {
            
            return nil
            
        }
        
    }
    
    // Match all occurrencies
    static func pregMatchAll(_ string: String!, regex: String!, index: Int = 0) -> [String] {
        
        do{
            
            let rx = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            
            let matches: [NSTextCheckingResult] = rx.matches(in: string, options: [], range: NSMakeRange(0, string.characters.count))
            
            return !matches.isEmpty ? Regex.stringMatches(matches, text: string, index: index) : []
            
        } catch {
            
            return []
            
        }
        
    }
    
    // Extract matches from string
    static func stringMatches(_ results: [NSTextCheckingResult], text: String, index: Int = 0) -> [String] {
        
        return results.map {
            let range = $0.rangeAt(index)
            if text.characters.count > range.location + range.length {
                return (text as NSString).substring(with: range)
            }
            else {
                return ""
            }
        }
        
    }
    
    // Return tag pattern
    static func tagPattern(_ tag: String) -> String {
        
        return "<" + tag + "(.*?)>(.*?)</" + tag + ">"
        
    }
    
}
