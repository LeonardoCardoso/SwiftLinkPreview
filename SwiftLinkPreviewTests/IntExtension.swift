//
//  IntExtension.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 16/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import Foundation

public extension Int {

    static func random(_ lower: Int = 0, upper: Int = 100) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - 1 - lower + 1)))
    }

}
