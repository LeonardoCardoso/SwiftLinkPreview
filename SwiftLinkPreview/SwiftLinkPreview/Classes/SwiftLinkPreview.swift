//
//  SwiftLinkPreview.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 09/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import Foundation
import Alamofire

public class SwiftLinkPreview {
    
    // MARK: - Vars
    private var text: String!
    private var url: NSURL!
    private var result: [String: AnyObject] = [:]
    private var request: Alamofire.Request?
    
    // MARK: - Constructor
    public init() {
        
    }
    
    // MARK: - Functions
    // Make preview
    public func preview(text: String!, onSuccess: ([String: AnyObject]) -> (), onError: (PreviewError) -> ()) {
        
        self.result = [
            "url": "",
            "finalUrl": "",
            "canonicalUrl": "",
            "title": "",
            "description": "",
            "images": [],
            "image": ""
        ]
        
        self.text = text
        
        if let url = self.extractURL() {
            
            self.url = url
            self.result["url"] = self.url.absoluteString
            
            self.unshortenURL(url, completion: { unshortened in
                
                self.result["finalUrl"] = unshortened
                
                self.extractCannonicalURL()
                
                self.extractInfo({
                    
                    onSuccess(self.result)
                    
                    }, onError: onError)
                
            })
            
        } else {
            
            onError(PreviewError(type: .NoURLHasBeenFound, url: self.text))
            
        }
        
    }
    
    // Fill remaining info about the crawling
    private func fillRemainingInfo(title: String, description: String, images: [String], image: String) {
        
        self.result["title"] = title
        self.result["description"] = description
        self.result["images"] = images
        self.result["image"] = image
        
    }
    
    // Cancel request
    public func cancel() {
        
        if let request = self.request {
            
            request.cancel()
            
        }
        
    }
    
}

// Extraction functions
extension SwiftLinkPreview {
    
    // Extract first URL from text
    private func extractURL() -> NSURL? {
        
        let explosion = self.text.characters.split{$0 == " "}.map(String.init)
        
        for var piece in explosion {
            
            piece = piece.trim
            
            if let url = NSURL(string: piece.trim) {
                
                if url.absoluteString.isValidURL() {
                    
                    return url
                    
                }
                
            }
            
        }
        
        return nil
        
    }
    
    // Unshorten URL by following redirections
    private func unshortenURL(url: NSURL, completion: (NSURL) -> ()) {
        
        request = Alamofire.request(.GET, url.absoluteString, parameters: [:])
            .response { request, response, data, error in
                
                if let finalResult = response?.URL {
                    
                    if(finalResult.absoluteString == url.absoluteString) {
                        
                        completion(url)
                        
                    } else {
                        
                        self.unshortenURL(finalResult, completion: completion)
                        
                    }
                    
                } else {
                    
                    completion(url)
                    
                }
                
        }
        
    }
    
    // Extract HTML code and the information contained on it
    private func extractInfo(completion: () -> (), onError: (PreviewError) -> ()) {
        
        if let url: NSURL = self.result["finalUrl"] as? NSURL {
            
            if(url.absoluteString.isImage()) {
                
                self.fillRemainingInfo("", description: "", images: [url.absoluteString], image: url.absoluteString)
                completion()
                
            } else {
                
                do {
                    
                    let htmlCode = try String(contentsOfURL: url)
                    
                    self.crawlMetaTags(htmlCode)
                    self.crawlTitle(htmlCode)
                    self.crawlDescription(htmlCode)
                    self.crawlImages(htmlCode)
                    
                    completion()
                    
                } catch _ as NSError {
                    
                    onError(PreviewError(type: .ParseError, url: url.absoluteString))
                    
                }
                
            }
            
        } else {
            
            self.fillRemainingInfo("", description: "", images: [], image: "")
            completion()
            
        }
        
    }
    
    // Extract get cannonical URL
    private func extractCannonicalURL() {
        
        if let canonicalUrl = Regex.pregMatchFirst((self.result["finalUrl"] as! NSURL).absoluteString, regex: Regex.cannonicalUrlPattern, index: 1) {
            
            let splitted = canonicalUrl.characters.split{$0 == "/"}.map(String.init)
            self.result["canonicalUrl"] = splitted[0]
            
        } else {
            
            self.result["canonicalUrl"] = self.result["url"]
            
        }
        
    }
    
}

// Tag functions
extension SwiftLinkPreview {
    
    // Search for meta tags
    private func crawlMetaTags(htmlCode: String) {
        
        let possibleTags = ["url", "title", "description", "image"]
        let metatags = Regex.pregMatchAll(htmlCode, regex: Regex.metatagPattern, index: 1)
        
        for metatag in metatags {
            
            for tag in possibleTags {
                
                if metatag.rangeOfString("property=\"og:" + tag + "\"") != nil ||
                    metatag.rangeOfString("property='og:" + tag + "'") != nil ||
                    metatag.rangeOfString("name=\"" + tag + "\"") != nil ||
                    metatag.rangeOfString("name='" + tag + "'") != nil {
                    
                    if let value = Regex.pregMatchFirst(metatag, regex: Regex.metatagContentPattern, index: 2) {
                        
                        self.result[tag] = value
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    // Crawl for title if needed
    private func crawlTitle(htmlCode: String) {
        
        if let title: String = self.result["title"] as? String {
            
            if title.isEmpty {
                
                if let value = Regex.pregMatchFirst(htmlCode, regex: Regex.tittlePattern, index: 2) {
                    
                    self.result["title"] = value
                    
                }
                
            }
            
        }
        
    }
    
    // Crawl for description if needed
    private func crawlDescription(htmlCode: String) {
        
        // TODO https://github.com/LeonardoCardoso/Android-Link-Preview/blob/master/library/src/main/java/com/leocardz/link/preview/library/TextCrawler.java#L116
        
    }
    
    // Crawl for images
    private func crawlImages(htmlCode: String) {
        
        // If has already an image on ["image"], don't crawl and just add ["image"] to the array
        // TODO https://github.com/LeonardoCardoso/Android-Link-Preview/blob/master/library/src/main/java/com/leocardz/link/preview/library/TextCrawler.java#L190
        
    }
    
}
