//
//  SwiftLinkPreview.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 09/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//
import Foundation

public class SwiftLinkPreview {
    
    // MARK: - Vars
    static let titleMinimumRelevant: Int = 15
    static let decriptionMinimumRelevant: Int = 100
    private var url: NSURL!
    private var task: NSURLSessionDataTask?
    private let session = NSURLSession.sharedSession()
    internal var text: String!
    internal var result: [String: AnyObject] = [:]
    
    // MARK: - Constructor
    public init() {
        
    }
    
    // MARK: - Functions
    // Make preview
    public func preview(text: String!, onSuccess: ([String: AnyObject]) -> (), onError: (PreviewError) -> ()) {
        
        self.resetResult()
        
        self.text = text
        
        if let url = self.extractURL() {
            
            self.url = url
            self.result["url"] = self.url.absoluteString
            
            self.unshortenURL(url, completion: { unshortened in
                
                self.result["finalUrl"] = unshortened
                
                self.result["canonicalUrl"] = self.extractCanonicalURL(unshortened)
                
                self.extractInfo({
                    
                    onSuccess(self.result)
                    
                    }, onError: onError)
                
            })
            
        } else {
            
            onError(PreviewError(type: .NoURLHasBeenFound, url: self.text))
            
        }
        
    }
    
    // Reset data on result
    internal func resetResult() {
        
        self.result = ["url": "",
                       "finalUrl": "",
                       "canonicalUrl": "",
                       "title": "",
                       "description": "",
                       "images": [],
                       "image": ""]
        
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
        
        if let _ = self.task {
            
            self.task!.cancel()
            
        }
        
    }
    
}

// Extraction functions
extension SwiftLinkPreview {
    
    // Extract first URL from text
    internal func extractURL() -> NSURL? {
        
        let explosion = self.text.characters.split{$0 == " "}.map(String.init)
        let pieces = explosion.filter({ $0.trim.isValidURL() })
        let piece = pieces[0]
        
        if let url = NSURL(string: piece) {
            
            return url
            
        }
        
        return nil
        
    }
    
