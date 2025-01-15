//
//  URLs.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 16/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import Foundation

struct URLs {

    // Please add the text in the format:
    // [text, expectation, canonical]
    // ["xxx https://your.url.com/etc#something?else=true xxx", "https://your.url.com/etc#something?else=true", "your.url.com"]
    static let bunch = [
        [
            "aaa www.google.com aaa",
            "http://www.google.com",
            "www.google.com"
        ],
        [
            "bbb https://www.google.com.br/?gfe_rd=cr&ei=iVKKV7nXLcSm8wfE5InADg&gws_rd=ssl bbb",
            "https://www.google.com.br/?gfe_rd=cr&ei=iVKKV7nXLcSm8wfE5InADg&gws_rd=ssl",
            "www.google.com.br"
        ],
        [
            "ccc123 http://google.com qwqwe",
            "http://google.com",
            "google.com"
        ],
        [
            "ddd http://ios.leocardz.com/swift-link-preview/ ddd",
            "http://ios.leocardz.com/swift-link-preview/",
            "ios.leocardz.com"
        ],
        [
            "ddd ios.leocardz.com/swift-link-preview/ ddd",
            "http://ios.leocardz.com/swift-link-preview/",
            "ios.leocardz.com"
        ],
        [
            "ddd ios.leocardz.com ddd",
            "http://ios.leocardz.com",
            "ios.leocardz.com"
        ],
        [
            "eee http://www.nasa.gov/ eee",
            "http://www.nasa.gov/",
            "www.nasa.gov"
        ],
        [
            "fff theverge.com/2016/6/21/11996280/tesla-offer-solar-city-buy fff",
            "http://theverge.com/2016/6/21/11996280/tesla-offer-solar-city-buy",
            "theverge.com"
        ],
        [
            "fff http://theverge.com/2016/6/21/11996280/tesla-offer-solar-city-buy fff",
            "http://theverge.com/2016/6/21/11996280/tesla-offer-solar-city-buy",
            "theverge.com"
        ],
        [
            "ggg http://bit.ly/14SD1eR ggg",
            "http://bit.ly/14SD1eR",
            "bit.ly"
        ],
        [
            "hhh https://twitter.com hhh",
            "https://twitter.com",
            "twitter.com"
        ],
        [
            "hhh twitter.com hhh",
            "http://twitter.com",
            "twitter.com"
        ],
        [
            "iii https://www.nationalgallery.org.uk#2123123?sadasd&asd iii",
            "https://www.nationalgallery.org.uk#2123123?sadasd&asd",
            "www.nationalgallery.org.uk"
        ],
        [
            "jjj http://globo.com jjj",
            "http://globo.com",
            "globo.com"
        ],
        [
            "kkk http://uol.com.br kkk",
            "http://uol.com.br",
            "uol.com.br"
        ],
        [
            "lll http://vnexpress.net/ lll",
            "http://vnexpress.net/",
            "vnexpress.net"
        ],
        [
            "mmm http://www3.nhk.or.jp/ mmm",
            "http://www3.nhk.or.jp/",
            "www3.nhk.or.jp"
        ],
        [
            "nnn http://habrahabr.ru nnn",
            "http://habrahabr.ru",
            "habrahabr.ru"
        ],
        [
            "ooo http://www.youtube.com/watch?v=cv2mjAgFTaI ooo",
            "http://www.youtube.com/watch?v=cv2mjAgFTaI",
            "www.youtube.com"
        ],
        [
            "ppp http://vimeo.com/67992157 ppp",
            "http://vimeo.com/67992157",
            "vimeo.com"
        ],
        [
            "qqq https://lh6.googleusercontent.com/-aDALitrkRFw/UfQEmWPMQnI/AAAAAAAFOlQ/mDh1l4ej15k/w337-h697-no/db1969caa4ecb88ef727dbad05d5b5b3.jpg qqq",
            "https://lh6.googleusercontent.com/-aDALitrkRFw/UfQEmWPMQnI/AAAAAAAFOlQ/mDh1l4ej15k/w337-h697-no/db1969caa4ecb88ef727dbad05d5b5b3.jpg",
            "lh6.googleusercontent.com"
        ],
        [
            "rrr http://goo.gl/jKCPgp rrr",
            "http://goo.gl/jKCPgp",
            "goo.gl"
        ]
    ]

}
