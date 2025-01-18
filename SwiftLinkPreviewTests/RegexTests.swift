//
//  RegexTests.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 16/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

@testable import SwiftLinkPreview
import XCTest

// This class tests URLs
final class RegexTests: XCTestCase {
    // MARK: - Vars

    let slp = SwiftLinkPreview()

    // MARK: - Functions

    func testURL() {
        for url in URLs.bunch {
            let extracted = slp.extractURL(text: url[0])

            // print(extracted?.absoluteString, url[1])

            XCTAssertEqual(extracted?.absoluteString, url[1])
        }
    }

    func testCanonicalURL() {
        for url in URLs.bunch {
            let finalUrl = URL(string: url[1])

            let canonical = slp.extractCanonicalURL(finalUrl!)

            // print(canonical, url[2])

            XCTAssertEqual(canonical, url[2])
        }
    }
}