    // Unshorten URL by following redirections
    private func unshortenURL(url: NSURL, completion: (NSURL) -> ()) {
        
        self.task = session.dataTaskWithURL(url) { data, response, error in
            
            if let finalResult = response?.URL {
                
                if(finalResult.absoluteString == url.absoluteString) {
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        completion(url)
                        
                    }
                    
                } else {
                    
                    self.task!.cancel()
                    self.unshortenURL(finalResult, completion: completion)
                    
                }
                
            } else {
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    completion(url)
                    
                }
                
            }
            
        }
        
        if let _ = self.task {
            
            self.task!.resume()
            
        }
        
    }
    
    // Extract HTML code and the information contained on it
    private func extractInfo(completion: () -> (), onError: (PreviewError) -> ()) {
        
        if let url: NSURL = self.result["finalUrl"] as? NSURL {
            
            if(url.absoluteString.isImage()) {
                
                self.fillRemainingInfo("", description: "", images: [url.absoluteString], image: url.absoluteString)
                completion()
                
            } else {
                
                let sourceUrl = url.absoluteString.hasPrefix("http://") || url.absoluteString.hasPrefix("https://") ? url : NSURL(string: "http://\(url)")
                
                do {
                    
                    // Try to get the page with its default enconding
                    var source = try String(contentsOfURL: sourceUrl!).extendedTrim
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        source = self.cleanSource(source)
                        
                        self.performPageCrawling(source)
                        
                        completion()
                        
                    }
                    
                } catch _ as NSError {
                    
                    self.tryAnotherEnconding(sourceUrl!, encodingArray: String.availableStringEncodings(), completion: completion, onError: onError)
                    
                }
                
            }
            
        } else {
            
            self.fillRemainingInfo("", description: "", images: [], image: "")
            completion()
            
        }
        
    }
    
    // Try to get the page using another available encoding instead the page's own encoding
    private func tryAnotherEnconding(sourceUrl: NSURL, encodingArray: [NSStringEncoding], completion: () -> (), onError: (PreviewError) -> ()) {
        
        if encodingArray.isEmpty {
            
            onError(PreviewError(type: .ParseError, url: url.absoluteString))
            
        } else {
            
            do {
                
                var source = try String(contentsOfURL: sourceUrl, encoding: encodingArray[0]).extendedTrim
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    source = self.cleanSource(source)
                    
                    self.performPageCrawling(source)
                    
                    completion()
                    
                }
                
            } catch _ as NSError {
                
                let availablEncodingArray = encodingArray.filter() { $0 != encodingArray[0] }
                self.tryAnotherEnconding(sourceUrl, encodingArray: availablEncodingArray, completion: completion, onError: onError)
                
            }
            
        }
        
    }
    
    // Removing unnecessary data from the source
    private func cleanSource(source: String) -> String {
        
        var source = source
        source = source.deleteTagByPattern(Regex.inlineStylePattern)
        source = source.deleteTagByPattern(Regex.inlineScriptPattern)
        source = source.deleteTagByPattern(Regex.linkPattern)
        source = source.deleteTagByPattern(Regex.scriptPattern)
        source = source.deleteTagByPattern(Regex.commentPattern)
        
        return source
        
    }
    
    
    // Perform the page crawiling
    private func performPageCrawling(htmlCode: String) {
        
        var htmlCode = htmlCode
        
        self.crawlMetaTags(htmlCode)
        htmlCode = self.crawlTitle(htmlCode)
        htmlCode = self.crawlDescription(htmlCode)
        self.crawlImages(htmlCode)
        
    }
    
    
    // Extract canonical URL
    internal func extractCanonicalURL(finalUrl: NSURL!) -> String {
        
        let preUrl: String = finalUrl.absoluteString
        let url = preUrl
            .replace("http://", with: "")
            .replace("https://", with: "")
            .replace("file://", with: "")
            .replace("ftp://", with: "")
        
        if preUrl != url {
            
            if let canonicalUrl = Regex.pregMatchFirst(url, regex: Regex.cannonicalUrlPattern, index: 1) {
                
                if(!canonicalUrl.isEmpty) {
                    
                    return self.extractBaseUrl(canonicalUrl)
                    
                } else {
                    
                    return self.extractBaseUrl(url)
                    
                }
                
            } else {
                
                return self.extractBaseUrl(url)
                
            }
            
        } else {
            
            return self.extractBaseUrl(preUrl)
            
        }
        
    }
    
    // Extract base URL
    private func extractBaseUrl(url: String) -> String {
        
        var url = url
        if let slash = url.rangeOfString("/") {
            
            let endIndex = url.startIndex.distanceTo(slash.endIndex)
            url = url.substring(0, end: endIndex > 1 ? endIndex - 1 : 0)
            
        }
        
        return url
        
    }
    
}

// Tag functions
extension SwiftLinkPreview {
    
