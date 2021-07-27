//
//  VideoTests.swift
//  SwiftLinkPreviewTests
//
//  Created by Jeff Hodsdon on 4/15/21.
//  Copyright © 2021 leocardz.com. All rights reserved.
//

import XCTest
@testable import SwiftLinkPreview

// This class tests videos
class VideoTests: XCTestCase {

    // MARK: - Vars
    let slp = SwiftLinkPreview()

    
    func testImgur() {
        do {

            let source = try String(contentsOf: URL(string: "https://imgur.com/GaI4Ruu")!).extendedTrim

            let result = self.slp.crawlMetaTags(source, result: Response())

            XCTAssert(result.video != nil)

        } catch let err as NSError {

            print("\(err)")

        }
    }
    
    func testGfycat() {
        do {

            let source = try String(contentsOf: URL(string: "https://gfycat.com/ifr/ElementaryRemoteGavial")!).extendedTrim

            let result = self.slp.crawlMetaTags(source, result: Response())

            XCTAssert(result.video != nil)

        } catch let err as NSError {

            print("\(err)")

        }
    }
}
