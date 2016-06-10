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
    
    static let imagePattern = "(.+?)\\.(jpg|png|gif|bmp)$"
    static let imageTagPattern = "<img(.*?)src=(\"|')(.+?)(gif|jpg|png|bmp)(\"|')(.*?)(/)?>(</img>)?"
    static let iconTagPattern = "<img(.*?)src=(\"|')(.+?)(gif|jpg|png|bmp)(\"|')(.*?)(/)?>(</img>)?"
    static let iconRevTagPattern = "<img(.*?)src=(\"|')(.+?)(gif|jpg|png|bmp)(\"|')(.*?)(/)?>(</img>)?"
    static let itempropImageTagPattern = "<img(.*?)src=(\"|')(.+?)(gif|jpg|png|bmp)(\"|')(.*?)(/)?>(</img>)?"
    static let itempropImageRevTagPattern = "<img(.*?)src=(\"|')(.+?)(gif|jpg|png|bmp)(\"|')(.*?)(/)?>(</img>)?"
    static let tittlePattern = "<title(.*?)>(.*?)</title>"
    static let scriptPattern = "<script(.*?)>(.*?)</script>"
    static let metatagPattern = "<meta(.*?)>"
    static let metatagContentPattern = "content=\"(.*?)\""
    static let urlPattern = "<\\b(https?|ftp|file)://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]>"
    
    
    // Test regular expression
    static func test(string: String, regex: String!) -> Bool {
        
        do{
            
            let rx = try NSRegularExpression(pattern: regex, options: [])
            
            if let _ = rx.firstMatchInString(string, options: [], range: NSMakeRange(0, string.characters.count)) {
                
                return true
                
            } else {
                
                return false
                
            }
            
        } catch {
            
            return false
            
        }
        
    }
    
}