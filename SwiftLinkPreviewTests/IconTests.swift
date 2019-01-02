//
//  IconTests.swift
//  SwiftLinkPreview
//
//  Created by Vincent Toms on 7/21/17.
//  Copyright © 2017 leocardz.com. All rights reserved.
//

import XCTest
@testable import SwiftLinkPreview

class IconTests: XCTestCase {

    let slp = SwiftLinkPreview()

    var template = ""

    let iconList = [
        "/apple-touch-icon.png",
        "/touch-icon-ipad.png",
        "/touch-icon-iphone4.png",
        "http://github.com/images/touch-icon-iphone4.png",
        "http://github.com/images/touch-icon-ipad.png",
        "http://github.com/images/apple-touch-icon-57x57.png",
        "/favicon.ico",
        "/fluid-icon.png"
    ]

    let typeList = [
        "apple-touch-icon",
        "apple-touch-icon-precomposed",
        "shortcut icon",
        "fluid-icon"
    ]

    override func setUp() {
        super.setUp()

        template = File.toString(Constants.bodyIcon)
    }

    func testLink() {
        for _ in 1..<1000 {
            let icon = random(array: iconList)
            let type = random(array: typeList)
            var testTemplate = template

            testTemplate = testTemplate.replace(Constants.href, with: icon)
            testTemplate = testTemplate.replace(Constants.rel, with: type)

            var result = Response()
            result.url = URL(string: "google.com")
            result.canonicalUrl = "google.com"
            result.finalUrl = URL(string: "https://google.com")

            result = slp.crawIcon(testTemplate, result: result)

            let url = icon.range(of: "http") != nil ? icon : "https://google.com/\(icon)".replace("com//", with: "com/")

            XCTAssertEqual(url, result.icon)
        }
    }

    fileprivate func random(array: [String]) -> String {
        let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
        return array[randomIndex]
    }
}
