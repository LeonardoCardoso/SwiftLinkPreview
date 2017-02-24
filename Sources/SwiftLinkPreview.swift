//
//  SwiftLinkPreview.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 09/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//
import Foundation

public enum SwiftLinkResponseKey : String {
    case url
    case finalUrl
    case canonicalUrl
    case title
    case description
    case image
    case images
}

open class Cancellable {
    public private(set) var isCancelled : Bool = false
    
    open func cancel() {
        isCancelled = true
    }
}

open class SwiftLinkPreview {
    
    public typealias Response = [SwiftLinkResponseKey: Any]
    
    // MARK: - Vars
    static let titleMinimumRelevant: Int = 15
    static let decriptionMinimumRelevant: Int = 100
    
    public let session: URLSession
    public let workQueue: DispatchQueue
    public let responseQueue: DispatchQueue
    public let cache: Cache
    
    public static let defaultWorkQueue = DispatchQueue.global()
    
    // MARK: - Constructor
    public init(session: URLSession = URLSession.shared, workQueue: DispatchQueue = SwiftLinkPreview.defaultWorkQueue, responseQueue: DispatchQueue = DispatchQueue.main, cache: Cache = DisabledCache.instance) {
        self.workQueue = workQueue
        self.responseQueue = responseQueue
        self.cache = cache
        self.session = session
    }
    
    // MARK: - Functions
    // Make preview
    @discardableResult open func preview(_ text: String!, onSuccess: @escaping (Response) -> Void, onError: @escaping (PreviewError) -> Void) -> Cancellable {
        
        let cancellable = Cancellable()
        
        let successResponseQueue = { (response: Response) in
            if !cancellable.isCancelled {
            self.responseQueue.async {
                if !cancellable.isCancelled {
                    onSuccess(response)
                }
            }
            }
        }
        
        let errorResponseQueue = { (error: PreviewError) in
            if !cancellable.isCancelled {
            self.responseQueue.async {
                if !cancellable.isCancelled {
                onError(error)
                }
            }
            }
        }
        
        workQueue.async {
            if cancellable.isCancelled {return}
            
            if let url = self.extractURL(text: text) {
                if let result = self.cache.slp_getCachedResponse(url: url.absoluteString) {
                    successResponseQueue(result)
                } else {
                    self.unshortenURL(url, cancellable: cancellable, completion: { unshortened in
                        if let result = self.cache.slp_getCachedResponse(url: unshortened.absoluteString) {
                            successResponseQueue(result)
                        } else {
                            
                            let canonicalUrl = self.extractCanonicalURL(unshortened)
                            
                            self.extractInfo(unshortened, cancellable: cancellable, canonicalUrl: canonicalUrl, completion: { result in
                                
                                var result = result
                                
                                result[.url] = url
                                result[.finalUrl] = unshortened
                                result[.canonicalUrl] = canonicalUrl
                                
                                self.cache.slp_setCachedResponse(url: unshortened.absoluteString, response: result)
                                self.cache.slp_setCachedResponse(url: url.absoluteString, response: result)
                                
                                successResponseQueue(result)
                            }, onError: errorResponseQueue)
                        }
                    }, onError: errorResponseQueue)
                }
            } else {
                onError(PreviewError.noURLHasBeenFound(text))
            }
        }
        
        return cancellable
    }
}

// Extraction functions
extension SwiftLinkPreview {
    
    // Extract first URL from text
    internal func extractURL(text: String) -> URL? {
        let pieces: [String] = text.components(separatedBy: " ").filter { $0.trim.isValidURL() }
        if pieces.count > 0, let url = URL(string: pieces[0]) {
            return url
        }
        return nil
    }
    
    // Unshorten URL by following redirections
    fileprivate func unshortenURL(_ url: URL, cancellable: Cancellable, completion: @escaping (URL) -> Void, onError: @escaping (PreviewError) -> Void) {
        
        if cancellable.isCancelled {return}
        
        var task: URLSessionDataTask? = nil
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        
        task = session.dataTask(with: request, completionHandler: { data, response, error in
            if let _ = error {
                self.workQueue.async {
                    if !cancellable.isCancelled {
                        onError(PreviewError.cannotBeOpened(url.absoluteString))
                    }
                }
                task = nil
            } else {
                if let finalResult = response?.url {
                    if (finalResult.absoluteString == url.absoluteString) {
                        self.workQueue.async {
                            if !cancellable.isCancelled {
                                completion(url)
                            }
                        }
                        task = nil
                    } else {
                        task!.cancel()
                        task = nil
                        self.unshortenURL(finalResult, cancellable: cancellable, completion: completion, onError: onError)
                    }
                } else {
                    self.workQueue.async {
                        if !cancellable.isCancelled {
                            completion(url)
                        }
                    }
                    task = nil
                }
            }
        }) 
        
        if let task = task {
            task.resume()
        } else {
            self.workQueue.async {
                if !cancellable.isCancelled {
                    onError(PreviewError.cannotBeOpened(url.absoluteString))
                }
            }
        }
    }
    
