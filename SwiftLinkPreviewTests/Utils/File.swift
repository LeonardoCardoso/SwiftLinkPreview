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
    static func toString(_ file: String) -> String {

        let path = Bundle(for: object_getClass(self)!).path(forResource: file, ofType: "html")
        let fileHtml = try! NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue)
        return String(fileHtml)

    }

}
