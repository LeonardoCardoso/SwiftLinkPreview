//
//  TitleTests.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 05/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

@testable import SwiftLinkPreview
import XCTest

// This class tests head title
final class TitleTests: XCTestCase {
    // MARK: - Vars

    var titleTemplate = ""
    let slp = SwiftLinkPreview()

    // MARK: - SetUps

    // Those setup functions get that template, and fulfil determinated areas with rand texts, images and tags
    override func setUp() {
        super.setUp()

        titleTemplate = File.toString(Constants.headTitle)
    }

    // MARK: - Title

    func setUpTitle() throws {
        let metaData =
            [
                Constants.title: String.randomText(),
                Constants.headRandom: String.randomTag(),
                Constants.bodyRandom: String.randomTag(),
            ]

        var metaTemplate = titleTemplate
        let title = try XCTUnwrap(metaData[Constants.title])
        let headRandom = try XCTUnwrap(metaData[Constants.headRandom])
        let bodyRandom = try XCTUnwrap(metaData[Constants.bodyRandom])
        metaTemplate = metaTemplate.replace(Constants.headRandomPre, with: headRandom)
        metaTemplate = metaTemplate.replace(Constants.headRandomPos, with: headRandom)

        metaTemplate = metaTemplate.replace(Constants.title, with: title)

        metaTemplate = metaTemplate.replace(Constants.bodyRandom, with: bodyRandom).extendedTrim

        let response = slp.crawlTitle(metaTemplate, result: Response())

        let comparable = response.result.title
        let comparison = comparable == title.decoded.extendedTrim ||
            comparable == headRandom.decoded.extendedTrim ||
            comparable == bodyRandom.decoded.extendedTrim

        XCTAssert(comparison)
    }

    func testTitle() throws {
        for _ in 0 ..< 100 {
            try setUpTitle()
        }
    }
}
