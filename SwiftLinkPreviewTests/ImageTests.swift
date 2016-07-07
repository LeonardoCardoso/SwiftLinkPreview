//
//  ImageTests.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 05/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import XCTest
import SwiftLinkPreview

// This class tests body images
class ImageTests: XCTestCase {
    
    // MARK: - Vars
    var singleImageTemplate = ""
    var galleryImageTemplate = ""
    let slp = SwiftLinkPreview()
    
    // MARK: - SetUps
    // Those setup functions get that template, and fulfil determinated areas with rand texts, images and tags
    override func setUp() {
        super.setUp()
        
        self.singleImageTemplate = File.toString(Constants.bodyImageSingle)
        self.galleryImageTemplate = File.toString(Constants.bodyImageGallery)
        
    }
    
    // MARK: - Single
    func setUpSingle() {
        
        let data = [Constants.image: String.randomImage()]
        
        var singleImageTemplate = self.singleImageTemplate
        singleImageTemplate = singleImageTemplate.replace(Constants.headRandom, with: String.randomTag())
        singleImageTemplate = singleImageTemplate.replace(Constants.bodyRandomPre, with: String.randomTag())
        singleImageTemplate = singleImageTemplate.replace(Constants.bodyRandomPos, with: String.randomTag())
        
        singleImageTemplate = singleImageTemplate.replace(Constants.image, with: data[Constants.image]!)
        
        singleImageTemplate = singleImageTemplate.replace(Constants.bodyRandom, with: String.randomTag()).extendedTrim
        
        slp.resetResult()
        slp.crawlImages(singleImageTemplate)
        
        XCTAssert((slp.result["image"] as! String) == data[Constants.image], "image extracted must be equal that was generated")
        
    }
    
    func testSingle() {
        
        for _ in 0 ..< 100 {
            
            self.setUpSingle()
            
        }
        
    }
    
}
