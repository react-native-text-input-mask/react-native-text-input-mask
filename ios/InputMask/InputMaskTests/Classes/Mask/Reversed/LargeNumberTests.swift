//
// Project «InputMask»
// Created by Jeorge Taflanidi
//


import XCTest
@testable import InputMask


class LargeNumberTests: XCTestCase {

    func testApply_10000_returns10space000() {
        let input: String       = "10000"
        let caret: String.Index = input.endIndex

        let expectedOutput:   String       = "10 000"
        let expectedCaret:    String.Index = expectedOutput.endIndex
        let expectedAffinity: Int          = 4
        let expectedComplete: Bool         = false

        let mask: Mask = try! RTLMask.getOrCreate(withFormat: "[0] [000] [000]")

        let actualOutput: Mask.Result = mask.apply(toText: CaretString(string: input, caretPosition: caret))

        XCTAssertEqual(actualOutput.formattedText.string, expectedOutput)
        XCTAssertEqual(actualOutput.formattedText.caretPosition, expectedCaret)
        XCTAssertEqual(actualOutput.affinity, expectedAffinity)
        XCTAssertEqual(actualOutput.complete, expectedComplete)
    }

    func testApply_10CARET00_returns1space0CARET00() {
        let input: String       = "1000"
        let caret: String.Index = input.startIndex(offsetBy: 2)

        let expectedOutput:   String       = "1 000"
        let expectedCaret:    String.Index = expectedOutput.startIndex(offsetBy: 3)
        let expectedAffinity: Int          = 3
        let expectedComplete: Bool         = false

        let mask: Mask = try! RTLMask.getOrCreate(withFormat: "[0] [000] [000]")

        let actualOutput: Mask.Result = mask.apply(toText: CaretString(string: input, caretPosition: caret))

        XCTAssertEqual(actualOutput.formattedText.string, expectedOutput)
        XCTAssertEqual(actualOutput.formattedText.caretPosition, expectedCaret)
        XCTAssertEqual(actualOutput.affinity, expectedAffinity)
        XCTAssertEqual(actualOutput.complete, expectedComplete)
    }

    func testApply_1CARET000_returns1spaceCARET000() {
        let input: String       = "1000"
        let caret: String.Index = input.startIndex(offsetBy: 1)

        let expectedOutput:   String       = "1 000"
        let expectedCaret:    String.Index = expectedOutput.startIndex(offsetBy: 2)
        let expectedAffinity: Int          = 3
        let expectedComplete: Bool         = false

        let mask: Mask = try! RTLMask.getOrCreate(withFormat: "[0] [000] [000]")

        let actualOutput: Mask.Result = mask.apply(toText: CaretString(string: input, caretPosition: caret))

        XCTAssertEqual(actualOutput.formattedText.string, expectedOutput)
        XCTAssertEqual(actualOutput.formattedText.caretPosition, expectedCaret)
        XCTAssertEqual(actualOutput.affinity, expectedAffinity)
        XCTAssertEqual(actualOutput.complete, expectedComplete)
    }
    
    func testApply_CARET000_returnsCARET000() {
        let input: String       = "000"
        let caret: String.Index = input.startIndex
        
        let expectedOutput:   String       = "000"
        let expectedCaret:    String.Index = expectedOutput.startIndex
        let expectedAffinity: Int          = 3
        let expectedComplete: Bool         = false
        
        let mask: Mask = try! RTLMask.getOrCreate(withFormat: "[0] [000] [000]")
        
        let actualOutput: Mask.Result = mask.apply(toText: CaretString(string: input, caretPosition: caret))
        
        XCTAssertEqual(actualOutput.formattedText.string, expectedOutput)
        XCTAssertEqual(actualOutput.formattedText.caretPosition, expectedCaret)
        XCTAssertEqual(actualOutput.affinity, expectedAffinity)
        XCTAssertEqual(actualOutput.complete, expectedComplete)
    }
    
    func testApplyAutocomplete_CARET000_returnsCARET000() {
        let input: String       = "000"
        let caret: String.Index = input.startIndex
        
        let expectedOutput:   String       = "000"
        let expectedCaret:    String.Index = expectedOutput.startIndex
        let expectedAffinity: Int          = 3
        let expectedComplete: Bool         = false
        
        let mask: Mask = try! RTLMask.getOrCreate(withFormat: "[0] [000] [000]")
        
        let actualOutput: Mask.Result = mask.apply(toText: CaretString(string: input, caretPosition: caret), autocomplete: true)
        
        XCTAssertEqual(actualOutput.formattedText.string, expectedOutput)
        XCTAssertEqual(actualOutput.formattedText.caretPosition, expectedCaret)
        XCTAssertEqual(actualOutput.affinity, expectedAffinity)
        XCTAssertEqual(actualOutput.complete, expectedComplete)
    }
    
    func testApply_CARET1000_returnsCARET1space000() {
        let input: String       = "1000"
        let caret: String.Index = input.startIndex
        
        let expectedOutput:   String       = "1 000"
        let expectedCaret:    String.Index = expectedOutput.startIndex
        let expectedAffinity: Int          = 3
        let expectedComplete: Bool         = false
        
        let mask: Mask = try! RTLMask.getOrCreate(withFormat: "[0] [000] [000]")
        
        let actualOutput: Mask.Result = mask.apply(toText: CaretString(string: input, caretPosition: caret))
        
        XCTAssertEqual(actualOutput.formattedText.string, expectedOutput)
        XCTAssertEqual(actualOutput.formattedText.caretPosition, expectedCaret)
        XCTAssertEqual(actualOutput.affinity, expectedAffinity)
        XCTAssertEqual(actualOutput.complete, expectedComplete)
    }

}
