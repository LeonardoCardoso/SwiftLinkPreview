//
//  HugeTests.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 19/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import XCTest
import SwiftLinkPreview

// This class tests head meta info
class HugeTests: XCTestCase {
    
    // MARK: - Vars
    let slp = SwiftLinkPreview()
    
    // MARK: - Huge
    func testHuge() {
        
        let hugeTemplate = File.toString(Constants.huge)
        
        let title = self.slp.crawlCode(hugeTemplate, minimum: SwiftLinkPreview.titleMinimumRelevant)
        let description = self.slp.crawlCode(hugeTemplate, minimum: SwiftLinkPreview.decriptionMinimumRelevant)
        
        XCTAssertEqual(title.trim, "Sign in now to see your channels and recommendations!")
        XCTAssertEqual(description.trim, "We were unable to complete the request. Please try again later.")
        
    }
    
    
}
