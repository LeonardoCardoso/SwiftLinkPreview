//
//  HugeTests.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 19/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import XCTest
@testable import SwiftLinkPreview

// This class tests head meta info
class HugeTests: XCTestCase {

    // MARK: - Vars
    let slp = SwiftLinkPreview()

    // MARK: - Huge
    func testHuge() {

        do {

            // Get reddit.com because it contains a huge HTML
            let source = try String(contentsOf: URL(string: "https://reddit.com")!).extendedTrim

            let title = self.slp.crawlCode(source, minimum: SwiftLinkPreview.titleMinimumRelevant)
            let description = self.slp.crawlCode(source, minimum: SwiftLinkPreview.decriptionMinimumRelevant)

            XCTAssert(!title.trim.isEmpty)
            XCTAssert(!description.trim.isEmpty)

        } catch let err as NSError {

            print("\(err)")

        }

    }
    
    // MARK: - Amazon
    func testAmazonLinksWithGoogleBotUserAgent() {
                    
        // Amazon links are huge and serve up very different html based on the user agent string
        // Some user agents don't contain og tags and will fail to locate title and images
        let amazonUrl = "https://www.amazon.com/Beginning-HTML5-CSS3-Dummies-Tittel/dp/1118657209/"
        let expectation = self.expectation(description: "Loading web page")
        var result:Response?
        
        let updatedSlp = SwiftLinkPreview(userAgent: SwiftLinkPreview.googleBotUserAgent)
        
        updatedSlp.preview(amazonUrl) {
                        
            result = $0
            expectation.fulfill()
            
        } onError: { error in
            
            print(error)
            XCTAssertNil(error)
            
        }

        waitForExpectations(timeout: 15, handler: nil)
        XCTAssert(!result!.title!.trim.isEmpty)
        XCTAssertNotNil(result!.image)
            
    }
    
    func testAmazonLinksWithOriginalSlpUserAgent() {
                    
        // Amazon links are huge and serve up very different html based on the user agent string
        // Some user agents don't contain og tags and will fail to locate title and images
        let amazonUrl = "https://www.amazon.com/Beginning-HTML5-CSS3-Dummies-Tittel/dp/1118657209/"
        let expectation = self.expectation(description: "Loading web page")
        var result:Response?
        
        slp.preview(amazonUrl) {
                        
            result = $0
            expectation.fulfill()
            
        } onError: { error in
            
            print(error)
            XCTAssertNil(error)
            
        }

        waitForExpectations(timeout: 15, handler: nil)
        XCTAssert(!result!.title!.trim.isEmpty)
        XCTAssertNil(result!.image)
            
    }

}
