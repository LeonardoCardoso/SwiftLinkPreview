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
    func testRegex() {
        
        for url in URLs.bunch {
            
            slp.text = url[0]
            let extracted = slp.extractURL()
            
            // print(extracted?.absoluteString, url[1])
    
            XCTAssertEqual(extracted?.absoluteString, url[1])
            
        }
        
    }
    
}