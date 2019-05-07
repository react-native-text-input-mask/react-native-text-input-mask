//
// Project «InputMask»
// Created by Jeorge Taflanidi
//


import XCTest
@testable import InputMask


class NameCase: MaskTestCase {
    
    override func format() -> String {
        return "[A…]"
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
        let placeholder: String = try! self.mask().placeholder
        XCTAssertEqual(placeholder, "a")
    }
    
    func testAcceptableTextLength_allSet_returnsCorrectCount() {
        let acceptableTextLength: Int = try! self.mask().acceptableTextLength
        XCTAssertEqual(acceptableTextLength, 2)
    }
    
    func testTotalTextLength_allSet_returnsCorrectCount() {
        let totalTextLength: Int = try! self.mask().totalTextLength
        XCTAssertEqual(totalTextLength, 2)
    }
    
    func testAcceptableValueLength_allSet_returnsCorrectCount() {
        let acceptableValueLength: Int = try! self.mask().acceptableValueLength
        XCTAssertEqual(acceptableValueLength, 2)
    }
    
    func testTotalValueLength_allSet_returnsCorrectCount() {
        let totalValueLength: Int = try! self.mask().totalValueLength
        XCTAssertEqual(totalValueLength, 2)
    }
    
    func testApply_J_returns_J() {
        let inputString: String         = "J"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "J"
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
    
    func testApply_Je_returns_Je() {
        let inputString: String         = "Je"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "Je"
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
    
    func testApply_Jeo_returns_Jeo() {
        let inputString: String         = "Jeo"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "Jeo"
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
    
    func testApply_Jeor_returns_Jeor() {
        let inputString: String         = "Jeor"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "Jeor"
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
    
    func testApply_Jeorge_returns_Jeorge() {
        let inputString: String         = "Jeorge"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "Jeorge"
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
    
    func testApply_Jeorge1_returns_Jeorge() {
        let inputString: String         = "Jeorge1"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "Jeorge"
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
    
    func testApply_1Jeorge2_returns_Jeorge() {
        let inputString: String         = "1Jeorge2"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "Jeorge"
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
