//
//  Regex.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 09/06/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//
import Foundation

// MARK: - Regular expressions

enum Regex {
    public static var kLimit: Int = 500000
    static let imagePattern = "(.+?)\\.(gif|jpg|jpeg|png|bmp)$"
    static let openGraphImagePattern = "(.+?)\\.(gif||jpg|jpeg|png|bmp)$"
    static let videoTagPattern = "<video[^>]+src=\"([^\"]+)"
    static let secondaryVideoTagPattern = "og:video\"(.+?)content=\"([^\"](.+?))\"(.+?)[/]?>"
    static let imageTagPattern = "<img(.+?)src=\"([^\"](.+?))\"(.+?)[/]?>"
    static let secondaryImageTagPattern = "og:image\"(.+?)content=\"([^\"](.+?))\"(.+?)[/]?>"
    static let titlePattern = "<title(.*?)>(.*?)</title>"
    static let metaTagPattern = "<meta(.*?)>"
    static let baseTagPattern = "<base(.+?)href=\"(.*?)\"(.+?)[/]?>"
    static let metaTagContentPattern = "content=(\"(.*?)\")|('(.*?)')"
    static let cannonicalUrlPattern = "([^\\+&#@%\\?=~_\\|!:,;]+)"
    static let rawTagPattern = "<[^>]+>"
    static let inlineStylePattern = "<style(.*?)>(.*?)</style>"
    static let inlineScriptPattern = "<script(.*?)>(.*?)</script>"
    static let linkPattern = "<link(.*?)>"
    static let scriptPattern = "<script(.*?)>"
    static let commentPattern = "<!--(.*?)-->"
    static let hrefPattern = ".*href=\"(.*?)\".*"
    static let pricePattern = "itemprop=\"price\" content=\"([^\"]*)\""

    // Test regular expression
    static func test(_ string: String, regex: String) -> Bool {
        Regex.pregMatchFirst(string, regex: regex) != nil
    }

    // Match first occurrency
    static func pregMatchFirst(_ string: String, regex: String, index: Int = 0) -> String? {
        do {
            let rx = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])

            if let match = rx.firstMatch(in: string, options: [], range: NSRange(string.startIndex..., in: string)) {
                let result: [String] = Regex.stringMatches([match], text: string, index: index)
                return result.isEmpty ? nil : result[0]
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }

    // Match all occurrencies
    static func pregMatchAll(_ string: String, regex: String, index: Int = 0) -> [String] {
        do {
            let rx = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])

            var matches: [NSTextCheckingResult] = []

            let limit = Regex.kLimit

            if string.count > limit {
                for item in string.split(by: limit) {
                    matches.append(contentsOf: rx.matches(
                        in: string,
                        options: [],
                        range: NSRange(item.startIndex..., in: item)
                    ))
                }
            } else {
                matches.append(contentsOf: rx.matches(
                    in: string,
                    options: [],
                    range: NSRange(string.startIndex..., in: string)
                ))
            }

            return !matches.isEmpty ? Regex.stringMatches(matches, text: string, index: index) : []
        } catch {
            return []
        }
    }

    // Extract matches from string
    static func stringMatches(_ results: [NSTextCheckingResult], text: String, index: Int = 0) -> [String] {
        return results.map {
            let range = $0.range(at: index)
            return if text.count > range.location + range.length {
                (text as NSString).substring(with: range)
            } else {
                ""
            }
        }
    }

    // Return tag pattern
    static func tagPattern(_ tag: String) -> String {
        return "<" + tag + "(.*?)>(.*?)</" + tag + ">"
    }
}
