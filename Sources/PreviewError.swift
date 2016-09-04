//
//  PreviewError.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 09/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//
import Foundation

public enum PreviewError: ErrorType, CustomStringConvertible {
  case NoURLHasBeenFound(String?)
  case InvalidURL(String?)
  case CannotBeOpened(String?)
  case ParseError(String?)
  
  public var description: String {
    switch(self) {
      case .NoURLHasBeenFound: return NSLocalizedString("No URL has been found", comment: "")
      case .InvalidURL: return NSLocalizedString("This data is not valid URL", comment: "")
      case .CannotBeOpened: return NSLocalizedString("This URL cannot be opened", comment: "")
      case .ParseError: return NSLocalizedString("An error occurred when parsing the HTML", comment: "")
    }
  }
}