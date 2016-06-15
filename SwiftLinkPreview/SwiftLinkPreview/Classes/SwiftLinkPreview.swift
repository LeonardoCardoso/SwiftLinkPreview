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
    private var result: [String: AnyObject] = [
        "title": "",
        "url": "",
        "finalUrl": "",
        "canonicalUrl": "",
        "description": "",
        "images": []
    ]
    private var request: Alamofire.Request?
    
    // MARK: - Constructor
    public init() {
        
    }
    
    // MARK: - Functions
    // Make preview
    public func preview(text: String!, onSuccess: ([String: AnyObject]) -> (), onError: (PreviewError) -> ()) {
        
        self.text = text
        
        if let url = self.extractURL() {
            
            self.url = url
            self.result["url"] = self.url.absoluteString
            
            self.unshortenURL(url, completion: { unshortened in
                
                self.result["finalUrl"] = unshortened
                
                // TODO get cannonical URL
                self.result["canonicalUrl"] = ""
                
                self.extractInfo({
                    
                    onSuccess(self.result)
                    
                })
                
            })
            
        } else {
            
            onError(PreviewError(type: .NoURLHasBeenFound, url: self.text))
            
        }
        
    }
    
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
    
    // Unshorten URL
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
    private func extractInfo(completion: () -> ()) {
        
        if let url: NSURL = self.result["finalUrl"] as? NSURL {
            
            if(url.absoluteString.isImage()) {
                
                NSLog("Completion 3")
                self.fillRemainingInfo("", description: "", images: [url])
                completion()
                
            } else {
                
                do {
                    
                    let myHTMLString = try String(contentsOfURL: url)
                    NSLog("\(myHTMLString)")
                    NSLog("Completion 2")
                    completion()
                    
                } catch let error as NSError {
                    
                    NSLog("\(error)")
                    NSLog("Completion 1")
                    completion()
                    
                }
                
            }
            
        } else {
            
            self.fillRemainingInfo("", description: "", images: [])
            completion()
            
        }
        
    }
    
    // Fill remaining info about the crawling
    private func fillRemainingInfo(title: String, description: String, images: [NSURL]) {
        
        self.result["title"] = title
        self.result["description"] = description
        self.result["images"] = images
        
    }
    
    // Cancel request
    public func cancel() {
        
        if let request = self.request {
            
            request.cancel()
            
        }
        
    }
    
}
