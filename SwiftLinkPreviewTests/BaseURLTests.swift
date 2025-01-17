//
//  BaseURLTests.swift
//  SwiftLinkPreviewTests
//
//  Created by Leonardo Cardoso on 23.09.21.
//  Copyright © 2021 leocardz.com. All rights reserved.
//

@testable import SwiftLinkPreview
import XCTest

// This class tests head meta info
final class BaseURLTests: XCTestCase {
    // MARK: - Vars

    var baseTemplate = ""
    let slp = SwiftLinkPreview()

    // MARK: - SetUps

    // Those setup functions get that template, and fulfil determinated areas with rand texts, images and tags
    override func setUp() {
        super.setUp()

        baseTemplate = File.toString(Constants.headMetaBase)
    }

    // MARK: - Base

    func setUpBaseAndRun() {
        var baseTemplate = self.baseTemplate
        baseTemplate = baseTemplate.replace(Constants.headRandom, with: String.randomTag())
        baseTemplate = baseTemplate.replace(Constants.bodyRandom, with: String.randomTag()).extendedTrim

        let result = slp.crawlMetaBase(baseTemplate, result: Response())

        XCTAssertEqual(result.baseURL, "https://host/resource/index/")
    }

    func testBase() {
        for _ in 0 ..< 100 {
            setUpBaseAndRun()
        }
    }

    func testResultBase() {
        XCTAssertEqual(
            slp.formatImageURLs(["assets/test.png"], base: "https://host/resource/index/")?.first,
            "https://host/resource/index/assets/test.png"
        )
    }
}
