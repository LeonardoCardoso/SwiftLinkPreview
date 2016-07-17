//
//  RegexTests.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 16/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import XCTest
import SwiftLinkPreview

// This class tests URLs
class RegexTests: XCTestCase {

    
    // MARK: - Vars
    let slp = SwiftLinkPreview()
    
    // MARK: - Functions
    func testURL() {
        
        for url in URLs.bunch {
            
            self.slp.text = url[0]
            let extracted = slp.extractURL()
            
            // print(extracted?.absoluteString, url[1])
            
            XCTAssertEqual(extracted?.absoluteString, url[1])
            
        }
        
    }
    
    func testCanonicalURL() {
        
        for url in URLs.bunch {
            
            self.slp.result["finalUrl"] = NSURL(string: url[1])
            self.slp.extractCanonicalURL()
            
            // print(self.slp.result["canonicalUrl"], url[2])
            
            XCTAssertEqual((self.slp.result["canonicalUrl"] as! String), url[2])
            
        }
        
    }
    
}