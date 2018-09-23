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

            // Get youtube.com becaus it contains a huge HTML
            let source = try String(contentsOf: URL(string: "https://youtube.com")!).extendedTrim

            let title = self.slp.crawlCode(source, minimum: SwiftLinkPreview.titleMinimumRelevant)
            let description = self.slp.crawlCode(source, minimum: SwiftLinkPreview.decriptionMinimumRelevant)

            XCTAssert(!title.trim.isEmpty)
            XCTAssert(!description.trim.isEmpty)

        } catch let err as NSError {

            print("\(err)")

        }

    }

}
