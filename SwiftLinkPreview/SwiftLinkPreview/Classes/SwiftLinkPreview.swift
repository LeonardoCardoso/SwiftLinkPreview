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
    
    // MARK: - Constructor
    public init() {
        
    }
    
    // MARK: - Functions
    public func get(text: String!, onSuccess: ([String: AnyObject]) -> (), onError: (PreviewError) -> ()) {
        
        self.text = text
        
        if let url = self.extractURL() {
            
            self.url = url
            self.result["url"] = self.url.absoluteString
            self.unshortenURL(url, completion: { unshortened in
                
                self.result["finalURL"] = unshortened
                onSuccess(self.result)
                
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
                
                if self.isValidURL(url) {
                    
                    return url
                    
                }
                
            }
            
        }
        
        return nil
        
    }
    
    // Check URL validity
    private func isValidURL(url: NSURL) -> Bool {
        
        return Regex.test(url.absoluteString, regex: Regex.rawURLPattern) && UIApplication.sharedApplication().canOpenURL(url)
        
    }
    
    // Unshorten URL
    private func unshortenURL(url: NSURL, completion: (NSURL) -> ()) {
        
        Alamofire.request(.GET, url.absoluteString, parameters: [:])
            .response { request, response, data, error in
                
                if let finalResult = response?.URL {
                    
                    if(finalResult.absoluteString == url.absoluteString) {
                        
                        completion(url)
                    
                    } else {
                        
                        print(response?.URL)
                        self.unshortenURL(finalResult, completion: completion)
                    
                    }
                    
                } else {
                    
                    completion(url)
                    
                }
                
        }
        
    }
    
}
