//
//  PreviewError.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 09/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import Foundation

// MARK: - Error enum
public enum PreviewError: String {
    
    case InvalidURL = "This data is not valid URL"
    case CannotBeOpened = "This URL cannot be opened"
    
    public static func throwOut(type: PreviewError, url: NSURL) -> String {
        
        return type.rawValue + ": \(url.absoluteString)"
        
    }
    
    public static func throwOut(type: PreviewError, url: String) -> String {
        
        return type.rawValue + ": \(url)"
        
    }
    
}
