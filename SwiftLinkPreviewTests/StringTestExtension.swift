//
//  StringTestExtension.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 05/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import Foundation
import GameplayKit

extension String {

    static let loremIpsum =
        [
            "Et harum quidem rerum facilis est et expedita distinctio.",
            "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
            "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            "Temporibus autem quibusdam et aut officiis debitis aut rerum &amp;necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae.",
            "Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.",
            "At vero eos et accusamus et iusto odio dignissimos&rsquo; ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.",
            "Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus.",
            "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
            "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.",
            "Neque porro quisquam est&rsquo;, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
            "Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?",
            "Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
    ]

    static let protocolType = ["http://", "https://"]
    static let tagType = ["span", "p", "div"]
    static let imageType = ["gif", "jpg", "jpeg", "png", "bmp"]

    // Random String
    static func randomString(_ length: Int) -> String {

        let charactersString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let charactersArray = charactersString.map { String($0) }

        var string = ""
        for _ in 0..<length {
            string += charactersArray[Int.random(upper: charactersArray.count)]
        }

        return string

    }

    // Random Text
    static func randomText() -> String {

        return loremIpsum[Int.random(upper: loremIpsum.count)]

    }

    // Random Tag
    static func randomTag() -> String {

        let tag = tagType[Int.random(upper: tagType.count)]
        return "<\(tag)>\(randomText())</\(tag)>"

    }

    // Random Tag
    static func randomImageTag() -> String {

        let options = [
            "<img src=\"\(randomImage())\" />",
            "<img src=\"\(randomImage())\" ></img>",
            "<img src=\"\(randomImage())\" >"
        ]

        return options[Int.random(upper: options.count)]

    }

    // Random URL
    static func randomUrl() -> String {

        var rand = Int.random(upper: 30) + 5
        let base = String.randomString(rand)

        rand = Int.random(upper: 3) + 2
        rand = rand.hashValue > 3 ? 3 : rand
        let end = String.randomString(rand)

        let prtcl = self.protocolType[Int.random(upper: protocolType.count)]
        let url = "\(prtcl)\(base).\(end.lowercased())"

        return url

    }

    // Random Image
    static func randomImage() -> String {

        return "\(randomUrl())/\(String.randomString(Int.random(upper: 15) + 5)).\(imageType[Int.random(upper: imageType.count)])"

    }

}
