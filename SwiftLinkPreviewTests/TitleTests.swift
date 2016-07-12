//
//  BodyTests.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 05/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import XCTest
import SwiftLinkPreview

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
    
    // MARK: - Single
    func setUpTitle() {
        
        let metaData =
            [
                Constants.title: String.randomText()
        ]
        
        var metaTemplate = self.titleTemplate
        metaTemplate = metaTemplate.replace(Constants.headRandomPre, with: String.randomTag())
        metaTemplate = metaTemplate.replace(Constants.headRandomPos, with: String.randomTag())
        
        metaTemplate = metaTemplate.replace(Constants.title, with: metaData[Constants.title]!)
        
        metaTemplate = metaTemplate.replace(Constants.bodyRandom, with: String.randomTag()).extendedTrim
        
        slp.resetResult()
        slp.crawlTitle(metaTemplate)
        
        XCTAssertEqual((slp.result["title"] as! String), metaData[Constants.title])
        
    }
    
    func testTitle() {
        
        for _ in 0 ..< 100 {
            
            self.setUpTitle()
            
        }
        
    }
    
}
