//
//  BaseURLTests.swift
//  SwiftLinkPreviewTests
//
//  Created by Leonardo Cardoso on 23.09.21.
//  Copyright © 2021 leocardz.com. All rights reserved.
//

import XCTest
@testable import SwiftLinkPreview

// This class tests head meta info
class BaseURLTests: XCTestCase {

    // MARK: - Vars
    var baseTemplate = ""
    let slp = SwiftLinkPreview()

    // MARK: - SetUps
    // Those setup functions get that template, and fulfil determinated areas with rand texts, images and tags
    override func setUp() {
        super.setUp()

        self.baseTemplate = File.toString(Constants.headMetaBase)

    }

    // MARK: - Base
    func setUpBaseAndRun() {

        var baseTemplate = self.baseTemplate
        baseTemplate = baseTemplate.replace(Constants.headRandom, with: String.randomTag())
        baseTemplate = baseTemplate.replace(Constants.bodyRandom, with: String.randomTag()).extendedTrim

        let result = self.slp.crawlMetaBase(baseTemplate, result: Response())

        XCTAssertEqual(result.baseURL, "https://host/resource/index/")
    }

    func testBase() {

        for _ in 0 ..< 100 {

            self.setUpBaseAndRun()

        }

    }

    func testResultBase() {
        XCTAssertEqual(slp.formatImageURLs(["assets/test.png"], base: "https://host/resource/index/")?.first,
                       "https://host/resource/index/assets/test.png")
    }

}
