//
//  File.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 05/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import Foundation

class File {
    
    // Read local html files
    static func toString(file: String) -> String {
        
        let path = NSBundle(forClass: object_getClass(self)).pathForResource(file, ofType: "html")
        let fileHtml = try! NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        return String(fileHtml)
        
    }
    
}