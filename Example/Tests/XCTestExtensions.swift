//
//  XCTestExtensions.swift
//  Wendy_Tests
//
//  Created by Levi Bostian on 12/17/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    
    func waitForExpectations(file: StaticString = #file, line: UInt = #line) {
        waitForExpectations(timeout: 1, handler: nil)
    }

    func XCTAssertBackgroundThread(file: StaticString = #file, line: UInt = #line) {
        if Thread.isMainThread {
            XCTFail("You're on the main thread. That's not what you wanted.")
        }
    }

    func XCTAssertMainThread(file: StaticString = #file, line: UInt = #line) {
        if !Thread.isMainThread {
            XCTFail("You're NOT on the main thread. That's not what you wanted.")
        }
    }
}
