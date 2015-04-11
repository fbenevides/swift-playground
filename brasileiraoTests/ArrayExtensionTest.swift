//
//  ArrayExtensionTest.swift
//  brasileirao
//
//  Created by Felipe Benevides on 1/24/15.
//  Copyright (c) 2015 Globo. All rights reserved.
//

import XCTest
import brasileirao

class ArrayExtensionTest: XCTestCase {

    func testShouldCheckIfAnElementIsInArray() {
        XCTAssertTrue([1, 2, 3, 4].containsObject(1))
    }
}
