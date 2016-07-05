//
//  PreviewError.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 09/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//
import Foundation

// MARK: - Error enum
public class PreviewError {
    
    public var message: String?
    public var type: PreviewErrorType?
    
    public init(type: PreviewErrorType, url: NSURL) {
        
        self.type = type
        self.message = type.rawValue + ": \"\(url.absoluteString)\""
    
    }
    
    public init(type: PreviewErrorType, url: String){
        
        self.type = type
        self.message = type.rawValue + ": \"\(url)\""
        
    }
    
}
