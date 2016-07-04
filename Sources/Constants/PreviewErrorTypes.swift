//
//  PreviewErrorTypes.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 09/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//
import Foundation

// MARK: - Error enum
public enum PreviewErrorType: String {
    
    case NoURLHasBeenFound = "No URL has been found"
    case InvalidURL = "This data is not valid URL"
    case CannotBeOpened = "This URL cannot be opened"
    case ParseError = "An error occurred when parsing the HTML"
    
}