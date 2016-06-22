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
    static let minimumRelevant: Int = 120
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
                
                self.extractCanonicalURL()
                
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
                    
                    var htmlCode = try String(contentsOfURL: url)
                    htmlCode = htmlCode.extendedTrim
                    htmlCode = htmlCode.deleteHTMLTag("script")
                    htmlCode = htmlCode.deleteHTMLTag("link")
                    htmlCode = htmlCode.deleteHTMLTag("path")
                    htmlCode = htmlCode.deleteHTMLTag("style")
                    htmlCode = htmlCode.deleteHtmlComments()
                    htmlCode = htmlCode.deleteCData()
                    
                    print("\(htmlCode)")
                    
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
    
    // Extract get canonical URL
    private func extractCanonicalURL() {
        
        if var canonicalUrl = Regex.pregMatchFirst((self.result["finalUrl"] as! NSURL).absoluteString, regex: Regex.cannonicalUrlPattern, index: 1) {
            
            canonicalUrl = canonicalUrl.replace("http://", with: "").replace("https://", with: "")
            
            if let slash = canonicalUrl.rangeOfString("/") {
                
                let endIndex = canonicalUrl.startIndex.distanceTo(slash.endIndex)
                canonicalUrl = canonicalUrl.substring(0, end: endIndex > 1 ? endIndex - 1 : 0)
                
            }
            
            self.result["canonicalUrl"] = canonicalUrl
            
        } else {
            
            self.result["canonicalUrl"] = self.result["url"]
            
        }
        
    }
    
}

// Tag functions
extension SwiftLinkPreview {
    
    // Search for meta tags
    private func crawlMetaTags(htmlCode: String) {
        
        let index = 1
        
        let possibleTags = ["title", "description", "image"]
        let metatags = Regex.pregMatchAll(htmlCode, regex: Regex.metatagPattern, index: index)
        
        for metatag in metatags {
            
            for tag in possibleTags {
                
                if (metatag.rangeOfString("property=\"og:\(tag)\"") != nil ||
                    metatag.rangeOfString("property='og:\(tag)'") != nil ||
                    metatag.rangeOfString("property=\"twitter:\(tag)\"") != nil ||
                    metatag.rangeOfString("property='twitter:\(tag)'") != nil ||
                    metatag.rangeOfString("name=\"\(tag)\"") != nil ||
                    metatag.rangeOfString("name='\(tag)'") != nil) {
                    
                    if((self.result[tag] as! String).isEmpty) {
                        
                        if let value = Regex.pregMatchFirst(metatag, regex: Regex.metatagContentPattern, index: 2) {
                            
                            self.result[tag] = value.decoded
                            
                        }
                        
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
                    
                    self.result["title"] = value.decoded
                    
                }
                
            }
            
        }
        
    }
    
    // Crawl for description if needed
    private func crawlDescription(htmlCode: String) {
        
        if let description: String = self.result["description"] as? String {
            
            if description.isEmpty {
                
                if let value: String = self.crawlCode(htmlCode) {
                    
                    self.result["description"] = value
                    
                }
                
            }
            
        }
        
    }
    
    // Crawl for images
    private func crawlImages(htmlCode: String) {
        
        let mainImage: String = self.result["image"] as! String
        
        if mainImage.isEmpty {
            
            if let images: [String] = self.result["images"] as? [String] {
                
                if images.isEmpty {
                    
                    if let values: [String] = Regex.pregMatchAll(htmlCode, regex: Regex.imageTagPattern, index: 3) {
                        
                        var imgs: [String] = []
                        
                        for value in values {
                            
                            var value = value
                            
                            if !value.hasPrefix("https://") && !value.hasPrefix("http://") && !value.hasPrefix("ftp://") {
                                
                                value = (self.result["finalUrl"] as! NSURL).absoluteString + value
                                
                            }
                            
                            imgs.append(value)
                            
                        }
                        
                        self.result["images"] = imgs
                        
                        
                        if imgs.count > 0 {
                            
                            self.result["image"] = imgs[0]
                            
                        }
                        
                    }
                    
                }
                
            }
            
        } else {
            
            self.result["images"] = [mainImage]
            
        }
        
    }
    
    // Crawl the entire code
    private func crawlCode(content: String) -> String {
        
        let resultSpan = self.getTagContent("span", content: content)
        let resultParagraph = self.getTagContent("p", content: content)
        let resultDiv = self.getTagContent("div", content: content)
        var result = resultSpan
        
        if (resultParagraph.characters.count > result.characters.count) {
            
            if (resultParagraph.characters.count >= resultDiv.characters.count) {
                
                result = resultParagraph
                
            } else {
                
                result = resultDiv
                
            }
            
        }
        
        return result
        
    }
    
    
    private func getTagContent(tag: String, content: String) -> String {
        
        let pattern = Regex.tagPattern(tag)
        var result = ""
        var currentMatch = ""
        
        let index = 2
        let matches = Regex.pregMatchAll(content, regex: pattern, index: index)
        
        for match in matches {
            
            currentMatch = match.extendedTrim.tagsStripped
            
            if (currentMatch.characters.count >= SwiftLinkPreview.minimumRelevant) {
                
                result = match
                break
                
            }
            
        }
        
        if result.isEmpty {
            
            if let match = Regex.pregMatchFirst(content, regex: pattern, index: 2) {
                
                result = match.extendedTrim.tagsStripped
                
            }
            
        }
        
        return result.decoded
        
    }
    
}
