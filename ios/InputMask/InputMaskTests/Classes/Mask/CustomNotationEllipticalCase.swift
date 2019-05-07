//
// Project «InputMask»
// Created by Jeorge Taflanidi
//


import XCTest
@testable import InputMask


class CustomNotationEllipticalCase: MaskTestCase {
    
    override func format() -> String {
        return "[C…]"
    }
    
    private func notations() -> [Notation] {
        return [
            Notation(
                character: "C",
                characterSet: CharacterSet.letters.union(CharacterSet(charactersIn: " ")),
                isOptional: false
            )
        ]
    }
    
    override func mask() throws -> Mask {
        return try Mask(
            format: self.format(),
            customNotations: notations()
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
                    try! Mask.getOrCreate(withFormat: self.format(), customNotations: notations())
                )
            }
        }
    }
    
    func testGetPlaceholder_allSet_returnsCorrectPlaceholder() {
        let placeholder: String = try! self.mask().placeholder
        XCTAssertEqual(placeholder, "C")
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
    
    func testApply_1_returns_emptyString() {
        let inputString: String         = "1"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = ""
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
    
    func testApply_12_returns_emptyString() {
        let inputString: String         = "12"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = ""
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
    
    func testApply_123_returns_emptyString() {
        let inputString: String         = "123"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = ""
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
    
    func testApply_1Jeorge23_returns_Jeorge() {
        let inputString: String         = "1Jeorge23"
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
    
    func testApply_1234Jeorge56_returns_Jeorge() {
        let inputString: String         = "1234Jeorge56"
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
    
    func testApply_JeorgeSpaceSmith_returns_JeorgeSpaceSmith() {
        let inputString: String         = "Jeorge Smith"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "Jeorge Smith"
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
    
    func testApply_JeorgeSpaceSmithUnderscore_returns_JeorgeSpaceSmith() {
        let inputString: String         = "Jeorge Smith_"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "Jeorge Smith"
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
