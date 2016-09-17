//
//  SwiftLinkPreview.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 09/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//
import Foundation

open class SwiftLinkPreview: NSObject {
    
    // MARK: - Vars
    static let titleMinimumRelevant: Int = 15
    static let decriptionMinimumRelevant: Int = 100
    internal var url: URL!
    internal var text: String!
    internal var result: [String: AnyObject] = [:]
    fileprivate var wasOnMainThread = true
    fileprivate var task: URLSessionDataTask?
    fileprivate let session = URLSession.shared
    
    // MARK: - Constructor
    public override init() {
        super.init()
    }
    
    // MARK: - Functions
    // Make preview
    open func preview(_ text: String!, onSuccess: @escaping ([String: AnyObject]) -> (), onError: @escaping (PreviewError) -> ()) {
        
        self.resetResult()
        self.wasOnMainThread = Thread.isMainThread
        
        self.text = text
        
        if let url = self.extractURL() {
            
            self.url = url
            self.result["url"] = self.url.absoluteString as AnyObject?
            
            self.unshortenURL(url, completion: { unshortened in
                
                self.result["finalUrl"] = unshortened as AnyObject?
                
                self.result["canonicalUrl"] = self.extractCanonicalURL(unshortened) as AnyObject?
                
                self.extractInfo({
                    
                    onSuccess(self.result)
                    
                    }, onError: onError)
                
            })
            
        } else {
            onError(PreviewError.noURLHasBeenFound(self.text))
        }
        
    }
    
    // Reset data on result
    internal func resetResult() {
        
        self.result = ["url": "" as AnyObject,
                       "finalUrl": "" as AnyObject,
                       "canonicalUrl": "" as AnyObject,
                       "title": "" as AnyObject,
                       "description": "" as AnyObject,
                       "images": [] as AnyObject,
                       "image": "" as AnyObject]
        
    }
    
    // Fill remaining info about the crawling
    fileprivate func fillRemainingInfo(_ title: String, description: String, images: [String], image: String) {
        
        self.result["title"] = title as AnyObject?
        self.result["description"] = description as AnyObject?
        self.result["images"] = images as AnyObject?
        self.result["image"] = image as AnyObject?
        
    }
    
    // Cancel request
    open func cancel() {
        
        if let _ = self.task {
            
            self.task!.cancel()
            
        }
        
    }
    
}

// Extraction functions
extension SwiftLinkPreview {
    
    // Extract first URL from text
    internal func extractURL() -> URL? {
        
        let explosion = self.text.characters.split{$0 == " "}.map(String.init)
        let pieces = explosion.filter({ $0.trim.isValidURL() })
        let piece = pieces[0]
        
        if let url = URL(string: piece) {
            
            return url
            
        }
        
        return nil
        
    }
    
