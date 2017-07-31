//
//  InputMask
//
//  Created by Egor Taflanidi on 10.08.28.
//  Copyright © 28 Heisei Egor Taflanidi. All rights reserved.
//

import XCTest
@testable import InputMask


class DayMonthYearCase: MaskTestCase {
    
    override func format() -> String {
        return "[00]{.}[00]{.}[0000]"
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
        XCTAssertEqual(placeholder, "00.00.0000")
    }
    
    func testAcceptableTextLength_allSet_returnsCorrectCount() {
        let acceptableTextLength: Int = try! self.mask().acceptableTextLength()
        XCTAssertEqual(acceptableTextLength, 10)
    }
    
    func testTotalTextLength_allSet_returnsCorrectCount() {
        let totalTextLength: Int = try! self.mask().totalTextLength()
        XCTAssertEqual(totalTextLength, 10)
    }
    
    func testAcceptableValueLength_allSet_returnsCorrectCount() {
        let acceptableValueLength: Int = try! self.mask().acceptableValueLength()
        XCTAssertEqual(acceptableValueLength, 10)
    }
    
    func testTotalValueLength_allSet_returnsCorrectCount() {
        let totalValueLength: Int = try! self.mask().totalValueLength()
        XCTAssertEqual(totalValueLength, 10)
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
        
        XCTAssertEqual(false, result.complete)
    }
    
    func testApply_111_returns_11dot1() {
        let inputString: String         = "111"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.1"
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
    
    func testApply_1111_returns_11dot11() {
        let inputString: String         = "1111"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.11"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "11.11"
        
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
    
    func testApply_123456_returns_12dot34dot56() {
        let inputString: String         = "123456"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12.34.56"
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
    
    func testApply_12dot3_returns_12dot3() {
        let inputString: String         = "12.3"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12.3"
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
    
    func testApply_12dot34_returns_12dot34() {
        let inputString: String         = "12.34"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12.34"
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
    
    func testApply_12dot34dot5_returns_12dot34dot5() {
        let inputString: String         = "12.34.5"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12.34.5"
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
    
    func testApply_12dot34dot56_returns_12dot34dot56() {
        let inputString: String         = "12.34.56"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12.34.56"
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
    
    func testApply_1234567_returns_12dot34dot567() {
        let inputString: String         = "1234567"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12.34.567"
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
    
    func testApply_12345678_returns_12dot34dot5678() {
        let inputString: String         = "12345678"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12.34.5678"
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
    
    func testApply_1111_StartIndex_returns_11dot11_StartIndex() {
        let inputString: String         = "1111"
        let inputCaret:  String.Index   = inputString.startIndex
        
        let expectedString: String       = "11.11"
        let expectedCaret:  String.Index = expectedString.startIndex
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
    
    func testApply_1111_ThirdIndex_returns_11dot11_FourthIndex() {
        let inputString: String         = "1111"
        let inputCaret:  String.Index   = inputString.index(inputString.startIndex, offsetBy: 2)
        
        let expectedString: String       = "11.11"
        let expectedCaret:  String.Index = expectedString.index(expectedString.startIndex, offsetBy: 3)
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

    func testApply_abc1111_returns_11dot11() {
        let inputString: String         = "abc1111"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.11"
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
    
    func testApply_abc1de111_returns_11dot11() {
        let inputString: String         = "abc1de111"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.11"
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
    
    func testApply_abc1de1fg11_returns_11dot11() {
        let inputString: String         = "abc1de1fg11"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.11"
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
    
    func testApplyAutocomplete_empty_returns_empty() {
        let inputString: String         = ""
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = ""
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = expectedString
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            ),
            autocomplete: true
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_1_returns_1() {
        let inputString: String         = "1"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "1"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = expectedString
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            ),
            autocomplete: true
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_11_returns_11dot() {
        let inputString: String         = "11"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11."
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = expectedString
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            ),
            autocomplete: true
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_111_returns_11dot1() {
        let inputString: String         = "111"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.1"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = expectedString
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            ),
            autocomplete: true
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_1111_returns_11dot11dot() {
        let inputString: String         = "1111"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.11."
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = expectedString
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            ),
            autocomplete: true
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_11111_returns_11dot11dot1() {
        let inputString: String         = "11111"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.11.1"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = expectedString
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            ),
            autocomplete: true
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_111111_returns_11dot11dot11() {
        let inputString: String         = "111111"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.11.11"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = expectedString
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            ),
            autocomplete: true
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_1111111_returns_11dot11dot111() {
        let inputString: String         = "1111111"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.11.111"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = expectedString
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            ),
            autocomplete: true
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_11111111_returns_11dot11dot1111() {
        let inputString: String         = "11111111"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.11.1111"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = expectedString
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            ),
            autocomplete: true
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(true, result.complete)
    }
    
    func testApplyAutocomplete_111111111_returns_11dot11dot1111() {
        let inputString: String         = "111111111"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.11.1111"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = expectedString
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            ),
            autocomplete: true
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(true, result.complete)
    }
    
}