    // Extract HTML code and the information contained on it
    fileprivate func extractInfo(_ url: URL, cancellable: Cancellable, canonicalUrl: String?, completion: @escaping (Response) -> Void, onError: (PreviewError) -> ()) {
        if cancellable.isCancelled {return}
        
        if(url.absoluteString.isImage()) {
            var result = Response()
            
            result[.title] = ""
            result[.description] = ""
            result[.images] = [url.absoluteString]
            result[.image] = [url.absoluteString]
            
            completion(result)
        } else {
            let sourceUrl = url.absoluteString.hasPrefix("http://") || url.absoluteString.hasPrefix("https://") ? url : URL(string: "http://\(url)")
            do {
                let data = try Data(contentsOf: sourceUrl!)
                var source: NSString? = nil
                NSString.stringEncoding(for: data, encodingOptions: nil, convertedString: &source, usedLossyConversion: nil)
                
                if let source = source {
                    if !cancellable.isCancelled {
                        self.parseHtmlString(source as String, canonicalUrl: canonicalUrl, completion: completion)
                    }
                } else {
                    if !cancellable.isCancelled {
                        onError(.parseError(sourceUrl!.absoluteString))
                    }
                }
            } catch {
                if !cancellable.isCancelled {
                    onError(.cannotBeOpened(sourceUrl!.absoluteString))
                }
            }
        }
    }
    
    
    private func parseHtmlString(_ htmlString: String, canonicalUrl: String?, completion: @escaping (Response) -> Void) {
            completion(self.performPageCrawling(self.cleanSource(htmlString), canonicalUrl: canonicalUrl))
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
    private func performPageCrawling(_ htmlCode: String, canonicalUrl: String?) -> Response {
        let result = self.crawlMetaTags(htmlCode, canonicalUrl: canonicalUrl, result: Response())
        
        var response = self.crawlTitle(htmlCode, result: result)
        
        response = self.crawlDescription(response.htmlCode, result: response.result)
        
        return self.crawlImages(response.htmlCode, canonicalUrl: canonicalUrl, result: response.result)
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
    internal func crawlMetaTags(_ htmlCode: String, canonicalUrl: String?, result: Response) -> Response {
        
        var result = result
        
        let possibleTags: [String] = [
            SwiftLinkResponseKey.title.rawValue,
            SwiftLinkResponseKey.description.rawValue,
            SwiftLinkResponseKey.image.rawValue
        ]
        
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
                    
                    let key = SwiftLinkResponseKey(rawValue: tag)!
                    
                    if (result[key] == nil) {
                        if let value = Regex.pregMatchFirst(metatag, regex: Regex.metatagContentPattern, index: 2) {
                            let value = value.decoded.extendedTrim
                            result[key] = (tag == "image" ? self.addImagePrefixIfNeeded(value, canonicalUrl: canonicalUrl) : value)
                        }
                    }
                }
            }
        }
        
        return result
    }
    
    // Crawl for title if needed
    internal func crawlTitle(_ htmlCode: String, result: Response) -> (htmlCode: String, result: Response) {
        var result = result
        let title = result[.title] as? String
        
        if title == nil || title?.isEmpty ?? true {
            if let value = Regex.pregMatchFirst(htmlCode, regex: Regex.titlePattern, index: 2) {
                if value.isEmpty {
                    let fromBody: String = self.crawlCode(htmlCode, minimum: SwiftLinkPreview.titleMinimumRelevant)
                    if !fromBody.isEmpty {
                        result[.title] = fromBody.decoded.extendedTrim
                        return (htmlCode.replace(fromBody, with: ""), result)
                    }
                } else {
                    result[.title] = value.decoded.extendedTrim
                }
            }
        }
        
        return (htmlCode, result)
    }
    
    // Crawl for description if needed
    internal func crawlDescription(_ htmlCode: String, result: Response) -> (htmlCode: String, result: Response) {
        var result = result
        let description = result[.description] as? String
        
        if description == nil || description?.isEmpty ?? true {
            let value: String = self.crawlCode(htmlCode, minimum: SwiftLinkPreview.decriptionMinimumRelevant)
            if !value.isEmpty {
                result[.description] = value.decoded.extendedTrim
            }
        }
        
        return (htmlCode, result)
    }
    
    // Crawl for images
    internal func crawlImages(_ htmlCode: String, canonicalUrl: String?, result: Response) -> Response {
        
        var result = result
        
        let mainImage = result[.image] as? String
        
        if mainImage == nil || mainImage?.isEmpty ?? true {
            
            let images = result[.images] as? [String]
            
            if images == nil || images?.isEmpty ?? true {
                let values = Regex.pregMatchAll(htmlCode, regex: Regex.imageTagPattern, index: 2)
                if !values.isEmpty {
                    var imgs = values.map { self.addImagePrefixIfNeeded($0, canonicalUrl: canonicalUrl) }
                        
                    result[.images] = imgs
                    result[.image] = imgs[0]
                }
            }
        } else {
            result[.images] = [self.addImagePrefixIfNeeded(mainImage!, canonicalUrl: canonicalUrl)]
        }
        return result
    }
    
    // Add prefix image if needed
    fileprivate func addImagePrefixIfNeeded(_ image: String, canonicalUrl: String?) -> String {
        
        var image = image
        
        if let canonicalUrl = canonicalUrl {
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
