//
//  VideoTests.swift
//  SwiftLinkPreviewTests
//
//  Created by Jeff Hodsdon on 4/15/21.
//  Copyright © 2021 leocardz.com. All rights reserved.
//

@testable import SwiftLinkPreview
import XCTest

// This final class tests videos
final class VideoTests: XCTestCase {
    // MARK: - Vars

    let slp = SwiftLinkPreview()

    func testImgur() throws {
        let url = try XCTUnwrap(URL(string: "https://imgur.com/GaI4Ruu"))
        let source = try String(contentsOf: url).extendedTrim

        let result = slp.crawlMetaTags(source, result: Response())

        XCTAssert(result.video != nil)
    }

    func testGiphy() throws {
        let url = try XCTUnwrap(URL(string: "https://giphy.com/gifs/cuddles-yPQcB2bQVBQ6k"))
        let source = try String(contentsOf: url).extendedTrim

        let result = slp.crawlMetaTags(source, result: Response())

        XCTAssert(result.video != nil)
    }
}