    // Search for meta tags
    internal func crawlMetaTags(htmlCode: String) {
        
        let possibleTags = ["title", "description", "image"]
        let metatags = Regex.pregMatchAll(htmlCode, regex: Regex.metatagPattern, index: 1)
        
        for metatag in metatags {
            
            for tag in possibleTags {
                
                if (metatag.rangeOfString("property=\"og:\(tag)") != nil ||
                    metatag.rangeOfString("property='og:\(tag)") != nil ||
                    metatag.rangeOfString("name=\"twitter:\(tag)") != nil ||
                    metatag.rangeOfString("name='twitter:\(tag)") != nil ||
                    metatag.rangeOfString("name=\"\(tag)") != nil ||
                    metatag.rangeOfString("name='\(tag)") != nil ||
                    metatag.rangeOfString("itemprop=\"\(tag)") != nil ||
                    metatag.rangeOfString("itemprop='\(tag)") != nil) {
                    
                    if((self.result[tag] as! String).isEmpty) {
                        
                        if let value = Regex.pregMatchFirst(metatag, regex: Regex.metatagContentPattern, index: 2) {
                            
                            let value = value.decoded.extendedTrim
                            self.result[tag] = tag == "image" ? self.addImagePrefixIfNeeded(value) : value
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    // Crawl for title if needed
    internal func crawlTitle(htmlCode: String) -> String {
        
        if let title: String = self.result["title"] as? String {
            
            if title.isEmpty {
                
                if let value = Regex.pregMatchFirst(htmlCode, regex: Regex.titlePattern, index: 2) {
                    
                    if value.isEmpty {
                        
                        if let fromBody: String = self.crawlCode(htmlCode, minimum: SwiftLinkPreview.titleMinimumRelevant) {
                            
                            if !fromBody.isEmpty {
                                
                                self.result["title"] = fromBody.decoded.extendedTrim
                                
                                return htmlCode.replace(fromBody, with: "")
                                
                            }
                            
                        }
                        
                    } else {
                        
                        self.result["title"] = value.decoded.extendedTrim
                        
                    }
                    
                }
                
            }
            
        }
        
        return htmlCode
        
    }
    
    // Crawl for description if needed
    internal func crawlDescription(htmlCode: String) -> String {
        
        if let description: String = self.result["description"] as? String {
            
            if description.isEmpty {
                
                if let value: String = self.crawlCode(htmlCode, minimum: SwiftLinkPreview.decriptionMinimumRelevant) {
                    
                    self.result["description"] = value.decoded.extendedTrim
                    
                }
                
            }
            
        }
        
        return htmlCode
        
    }
    
    // Crawl for images
    internal func crawlImages(htmlCode: String) {
        
        let mainImage: String = self.result["image"] as! String
        
        if mainImage.isEmpty {
            
            if let images: [String] = self.result["images"] as? [String] {
                
                if images.isEmpty {
                    
                    if let values: [String] = Regex.pregMatchAll(htmlCode, regex: Regex.imageTagPattern, index: 2) {
                        
                        var imgs: [String] = []
                        
                        for value in values {
                            
                            imgs.append(self.addImagePrefixIfNeeded(value))
                            
                        }
                        
                        self.result["images"] = imgs
                        
                        if imgs.count > 0 {
                            
                            self.result["image"] = imgs[0]
                            
                        }
                        
                    }
                    
                }
                
            }
            
        } else {
            
            self.result["images"] = [self.addImagePrefixIfNeeded(mainImage)]
            
        }
        
    }
    
    // Add prefix image if needed
    private func addImagePrefixIfNeeded(image: String) -> String {
        
        var image = image
        
        if let canonicalUrl: String = self.result["canonicalUrl"] as? String {
            
            if image.hasPrefix("//") {
                
                image = "http:" + image
                
            } else if image.hasPrefix("/") {
                
                image = "http://" + canonicalUrl + image
                
            }
            
        }
        
        return image
        
    }
    
    // Crawl the entire code
    internal func crawlCode(content: String, minimum: Int) -> String {
        
        let resultFirstSearch = self.getTagContent("p", content: content, minimum: minimum)
        
        if (!resultFirstSearch.isEmpty) {
            
            return resultFirstSearch
            
        } else {
            
            let resultSecondSearch = self.getTagContent("div", content: content, minimum: minimum)
            
            if (!resultSecondSearch.isEmpty) {
                
                return resultSecondSearch
                
            } else {
                
                let resultThirdSearch = self.getTagContent("span", content: content, minimum: minimum)
                
                if (!resultThirdSearch.isEmpty) {
                    
                    return resultThirdSearch
                    
                } else {
                    
                    if (resultThirdSearch.characters.count >= resultFirstSearch.characters.count) {
                        
                        if (resultThirdSearch.characters.count >= resultThirdSearch.characters.count) {
                            
                            return resultThirdSearch
                            
                        } else {
                            
                            return resultThirdSearch
                            
                        }
                        
                    } else {
                        
                        return resultFirstSearch
                        
                    }
                    
                }
                
                
            }
            
        }
        
    }
    
    // Get tag content
    private func getTagContent(tag: String, content: String, minimum: Int) -> String {
        
        let pattern = Regex.tagPattern(tag)
        
        let index = 2
        let rawMatches = Regex.pregMatchAll(content, regex: pattern, index: index)
        
        let matches = rawMatches.filter({ $0.extendedTrim.tagsStripped.characters.count >= minimum })
        var result = matches.count > 0 ? matches[0] : ""
        
        if result.isEmpty {
            
            if let match = Regex.pregMatchFirst(content, regex: pattern, index: 2) {
                
                result = match.extendedTrim.tagsStripped
                
            }
            
        }
        
        return result
        
    }
    
}
