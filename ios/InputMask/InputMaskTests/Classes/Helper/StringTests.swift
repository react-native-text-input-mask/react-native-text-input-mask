//
// Project «InputMask»
// Created by Jeorge Taflanidi
//


import XCTest
@testable import InputMask


class StringTests: XCTestCase {
    
    func testPrefixIntersection_emptyStrings_returnsEmptyString() {
        let s1 = ""
        let s2 = ""
        let actualResult = String(s1.prefixIntersection(with: s2))
        let expectedResult = ""
        XCTAssertEqual(actualResult, expectedResult)
    }

    func testPrefixIntersection_phoneNumbers_returnsPlusSeven() {
        let s1 = "+7 (123"
        let s2 = "+7 (9"
        let actualResult = String(s1.prefixIntersection(with: s2))
        let expectedResult = "+7 ("
        XCTAssertEqual(actualResult, expectedResult)
    }

    func testPrefixIntersection_s1Empty_returnsEmptyString() {
        let s1 = ""
        let s2 = "+7 (9"
        let actualResult = String(s1.prefixIntersection(with: s2))
        let expectedResult = ""
        XCTAssertEqual(actualResult, expectedResult)
    }

    func testPrefixIntersection_s2Empty_returnsEmptyString() {
        let s1 = "+7 (123"
        let s2 = ""
        let actualResult = String(s1.prefixIntersection(with: s2))
        let expectedResult = ""
        XCTAssertEqual(actualResult, expectedResult)
    }

    func testPrefixIntersection_completelyDifferentStrings_returnsEmptyString() {
        let s1 = "+7 (123"
        let s2 = "8 (900"
        let actualResult = String(s1.prefixIntersection(with: s2))
        let expectedResult = ""
        XCTAssertEqual(actualResult, expectedResult)
    }

    func testPrefixIntersection_s1Shorter_returnsS1() {
        let s1 = "+7 "
        let s2 = "+7 (9"
        let actualResult = String(s1.prefixIntersection(with: s2))
        let expectedResult = "+7 "
        XCTAssertEqual(actualResult, expectedResult)
    }

    func testPrefixIntersection_s2Shorter_returnsS2() {
        let s1 = "+7 (123"
        let s2 = "+7"
        let actualResult = String(s1.prefixIntersection(with: s2))
        let expectedResult = "+7"
        XCTAssertEqual(actualResult, expectedResult)
    }

}
