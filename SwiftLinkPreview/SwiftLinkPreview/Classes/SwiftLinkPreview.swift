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
    private let result: [String: AnyObject] = [
        "title": "",
        "url": "",
        "pageUrl": "",
        "canonicalUrl": "",
        "description": "",
        "images": []
    ]
    
    // MARK: - Constructor
    public init() {
        
    }
    
    // MARK: - Functions
    public func get(string: String!, onSuccess: ([String: AnyObject]) -> (), onError: (String) -> ()) {
        
        if let url = NSURL(string: string) {
            
            if UIApplication.sharedApplication().canOpenURL(url) {
                
                onSuccess(self.result)
                
            } else {
                
                onError(PreviewError.throwOut(.CannotBeOpened, url: url))
                
            }
            
        } else {
            
            onError(PreviewError.throwOut(.CannotBeOpened, url: string))
            
        }
        
    }
    
}