    // Unshorten URL by following redirections
    fileprivate func unshortenURL(_ url: URL, completion: @escaping (URL) -> ()) {
        
        self.task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if let finalResult = response?.url {
                
                if(finalResult.absoluteString == url.absoluteString) {
                    
                    if self.wasOnMainThread {
                        
                        DispatchQueue.main.async {
                            
                            completion(url)
                        }
                    }
                    else {
                        completion(url)
                    }
                    
                } else {
                    
                    self.task!.cancel()
                    self.unshortenURL(finalResult, completion: completion)
                    
                }
                
            } else {
                
                if self.wasOnMainThread {
                    
                    DispatchQueue.main.async {
                        
                        completion(url)
                    }
                }
                else {
                    completion(url)
                }
            }
            
        }) 
        
        if let _ = self.task {
            
            self.task!.resume()
            
        }
        
    }
    
    // Extract HTML code and the information contained on it
    fileprivate func extractInfo(_ completion: @escaping () -> (), onError: (PreviewError) -> ()) {
        
        if let url: URL = self.result["finalUrl"] as? URL {
            
            if(url.absoluteString.isImage()) {
                
                self.fillRemainingInfo("", description: "", images: [url.absoluteString], image: url.absoluteString)
                completion()
                
            } else {
                
                let sourceUrl = url.absoluteString.hasPrefix("http://") || url.absoluteString.hasPrefix("https://") ? url : URL(string: "http://\(url)")
                
                do {
                    
                    // Try to get the page with its default enconding
                    var source = try String(contentsOf: sourceUrl!).extendedTrim
                    
                    if self.wasOnMainThread {
                        
                        DispatchQueue.main.async {
                            
                            source = self.cleanSource(source)
                            
                            self.performPageCrawling(source)
                            
                            completion()
                        }
                    }
                    else {
                        source = self.cleanSource(source)
                        
                        self.performPageCrawling(source)
                        
                        completion()
                    }
                    
                } catch _ as NSError {
                    
                    self.tryAnotherEnconding(sourceUrl!, encodingArray: String.availableStringEncodings, completion: completion, onError: onError)
                    
                }
                
            }
            
        } else {
            
            self.fillRemainingInfo("", description: "", images: [], image: "")
            completion()
            
        }
        
    }
    
    // Try to get the page using another available encoding instead the page's own encoding
    private func tryAnotherEnconding(_ sourceUrl: URL, encodingArray: [String.Encoding], completion: @escaping () -> (), onError: (PreviewError) -> ()) {
        
        if encodingArray.isEmpty {
            onError(PreviewError.parseError(url.absoluteString))
        } else {
            
            do {
                
                var source = try String(contentsOf: sourceUrl, encoding: encodingArray[0]).extendedTrim
                
                if self.wasOnMainThread {
                    
                    DispatchQueue.main.async {
                        
                        source = self.cleanSource(source)
                        
                        self.performPageCrawling(source)
                        
                        completion()
                    }
                }
                else {
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
    private func cleanSource(_ source: String) -> String {
        
        var source = source
        source = source.deleteTagByPattern(Regex.inlineStylePattern)
        source = source.deleteTagByPattern(Regex.inlineScriptPattern)
        source = source.deleteTagByPattern(Regex.linkPattern)
        source = source.deleteTagByPattern(Regex.scriptPattern)
        source = source.deleteTagByPattern(Regex.commentPattern)
        
        return source
        
    }
    
    
    // Perform the page crawiling
    private func performPageCrawling(_ htmlCode: String) {
        
        var htmlCode = htmlCode
        
        self.crawlMetaTags(htmlCode)
        htmlCode = self.crawlTitle(htmlCode)
        htmlCode = self.crawlDescription(htmlCode)
        self.crawlImages(htmlCode)
        
    }
    
    
    // Extract canonical URL
    internal func extractCanonicalURL(_ finalUrl: URL!) -> String {
        
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
    fileprivate func extractBaseUrl(_ url: String) -> String {
        
        var url = url
        if let slash = url.range(of: "/") {
            
            let endIndex = url.characters.distance(from: url.startIndex, to: slash.upperBound)
            url = url.substring(0, end: endIndex > 1 ? endIndex - 1 : 0)
            
        }
        
        return url
        
    }
    
}

// Tag functions
extension SwiftLinkPreview {
    
    // Search for meta tags
    internal func crawlMetaTags(_ htmlCode: String) {
        
        let possibleTags = ["title", "description", "image"]
        let metatags = Regex.pregMatchAll(htmlCode, regex: Regex.metatagPattern, index: 1)
        
        for metatag in metatags {
            
            for tag in possibleTags {
                
                if (metatag.range(of: "property=\"og:\(tag)") != nil ||
                    metatag.range(of: "property='og:\(tag)") != nil ||
                    metatag.range(of: "name=\"twitter:\(tag)") != nil ||
                    metatag.range(of: "name='twitter:\(tag)") != nil ||
                    metatag.range(of: "name=\"\(tag)") != nil ||
                    metatag.range(of: "name='\(tag)") != nil ||
                    metatag.range(of: "itemprop=\"\(tag)") != nil ||
                    metatag.range(of: "itemprop='\(tag)") != nil) {
                    
                    if((self.result[tag] as! String).isEmpty) {
                        
                        if let value = Regex.pregMatchFirst(metatag, regex: Regex.metatagContentPattern, index: 2) {
                            
                            let value = value.decoded.extendedTrim
                            
                            self.result[tag] = (tag == "image" ? self.addImagePrefixIfNeeded(value) : value) as AnyObject
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    // Crawl for title if needed
    internal func crawlTitle(_ htmlCode: String) -> String {
        
        if let title: String = self.result["title"] as? String {
            
            if title.isEmpty {
                
                if let value = Regex.pregMatchFirst(htmlCode, regex: Regex.titlePattern, index: 2) {
                    
                    if value.isEmpty {
                        
                        let fromBody: String = self.crawlCode(htmlCode, minimum: SwiftLinkPreview.titleMinimumRelevant)
                        
                        if !fromBody.isEmpty {
                                
                                self.result["title"] = fromBody.decoded.extendedTrim as AnyObject?
                                
                                return htmlCode.replace(fromBody, with: "")
                                
                            }
                        
                    } else {
                        
                        self.result["title"] = value.decoded.extendedTrim as AnyObject?
                        
                    }
                    
                }
                
            }
            
        }
        
        return htmlCode
        
    }
    
    // Crawl for description if needed
    internal func crawlDescription(_ htmlCode: String) -> String {
        
        if let description: String = self.result["description"] as? String {
            
            if description.isEmpty {
                
                let value: String = self.crawlCode(htmlCode, minimum: SwiftLinkPreview.decriptionMinimumRelevant)
                
                if !value.isEmpty {
                    
                    self.result["description"] = value.decoded.extendedTrim as AnyObject?
                    
                }
                
            }
            
        }
        
        return htmlCode
        
    }
    
    // Crawl for images
    internal func crawlImages(_ htmlCode: String) {
        
        let mainImage: String = self.result["image"] as! String
        
        if mainImage.isEmpty {
            
            if let images: [String] = self.result["images"] as? [String] {
                
                if images.isEmpty {
                    
                    let values: [String] = Regex.pregMatchAll(htmlCode, regex: Regex.imageTagPattern, index: 2)
                    
                    if !values.isEmpty {
                        
                        var imgs: [String] = []
                        
                        for value in values {
                            
                            imgs.append(self.addImagePrefixIfNeeded(value))
                            
                        }
                        
                        self.result["images"] = imgs as AnyObject?
                        
                        if imgs.count > 0 {
                            
                            self.result["image"] = imgs[0] as AnyObject?
                            
                        }
                        
                    }
                    
                }
                
            }
            
        } else {
            
            self.result["images"] = [self.addImagePrefixIfNeeded(mainImage)] as AnyObject
            
        }
        
    }
    
    // Add prefix image if needed
    fileprivate func addImagePrefixIfNeeded(_ image: String) -> String {
        
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
    internal func crawlCode(_ content: String, minimum: Int) -> String {
        
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
    private func getTagContent(_ tag: String, content: String, minimum: Int) -> String {
        
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
