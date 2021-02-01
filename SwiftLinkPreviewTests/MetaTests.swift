//
//  MetaTests.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 05/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import XCTest
@testable import SwiftLinkPreview

// This class tests head meta info
class MetaTests: XCTestCase {

    // MARK: - Vars
    var twitterTemplate = ""
    var facebookTemplate = ""
    var itempropTemplate = ""
    var metaTemplate = ""
    let slp = SwiftLinkPreview()

    // MARK: - SetUps
    // Those setup functions get that template, and fulfil determinated areas with rand texts, images and tags
    override func setUp() {
        super.setUp()

        self.twitterTemplate = File.toString(Constants.headMetaTwitter)
        self.facebookTemplate = File.toString(Constants.headMetaFacebook)
        self.itempropTemplate = File.toString(Constants.headMetaItemprop)
        self.metaTemplate = File.toString(Constants.headMetaMeta)

    }

    // MARK: - Twitter
    func setUpTwitterAndRun() {

        let twitterData =
            [
                Constants.twitterTitle: String.randomText(),
                Constants.twitterSite: String.randomUrl(),
                Constants.twitterDescription: String.randomText(),
                Constants.twitterImageSrc: String.randomImage()
        ]

        var twitterTemplate = self.twitterTemplate
        twitterTemplate = twitterTemplate.replace(Constants.headRandomPre, with: String.randomTag())
        twitterTemplate = twitterTemplate.replace(Constants.headRandomPos, with: String.randomTag())

        twitterTemplate = twitterTemplate.replace(Constants.twitterTitle, with: twitterData[Constants.twitterTitle]!)
        twitterTemplate = twitterTemplate.replace(Constants.twitterSite, with: twitterData[Constants.twitterSite]!)
        twitterTemplate = twitterTemplate.replace(Constants.twitterDescription, with: twitterData[Constants.twitterDescription]!)
        twitterTemplate = twitterTemplate.replace(Constants.twitterImageSrc, with: twitterData[Constants.twitterImageSrc]!)

        twitterTemplate = twitterTemplate.replace(Constants.bodyRandom, with: String.randomTag()).extendedTrim

        let result = self.slp.crawlMetaTags(twitterTemplate, result: Response())

        XCTAssertEqual(result.title, twitterData[Constants.twitterTitle]!.decoded)
        XCTAssertEqual(result.description, twitterData[Constants.twitterDescription]!.decoded)
        XCTAssertEqual(result.image, twitterData[Constants.twitterImageSrc])

    }

    func testTwitter() {

        for _ in 0 ..< 100 {

            self.setUpTwitterAndRun()

        }

    }

    // MARK: - Facebook
    func setUpFacebookAndRun() {

        let facebookData =
            [
                Constants.facebookTitle: String.randomText(),
                Constants.facebookSite: String.randomUrl(),
                Constants.facebookDescription: String.randomText(),
                Constants.facebookImage: String.randomImage()
        ]

        var facebookTemplate = self.facebookTemplate
        facebookTemplate = facebookTemplate.replace(Constants.headRandomPre, with: String.randomTag())
        facebookTemplate = facebookTemplate.replace(Constants.headRandomPos, with: String.randomTag())

        facebookTemplate = facebookTemplate.replace(Constants.facebookTitle, with: facebookData[Constants.facebookTitle]!)
        facebookTemplate = facebookTemplate.replace(Constants.facebookSite, with: facebookData[Constants.facebookSite]!)
        facebookTemplate = facebookTemplate.replace(Constants.facebookDescription, with: facebookData[Constants.facebookDescription]!)
        facebookTemplate = facebookTemplate.replace(Constants.facebookImage, with: facebookData[Constants.facebookImage]!)

        facebookTemplate = facebookTemplate.replace(Constants.bodyRandom, with: String.randomTag()).extendedTrim

        let result = self.slp.crawlMetaTags(facebookTemplate, result: Response())

        XCTAssertEqual(result.title, facebookData[Constants.facebookTitle]!.decoded)
        XCTAssertEqual(result.description, facebookData[Constants.facebookDescription]!.decoded)
        XCTAssertEqual(result.image, facebookData[Constants.facebookImage])
    }

    func testFacebook() {

        for _ in 0 ..< 100 {

            self.setUpFacebookAndRun()

        }

    }

    // MARK: - Facebook
    func setUpItempropAndRun() {

        let itempropData =
            [
                Constants.title: String.randomText(),
                Constants.site: String.randomUrl(),
                Constants.description: String.randomText(),
                Constants.image: String.randomImage()
        ]

        var itempropTemplate = self.itempropTemplate
        itempropTemplate = itempropTemplate.replace(Constants.headRandomPre, with: String.randomTag())
        itempropTemplate = itempropTemplate.replace(Constants.headRandomPos, with: String.randomTag())

        itempropTemplate = itempropTemplate.replace(Constants.title, with: itempropData[Constants.title]!)
        itempropTemplate = itempropTemplate.replace(Constants.site, with: itempropData[Constants.site]!)
        itempropTemplate = itempropTemplate.replace(Constants.description, with: itempropData[Constants.description]!)
        itempropTemplate = itempropTemplate.replace(Constants.image, with: itempropData[Constants.image]!)

        itempropTemplate = itempropTemplate.replace(Constants.bodyRandom, with: String.randomTag()).extendedTrim

        let result = self.slp.crawlMetaTags(itempropTemplate, result: Response())

        XCTAssertEqual(result.title, itempropData[Constants.title]!.decoded)
        XCTAssertEqual(result.description, itempropData[Constants.description]!.decoded)
        XCTAssertEqual(result.image, itempropData[Constants.image])
    }

    func testItemprop() {

        for _ in 0 ..< 100 {

            self.setUpItempropAndRun()

        }

    }

    // MARK: - Meta
    func setUpMetaAndRun() {

        let metaData =
            [
                Constants.title: String.randomText(),
                Constants.site: String.randomUrl(),
                Constants.description: String.randomText(),
                Constants.image: String.randomImage()
        ]

        var metaTemplate = self.metaTemplate
        metaTemplate = metaTemplate.replace(Constants.headRandomPre, with: String.randomTag())
        metaTemplate = metaTemplate.replace(Constants.headRandomPos, with: String.randomTag())

        metaTemplate = metaTemplate.replace(Constants.title, with: metaData[Constants.title]!)
        metaTemplate = metaTemplate.replace(Constants.site, with: metaData[Constants.site]!)
        metaTemplate = metaTemplate.replace(Constants.description, with: metaData[Constants.description]!)
        metaTemplate = metaTemplate.replace(Constants.image, with: metaData[Constants.image]!)

        metaTemplate = metaTemplate.replace(Constants.bodyRandom, with: String.randomTag()).extendedTrim

        let result = self.slp.crawlMetaTags(metaTemplate, result: Response())

        XCTAssertEqual(result.title, metaData[Constants.title]!.decoded)
        XCTAssertEqual(result.description, metaData[Constants.description]!.decoded)
        XCTAssertEqual(result.image, metaData[Constants.image])
    }

    func testMeta() {

        for _ in 0 ..< 100 {

            self.setUpMetaAndRun()

        }

    }

}
