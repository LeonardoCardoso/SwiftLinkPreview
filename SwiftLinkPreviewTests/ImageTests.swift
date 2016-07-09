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
        
        XCTAssert((slp.result["image"] as! String) == data[Constants.image], "image must be equal that was generated")
        
    }
    
    func testSingle() {
        
        for _ in 0 ..< 100 {
            
            self.setUpSingle()
            
        }
        
    }
    
    // MARK: - Gallery
    func setUpGallery() {
        
        let data = [
            Constants.image1: String.randomImage(),
            Constants.image2: String.randomImage(),
            Constants.image3: String.randomImage()
        ]
        
        var galleryImageTemplate = self.galleryImageTemplate
        galleryImageTemplate = galleryImageTemplate.replace(Constants.headRandom, with: String.randomTag())
        galleryImageTemplate = galleryImageTemplate.replace(Constants.bodyRandomPre, with: String.randomTag())
        galleryImageTemplate = galleryImageTemplate.replace(Constants.bodyRandomPos, with: String.randomTag())
        
        galleryImageTemplate = galleryImageTemplate.replace(Constants.image1, with: data[Constants.image1]!)
        galleryImageTemplate = galleryImageTemplate.replace(Constants.image2, with: data[Constants.image2]!)
        galleryImageTemplate = galleryImageTemplate.replace(Constants.image3, with: data[Constants.image3]!)
        
        galleryImageTemplate = galleryImageTemplate.replace(Constants.bodyRandom, with: String.randomTag()).extendedTrim
        
        slp.resetResult()
        slp.crawlImages(galleryImageTemplate)
        
        XCTAssert((slp.result["images"] as! [String])[0] == data[Constants.image1], "image 1 must be equal that was generated")
        XCTAssert((slp.result["images"] as! [String])[1] == data[Constants.image2], "image 2 must be equal that was generated")
        XCTAssert((slp.result["images"] as! [String])[2] == data[Constants.image3], "image 3 must be equal that was generated")
        
    }
    
    func testGallery() {
        
        for _ in 0 ..< 100 {
            
            self.setUpGallery()
            
        }
        
    }
    
}
