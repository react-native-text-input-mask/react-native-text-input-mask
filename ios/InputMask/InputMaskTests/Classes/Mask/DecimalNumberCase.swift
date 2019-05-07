//
// Project «InputMask»
// Created by Jeorge Taflanidi
//


import XCTest
@testable import InputMask


class DecimalNumberCase: MaskTestCase {
    
    override func format() -> String {
        return "[9999][.][99]"
    }
    
    override func mask() throws -> Mask {
        return try Mask(
            format: self.format(),
            customNotations: [
                Notation(character: ".", characterSet: CharacterSet(charactersIn: "."), isOptional: true),
            ]
        )
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
                    try! Mask.getOrCreate(
                        withFormat: self.format(),
                        customNotations: [
                            Notation(character: ".", characterSet: CharacterSet(charactersIn: "."), isOptional: true),
                        ]
                    )
                )
            }
        }
    }
    
    func testGetPlaceholder_allSet_returnsCorrectPlaceholder() {
        let placeholder: String = try! self.mask().placeholder
        XCTAssertEqual(placeholder, "0000.00")
    }
    
    func testAcceptableTextLength_allSet_returnsCorrectCount() {
        let acceptableTextLength: Int = try! self.mask().acceptableTextLength
        XCTAssertEqual(acceptableTextLength, 0)
    }
    
    func testTotalTextLength_allSet_returnsCorrectCount() {
        let totalTextLength: Int = try! self.mask().totalTextLength
        XCTAssertEqual(totalTextLength, 7)
    }
    
    func testAcceptableValueLength_allSet_returnsCorrectCount() {
        let acceptableValueLength: Int = try! self.mask().acceptableValueLength
        XCTAssertEqual(acceptableValueLength, 0)
    }
    
    func testTotalValueLength_allSet_returnsCorrectCount() {
        let totalValueLength: Int = try! self.mask().totalValueLength
        XCTAssertEqual(totalValueLength, 7)
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
        
        XCTAssertEqual(true, result.complete)
    }
    
    func testApply_1dot_returns_1dot() {
        let inputString: String         = "1."
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "1."
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
    
    func testApply_11dot_returns_11dot() {
        let inputString: String         = "11."
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11."
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
    
    func testApply_1dot1_returns_1dot1() {
        let inputString: String         = "1.1"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "1.1"
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
    
    func testApply_11dot2_returns_11dot2() {
        let inputString: String         = "11.2"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.2"
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
    
    func testApply_1122dot_returns_1122dot() {
        let inputString: String         = "1122."
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "1122."
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
    
    func testApply_1122dot33_returns_1122dot33() {
        let inputString: String         = "1122.33"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "1122.33"
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
    
    func testApply_1122comma33_returns_1122() {
        let inputString: String         = "1122,33"
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
