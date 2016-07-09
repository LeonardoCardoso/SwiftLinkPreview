//
//  MetaTests.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 05/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import XCTest
import SwiftLinkPreview

// This class tests head meta info
class MetaTests: XCTestCase {
    
    // MARK: - Vars
    var twitterTemplate = ""
    var facebookTemplate = ""
    var metaTemplate = ""
    let slp = SwiftLinkPreview()
    
    // MARK: - SetUps
    // Those setup functions get that template, and fulfil determinated areas with rand texts, images and tags
    override func setUp() {
        super.setUp()
        
        self.twitterTemplate = File.toString(Constants.headMetaTwitter)
        self.facebookTemplate = File.toString(Constants.headMetaFacebook)
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
        
        slp.resetResult()
        slp.crawlMetaTags(twitterTemplate)
        
        XCTAssert((slp.result["title"] as! String) == twitterData[Constants.twitterTitle], "title must be equal that was generated")
        XCTAssert((slp.result["description"] as! String) == twitterData[Constants.twitterDescription], "description must be equal that was generated")
        XCTAssert((slp.result["image"] as! String) == twitterData[Constants.twitterImageSrc], "image must be equal that was generated")
        
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
        
        slp.resetResult()
        slp.crawlMetaTags(facebookTemplate)
        
        XCTAssert((slp.result["title"] as! String) == facebookData[Constants.facebookTitle], "title must be equal that was generated")
        XCTAssert((slp.result["description"] as! String) == facebookData[Constants.facebookDescription], "description must be equal that was generated")
        XCTAssert((slp.result["image"] as! String) == facebookData[Constants.facebookImage], "image must be equal that was generated")
        
    }
    
    func testFacebook() {
        
        for _ in 0 ..< 100 {
            
            self.setUpFacebookAndRun()
            
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
        
        slp.resetResult()
        slp.crawlMetaTags(metaTemplate)
        
        XCTAssert((slp.result["title"] as! String) == metaData[Constants.title], "title must be equal that was generated")
        XCTAssert((slp.result["description"] as! String) == metaData[Constants.description], "description must be equal that was generated")
        XCTAssert((slp.result["image"] as! String) == metaData[Constants.image], "image must be equal that was generated")
        
    }
    
    func testMeta() {
        
        for _ in 0 ..< 100 {
            
            self.setUpMetaAndRun()
            
        }
        
    }
    
}
