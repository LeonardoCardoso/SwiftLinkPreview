//
//  BodyTests.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 05/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import XCTest
@testable import SwiftLinkPreview

// This class tests body texts
class BodyTests: XCTestCase {

    // MARK: - Vars
    var spanTemplate = ""
    var pTemplate = ""
    var divTemplate = ""
    let slp = SwiftLinkPreview()

    // MARK: - SetUps
    // Those setup functions get that template, and fulfil determinated areas with rand texts, images and tags
    override func setUp() {
        super.setUp()

        self.spanTemplate = File.toString(Constants.bodyTextSpan)
        self.divTemplate = File.toString(Constants.bodyTextDiv)
        self.pTemplate = File.toString(Constants.bodyTextP)

    }

    // MARK: - Span
    func setUpSpan() {

        let metaData =
            [
                Constants.random1: String.randomText(),
                Constants.random2: String.randomText()
        ]

        var template = self.spanTemplate
        template = template.replace(Constants.headRandom, with: String.randomText())

        template = template.replace(Constants.random1, with: metaData[Constants.random1]!)
        template = template.replace(Constants.random2, with: metaData[Constants.random2]!)

        template = template.replace(Constants.tag1, with: String.randomText())
        template = template.replace(Constants.tag2, with: String.randomText())

        template = template.replace(Constants.bodyRandomPre, with: String.randomText())
        template = template.replace(Constants.bodyRandomMiddle, with: String.randomText())
        template = template.replace(Constants.bodyRandomPos, with: String.randomText()).extendedTrim

        let response = self.slp.crawlDescription(template, result: Response())

        let comparable = response.result.description

        XCTAssert(comparable == metaData[Constants.random1]!.decoded || comparable == metaData[Constants.random2]!.decoded)

    }

    func testSpan() {

        for _ in 0 ..< 100 {

            self.setUpSpan()

        }

    }

    // MARK: - Div
    func setUpDiv() {

        let metaData =
            [
                Constants.random1: String.randomText(),
                Constants.random2: String.randomText()
        ]

        var template = self.divTemplate
        template = template.replace(Constants.headRandom, with: String.randomText())

        template = template.replace(Constants.random1, with: metaData[Constants.random1]!)
        template = template.replace(Constants.random2, with: metaData[Constants.random2]!)

        template = template.replace(Constants.tag1, with: String.randomText())
        template = template.replace(Constants.tag2, with: String.randomText())

        template = template.replace(Constants.bodyRandomPre, with: String.randomText())
        template = template.replace(Constants.bodyRandomMiddle, with: String.randomText())
        template = template.replace(Constants.bodyRandomPos, with: String.randomText()).extendedTrim

        let response = self.slp.crawlDescription(template, result: Response())

        let comparable = response.result.description

        XCTAssert(comparable == metaData[Constants.random1]!.decoded || comparable == metaData[Constants.random2]!.decoded)

    }

    func testDiv() {

        for _ in 0 ..< 100 {

            self.setUpDiv()

        }

    }

    // MARK: - P
    func setUpP() {

        let metaData =
            [
                Constants.random1: String.randomText(),
                Constants.random2: String.randomText()
        ]

        var template = self.pTemplate
        template = template.replace(Constants.headRandom, with: String.randomText())

        template = template.replace(Constants.random1, with: metaData[Constants.random1]!)
        template = template.replace(Constants.random2, with: metaData[Constants.random2]!)

        template = template.replace(Constants.tag1, with: String.randomText())
        template = template.replace(Constants.tag2, with: String.randomText())

        template = template.replace(Constants.bodyRandomPre, with: String.randomText())
        template = template.replace(Constants.bodyRandomMiddle, with: String.randomText())
        template = template.replace(Constants.bodyRandomPos, with: String.randomText()).extendedTrim

        let response = self.slp.crawlDescription(template, result: Response())

        let comparable = response.result.description

        XCTAssert(comparable == metaData[Constants.random1]!.decoded || comparable == metaData[Constants.random2]!.decoded)

    }

    func testP() {

        for _ in 0 ..< 100 {

            self.setUpP()

        }

    }

}
