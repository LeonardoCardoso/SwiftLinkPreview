//
//  MemoryLeaks.swift
//  SwiftLinkPreview
//
//  Created by Yehor Popovych on 1/18/17.
//  Copyright © 2017 leocardz.com. All rights reserved.
//

import XCTest
@testable import SwiftLinkPreview

class Counter {
    private var val: Int

    init(_ count: Int) {
        val = count
    }

    func dec() {
        val -= 1
    }

    var isZero: Bool {
        return val == 0
    }
}

class MemoryCheckedSwiftLinkPrefiew: SwiftLinkPreview {

    let expectation: XCTestExpectation
    let counter: Counter

    init(expectation: XCTestExpectation, counter: Counter) {
        self.expectation = expectation
        self.counter = counter
        super.init()
    }

    deinit {
        counter.dec()
        if counter.isZero {
            expectation.fulfill()
        }
    }
}

class MemoryLeaks: XCTestCase {

//    func testObjectDestroy() {
//        let e = expectation(description: "instrument")
//        let requestCount = 3
//        let counter = Counter(requestCount)
//
//        for _ in 0..<requestCount {
//            let slp = MemoryCheckedSwiftLinkPrefiew(expectation: e, counter: counter)
//            slp.preview("https://www.youtube.com/watch?v=IvUU8joBb1Q", onSuccess: { response in print("Response:", response) }, onError: { error in })
//        }
//
//        waitForExpectations(timeout: 10.0, handler: nil)
//    }
}
