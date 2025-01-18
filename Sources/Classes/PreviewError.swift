//
//  PreviewError.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 09/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//
import Foundation

public enum PreviewError: Error, Sendable, CustomStringConvertible {
    case noURLHasBeenFound(String?)
    case invalidURL(String?)
    case cannotBeOpened(String?)
    case parseError(String?)

    public var description: String {
        switch self {
        case let .noURLHasBeenFound(error):
            NSLocalizedString("No URL has been found. \(reason(error))", comment: String())
        case let .invalidURL(error):
            NSLocalizedString("This data is not valid URL. \(reason(error)).", comment: String())
        case let .cannotBeOpened(error):
            NSLocalizedString("This URL cannot be opened. \(reason(error)).", comment: String())
        case let .parseError(error):
            NSLocalizedString("An error occurred when parsing the HTML. \(reason(error)).", comment: String())
        }
    }

    private func reason(_ error: String?) -> String {
        "Reason: \(error ?? String())"
    }
}
