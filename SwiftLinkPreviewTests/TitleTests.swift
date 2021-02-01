//
//  BodyTests.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 05/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import XCTest
@testable import SwiftLinkPreview

// This class tests head title
class TitleTests: XCTestCase {

    // MARK: - Vars
    var titleTemplate = ""
    let slp = SwiftLinkPreview()

    // MARK: - SetUps
    // Those setup functions get that template, and fulfil determinated areas with rand texts, images and tags
    override func setUp() {
        super.setUp()

        self.titleTemplate = File.toString(Constants.headTitle)

    }

    // MARK: - Title
    func setUpTitle() {

        let metaData =
            [
                Constants.title: String.randomText(),
                Constants.headRandom: String.randomTag(),
                Constants.bodyRandom: String.randomTag()
        ]

        var metaTemplate = self.titleTemplate
        metaTemplate = metaTemplate.replace(Constants.headRandomPre, with: metaData[Constants.headRandom]!)
        metaTemplate = metaTemplate.replace(Constants.headRandomPos, with: metaData[Constants.headRandom]!)

        metaTemplate = metaTemplate.replace(Constants.title, with: metaData[Constants.title]!)

        metaTemplate = metaTemplate.replace(Constants.bodyRandom, with: metaData[Constants.bodyRandom]!).extendedTrim

        let response = self.slp.crawlTitle(metaTemplate, result: Response())

        let comparable = response.result.title
        let comparison = comparable == metaData[Constants.title]!.decoded.extendedTrim ||
            comparable == metaData[Constants.headRandom]!.decoded.extendedTrim ||
            comparable == metaData[Constants.bodyRandom]!.decoded.extendedTrim

        XCTAssert(comparison)

    }

    func testTitle() {

        for _ in 0 ..< 100 {

            self.setUpTitle()

        }

    }

}
