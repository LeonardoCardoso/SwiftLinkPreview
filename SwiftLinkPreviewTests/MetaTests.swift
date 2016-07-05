//
//  MetaTests.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 05/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import XCTest

// This class tests head meta info
class MetaTests: XCTestCase {
    
    // MARK: - Vars
    var twitterTemplate = ""
    var twitterData =
        [
            Constants.twitterTitle: "",
            Constants.twitterSite: "",
            Constants.twitterDescription: "",
            Constants.twitterImageSrc: ""
    ]
    
    var facebookTemplate = ""
    var facebookData =
        [
            Constants.facebookTitle: "",
            Constants.facebookSite: "",
            Constants.facebookDescription: "",
            Constants.facebookImage: ""
    ]
    
    var metaTemplate = ""
    var metaData =
        [
            Constants.title: "",
            Constants.site: "",
            Constants.description: "",
            Constants.image: ""
    ]
    
    // MARK: - SetUps
    // Those setup functions get that template, and fulfil determinated areas with rand texts, images and tags
    override func setUp() {
        super.setUp()
        
        self.setUpTwitter()
        self.setUpFacebook()
        self.setUpMeta()
        
    }
    
    func setUpTwitter() {
        
        self.twitterTemplate = File.toString(Constants.headMetaTwitter)
        
        // TODO generate random data and add to respective dictionary to compare on test fuction
        
        self.twitterTemplate = self.twitterTemplate.replace(Constants.headRandomPre, with: "leo")
        self.twitterTemplate = self.twitterTemplate.replace(Constants.headRandomPos, with: "leo")
        
        self.twitterTemplate = self.twitterTemplate.replace(Constants.twitterTitle, with: "leo")
        self.twitterTemplate = self.twitterTemplate.replace(Constants.twitterSite, with: "leo")
        self.twitterTemplate = self.twitterTemplate.replace(Constants.twitterDescription, with: "leo")
        self.twitterTemplate = self.twitterTemplate.replace(Constants.twitterImageSrc, with: "leo")
        
        self.twitterTemplate = self.twitterTemplate.replace(Constants.bodyRandom, with: "leo")
        
    }
    
    func setUpFacebook() {
        
        self.facebookTemplate = File.toString(Constants.headMetaFacebook)
        
        // TODO generate random data and add to respective dictionary to compare on test fuction
        
        self.facebookTemplate = self.facebookTemplate.replace(Constants.headRandomPre, with: "leo")
        self.facebookTemplate = self.facebookTemplate.replace(Constants.headRandomPos, with: "leo")
        
        self.facebookTemplate = self.facebookTemplate.replace(Constants.facebookTitle, with: "leo")
        self.facebookTemplate = self.facebookTemplate.replace(Constants.facebookSite, with: "leo")
        self.facebookTemplate = self.facebookTemplate.replace(Constants.facebookDescription, with: "leo")
        self.facebookTemplate = self.facebookTemplate.replace(Constants.facebookImage, with: "leo")
        
        self.facebookTemplate = self.facebookTemplate.replace(Constants.bodyRandom, with: "leo")
        
    }
    
    func setUpMeta() {
        
        self.metaTemplate = File.toString(Constants.headMetaMeta)
        
        // TODO generate random data and add to respective dictionary to compare on test fuction
        
        self.metaTemplate = self.metaTemplate.replace(Constants.headRandomPre, with: "leo")
        self.metaTemplate = self.metaTemplate.replace(Constants.headRandomPos, with: "leo")
        
        self.metaTemplate = self.metaTemplate.replace(Constants.title, with: "leo")
        self.metaTemplate = self.metaTemplate.replace(Constants.site, with: "leo")
        self.metaTemplate = self.metaTemplate.replace(Constants.description, with: "leo")
        self.metaTemplate = self.metaTemplate.replace(Constants.image, with: "leo")
        
        self.metaTemplate = self.metaTemplate.replace(Constants.bodyRandom, with: "leo")
        
    }
    
    // MARK: - Tests
    func testTwitter() {
        
        print(self.twitterTemplate)
        
    }
    
    func testFacebook() {
        
        print(self.facebookTemplate)
        
    }
    
    func testMeta() {
        
        print(self.metaTemplate)
        
    }
    
}
