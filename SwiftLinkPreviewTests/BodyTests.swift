//
//  BodyTests.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 05/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

@testable import SwiftLinkPreview
import XCTest

// This class tests body texts
final class BodyTests: XCTestCase {
    // MARK: - Vars

    var spanTemplate = ""
    var pTemplate = ""
    var divTemplate = ""
    let slp = SwiftLinkPreview()

    // MARK: - SetUps

    // Those setup functions get that template, and fulfil determinated areas with rand texts, images and tags
    override func setUp() {
        super.setUp()

        spanTemplate = File.toString(Constants.bodyTextSpan)
        divTemplate = File.toString(Constants.bodyTextDiv)
        pTemplate = File.toString(Constants.bodyTextP)
    }

    // MARK: - Span

    func setUpSpan() throws {
        let metaData =
            [
                Constants.random1: String.randomText(),
                Constants.random2: String.randomText(),
            ]

        var template = spanTemplate
        template = template.replace(Constants.headRandom, with: String.randomText())

        let random1 = try XCTUnwrap(metaData[Constants.random1])
        let random2 = try XCTUnwrap(metaData[Constants.random2])
        template = template.replace(Constants.random1, with: random1)
        template = template.replace(Constants.random2, with: random2)

        template = template.replace(Constants.tag1, with: String.randomText())
        template = template.replace(Constants.tag2, with: String.randomText())

        template = template.replace(Constants.bodyRandomPre, with: String.randomText())
        template = template.replace(Constants.bodyRandomMiddle, with: String.randomText())
        template = template.replace(Constants.bodyRandomPos, with: String.randomText()).extendedTrim

        let response = slp.crawlDescription(template, result: Response())

        let comparable = response.result.description

        XCTAssert(comparable == random1.decoded || comparable == random2.decoded)
    }

    func testSpan() throws {
        for _ in 0 ..< 100 {
            try setUpSpan()
        }
    }

    // MARK: - Div

    func setUpDiv() throws {
        let metaData =
            [
                Constants.random1: String.randomText(),
                Constants.random2: String.randomText(),
            ]

        var template = divTemplate
        template = template.replace(Constants.headRandom, with: String.randomText())

        let random1 = try XCTUnwrap(metaData[Constants.random1])
        let random2 = try XCTUnwrap(metaData[Constants.random2])
        template = template.replace(Constants.random1, with: random1)
        template = template.replace(Constants.random2, with: random2)

        template = template.replace(Constants.tag1, with: String.randomText())
        template = template.replace(Constants.tag2, with: String.randomText())

        template = template.replace(Constants.bodyRandomPre, with: String.randomText())
        template = template.replace(Constants.bodyRandomMiddle, with: String.randomText())
        template = template.replace(Constants.bodyRandomPos, with: String.randomText()).extendedTrim

        let response = slp.crawlDescription(template, result: Response())

        let comparable = response.result.description

        XCTAssert(
            comparable == random1.decoded || comparable == random2.decoded
        )
    }

    func testDiv() throws {
        for _ in 0 ..< 100 {
            try setUpDiv()
        }
    }

    // MARK: - P

    func setUpP() throws {
        let metaData =
            [
                Constants.random1: String.randomText(),
                Constants.random2: String.randomText(),
            ]

        var template = pTemplate
        template = template.replace(Constants.headRandom, with: String.randomText())

        let random1 = try XCTUnwrap(metaData[Constants.random1])
        let random2 = try XCTUnwrap(metaData[Constants.random2])
        template = template.replace(Constants.random1, with: random1)
        template = template.replace(Constants.random2, with: random2)

        template = template.replace(Constants.tag1, with: String.randomText())
        template = template.replace(Constants.tag2, with: String.randomText())

        template = template.replace(Constants.bodyRandomPre, with: String.randomText())
        template = template.replace(Constants.bodyRandomMiddle, with: String.randomText())
        template = template.replace(Constants.bodyRandomPos, with: String.randomText()).extendedTrim

        let response = slp.crawlDescription(template, result: Response())

        let comparable = response.result.description

        XCTAssert(
            comparable == random1.decoded || comparable == random2.decoded
        )
    }

    func testP() throws {
        for _ in 0 ..< 100 {
            try setUpP()
        }
    }
}
