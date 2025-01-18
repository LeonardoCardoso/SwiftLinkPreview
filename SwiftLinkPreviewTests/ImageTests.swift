//
//  ImageTests.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 05/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

@testable import SwiftLinkPreview
import XCTest

// This final class tests body images
final class ImageTests: XCTestCase {
    // MARK: - Vars

    var singleImageTemplate = ""
    var galleryImageTemplate = ""
    let slp = SwiftLinkPreview()

    // MARK: - SetUps

    // Those setup functions get that template, and fulfil determinated areas with rand texts, images and tags
    override func setUp() {
        super.setUp()

        singleImageTemplate = File.toString(Constants.bodyImageSingle)
        galleryImageTemplate = File.toString(Constants.bodyImageGallery)
    }

    // MARK: - Single

    func setUpSingle() throws {
        let data = [Constants.image: String.randomImage()]

        var singleImageTemplate = self.singleImageTemplate
        singleImageTemplate = singleImageTemplate.replace(Constants.headRandom, with: String.randomTag())
        singleImageTemplate = singleImageTemplate.replace(Constants.bodyRandomPre, with: String.randomTag())
        singleImageTemplate = singleImageTemplate.replace(Constants.bodyRandomPos, with: String.randomTag())

        singleImageTemplate = singleImageTemplate.replace(Constants.image, with: try XCTUnwrap(data[Constants.image]))

        singleImageTemplate = singleImageTemplate.replace(Constants.bodyRandom, with: String.randomTag()).extendedTrim

        let result = slp.crawlImages(
            singleImageTemplate,
            result:
            Response()
        )

        XCTAssertEqual(result.image, data[Constants.image])
    }

    func testSingle() throws {
        for _ in 0 ..< 100 {
            try setUpSingle()
        }
    }

    // MARK: - Gallery

    func setUpGallery() throws {
        let data = [
            Constants.image1: String.randomImage(),
            Constants.image2: String.randomImage(),
            Constants.image3: String.randomImage(),
        ]

        var galleryImageTemplate = self.galleryImageTemplate
        galleryImageTemplate = galleryImageTemplate.replace(Constants.headRandom, with: String.randomTag())
        galleryImageTemplate = galleryImageTemplate.replace(Constants.bodyRandomPre, with: String.randomTag())
        galleryImageTemplate = galleryImageTemplate.replace(Constants.bodyRandomPos, with: String.randomTag())

        galleryImageTemplate = galleryImageTemplate.replace(
            Constants.image1,
            with: try XCTUnwrap(data[Constants.image1])
        )
        galleryImageTemplate = galleryImageTemplate.replace(
            Constants.image2,
            with: try XCTUnwrap(data[Constants.image2])
        )
        galleryImageTemplate = galleryImageTemplate.replace(
            Constants.image3,
            with: try XCTUnwrap(data[Constants.image3])
        )

        galleryImageTemplate = galleryImageTemplate.replace(Constants.bodyRandom, with: String.randomTag()).extendedTrim

        let result = slp.crawlImages(galleryImageTemplate, result: Response())

        XCTAssertEqual(result.images?[0], data[Constants.image1])
        XCTAssertEqual(result.images?[1], data[Constants.image2])
        XCTAssertEqual(result.images?[2], data[Constants.image3])
    }

    func testGallery() throws {
        for _ in 0 ..< 100 {
            try setUpGallery()
        }
    }

    func testImgur() throws {
        do {
            let source = try String(contentsOf: try XCTUnwrap(URL(string: "https://imgur.com/GoAkW6w"))).extendedTrim

            let result = slp.crawlMetaTags(source, result: Response())

            print(result)
        } catch let err as NSError {
            print("\(err)")
        }
    }
}
