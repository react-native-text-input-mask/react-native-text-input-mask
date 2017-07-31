//
//  YearCase.swift
//  InputMask
//
//  Created by Egor Taflanidi on 03.02.29.
//  Copyright © 29 Heisei Egor Taflanidi. All rights reserved.
//

import XCTest
@testable import InputMask


class YearCase: MaskTestCase {
    
    override func format() -> String {
        return "[0099]"
    }
    
    func testInit_correctFormat_maskInitialized() {
        XCTAssertNotNil(try self.mask())
    }
    
    func testInit_correctFormat_measureTime() {
        self.measure {
            var masks: [Mask] = []
            for _ in 1...1000 {
                masks.append(
                    try! self.mask()
                )
            }
        }
    }
    
    func testGetOrCreate_correctFormat_measureTime() {
        self.measure {
            var masks: [Mask] = []
            for _ in 1...1000 {
                masks.append(
                    try! Mask.getOrCreate(withFormat: self.format())
                )
            }
        }
    }
    
    func testGetPlaceholder_allSet_returnsCorrectPlaceholder() {
        let placeholder: String = try! self.mask().placeholder()
        XCTAssertEqual(placeholder, "0000")
    }
    
    func testAcceptableTextLength_allSet_returnsCorrectCount() {
        let acceptableTextLength: Int = try! self.mask().acceptableTextLength()
        XCTAssertEqual(acceptableTextLength, 2)
    }
    
    func testTotalTextLength_allSet_returnsCorrectCount() {
        let totalTextLength: Int = try! self.mask().totalTextLength()
        XCTAssertEqual(totalTextLength, 4)
    }
    
    func testAcceptableValueLength_allSet_returnsCorrectCount() {
        let acceptableValueLength: Int = try! self.mask().acceptableValueLength()
        XCTAssertEqual(acceptableValueLength, 2)
    }
    
    func testTotalValueLength_allSet_returnsCorrectCount() {
        let totalValueLength: Int = try! self.mask().totalValueLength()
        XCTAssertEqual(totalValueLength, 4)
    }
    
    func testApply_1_returns_1() {
        let inputString: String         = "1"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "1"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = expectedString
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            )
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(false, result.complete)
    }
    
    func testApply_11_returns_11() {
        let inputString: String         = "11"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = expectedString
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            )
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(true, result.complete)
    }
    
    func testApply_112_returns_112() {
        let inputString: String         = "112"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "112"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = expectedString
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            )
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(true, result.complete)
    }
    
    func testApply_1122_returns_1122() {
        let inputString: String         = "1122"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "1122"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = expectedString
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            )
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(true, result.complete)
    }
    
}
