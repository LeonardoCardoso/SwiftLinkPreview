//
//  MetaTests.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 05/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

@testable import SwiftLinkPreview
import XCTest

// This class tests head meta info
final class MetaTests: XCTestCase {
    // MARK: - Vars

    var twitterTemplate = ""
    var facebookTemplate = ""
    var itempropTemplate = ""
    var metaTemplate = ""
    let slp = SwiftLinkPreview()

    // MARK: - SetUps

    override func setUpWithError() throws {
        try super.setUpWithError()

        twitterTemplate = try File.toString(Constants.headMetaTwitter)
        facebookTemplate = try File.toString(Constants.headMetaFacebook)
        itempropTemplate = try File.toString(Constants.headMetaItemprop)
        metaTemplate = try File.toString(Constants.headMetaMeta)
    }

    // MARK: - Twitter

    func setUpTwitterAndRun() throws {
        let twitterData =
            [
                Constants.twitterTitle: String.randomText(),
                Constants.twitterSite: String.randomUrl(),
                Constants.twitterDescription: String.randomText(),
                Constants.twitterImageSrc: String.randomImage(),
            ]

        let twitterTitle = try XCTUnwrap(twitterData[Constants.twitterTitle])
        let twitterSite = try XCTUnwrap(twitterData[Constants.twitterSite])
        let twitterDescription = try XCTUnwrap(twitterData[Constants.twitterDescription])
        let twitterImageSrc = try XCTUnwrap(twitterData[Constants.twitterImageSrc])

        var twitterTemplate = self.twitterTemplate
        twitterTemplate = twitterTemplate.replace(Constants.headRandomPre, with: String.randomTag())
        twitterTemplate = twitterTemplate.replace(Constants.headRandomPos, with: String.randomTag())

        twitterTemplate = twitterTemplate.replace(Constants.twitterTitle, with: twitterTitle)
        twitterTemplate = twitterTemplate.replace(Constants.twitterSite, with: twitterSite)
        twitterTemplate = twitterTemplate.replace(Constants.twitterDescription, with: twitterDescription)
        twitterTemplate = twitterTemplate.replace(Constants.twitterImageSrc, with: twitterImageSrc)

        twitterTemplate = twitterTemplate.replace(Constants.bodyRandom, with: String.randomTag()).extendedTrim

        let result = slp.crawlMetaTags(twitterTemplate, result: Response())

        XCTAssertEqual(result.title, twitterTitle.decoded)
        XCTAssertEqual(result.description, twitterDescription.decoded)
        XCTAssertEqual(result.image, twitterImageSrc)
    }

    func testTwitter() throws {
        for _ in 0 ..< 100 {
            try setUpTwitterAndRun()
        }
    }

    // MARK: - Facebook

    func setUpFacebookAndRun() throws {
        let facebookData =
            [
                Constants.facebookTitle: String.randomText(),
                Constants.facebookSite: String.randomUrl(),
                Constants.facebookDescription: String.randomText(),
                Constants.facebookImage: String.randomImage(),
            ]

        let facebookTitle = try XCTUnwrap(facebookData[Constants.facebookTitle])
        let facebookSite = try XCTUnwrap(facebookData[Constants.facebookSite])
        let facebookDescription = try XCTUnwrap(facebookData[Constants.facebookDescription])
        let facebookImage = try XCTUnwrap(facebookData[Constants.facebookImage])

        var facebookTemplate = self.facebookTemplate
        facebookTemplate = facebookTemplate.replace(Constants.headRandomPre, with: String.randomTag())
        facebookTemplate = facebookTemplate.replace(Constants.headRandomPos, with: String.randomTag())

        facebookTemplate = facebookTemplate.replace(Constants.facebookTitle, with: facebookTitle)
        facebookTemplate = facebookTemplate.replace(Constants.facebookSite, with: facebookSite)
        facebookTemplate = facebookTemplate.replace(Constants.facebookDescription, with: facebookDescription)
        facebookTemplate = facebookTemplate.replace(Constants.facebookImage, with: facebookImage)

        facebookTemplate = facebookTemplate.replace(Constants.bodyRandom, with: String.randomTag()).extendedTrim

        let result = slp.crawlMetaTags(facebookTemplate, result: Response())

        XCTAssertEqual(result.title, facebookTitle.decoded)
        XCTAssertEqual(result.description, facebookDescription.decoded)
        XCTAssertEqual(result.image, facebookImage)
    }

    func testFacebook() throws {
        for _ in 0 ..< 100 {
            try setUpFacebookAndRun()
        }
    }

    // MARK: - Itemprop

    func setUpItempropAndRun() throws {
        let itempropData =
            [
                Constants.title: String.randomText(),
                Constants.site: String.randomUrl(),
                Constants.description: String.randomText(),
                Constants.image: String.randomImage(),
            ]

        let title = try XCTUnwrap(itempropData[Constants.title])
        let site = try XCTUnwrap(itempropData[Constants.site])
        let description = try XCTUnwrap(itempropData[Constants.description])
        let image = try XCTUnwrap(itempropData[Constants.image])

        var itempropTemplate = self.itempropTemplate
        itempropTemplate = itempropTemplate.replace(Constants.headRandomPre, with: String.randomTag())
        itempropTemplate = itempropTemplate.replace(Constants.headRandomPos, with: String.randomTag())

        itempropTemplate = itempropTemplate.replace(Constants.title, with: title)
        itempropTemplate = itempropTemplate.replace(Constants.site, with: site)
        itempropTemplate = itempropTemplate.replace(Constants.description, with: description)
        itempropTemplate = itempropTemplate.replace(Constants.image, with: image)

        itempropTemplate = itempropTemplate.replace(Constants.bodyRandom, with: String.randomTag()).extendedTrim

        let result = slp.crawlMetaTags(itempropTemplate, result: Response())

        XCTAssertEqual(result.title, title.decoded)
        XCTAssertEqual(result.description, description.decoded)
        XCTAssertEqual(result.image, image)
    }

    func testItemprop() throws {
        for _ in 0 ..< 100 {
            try setUpItempropAndRun()
        }
    }

    // MARK: - Meta

    func setUpMetaAndRun() throws {
        let metaData =
            [
                Constants.title: String.randomText(),
                Constants.site: String.randomUrl(),
                Constants.description: String.randomText(),
                Constants.image: String.randomImage(),
            ]

        let title = try XCTUnwrap(metaData[Constants.title])
        let site = try XCTUnwrap(metaData[Constants.site])
        let description = try XCTUnwrap(metaData[Constants.description])
        let image = try XCTUnwrap(metaData[Constants.image])

        var metaTemplate = self.metaTemplate
        metaTemplate = metaTemplate.replace(Constants.headRandomPre, with: String.randomTag())
        metaTemplate = metaTemplate.replace(Constants.headRandomPos, with: String.randomTag())

        metaTemplate = metaTemplate.replace(Constants.title, with: title)
        metaTemplate = metaTemplate.replace(Constants.site, with: site)
        metaTemplate = metaTemplate.replace(Constants.description, with: description)
        metaTemplate = metaTemplate.replace(Constants.image, with: image)

        metaTemplate = metaTemplate.replace(Constants.bodyRandom, with: String.randomTag()).extendedTrim

        let result = slp.crawlMetaTags(metaTemplate, result: Response())

        XCTAssertEqual(result.title, title.decoded)
        XCTAssertEqual(result.description, description.decoded)
        XCTAssertEqual(result.image, image)
    }

    func testMeta() throws {
        for _ in 0 ..< 100 {
            try setUpMetaAndRun()
        }
    }
}
