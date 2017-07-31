//
//  InputMask
//
//  Created by Egor Taflanidi on 10.08.28.
//  Copyright © 28 Heisei Egor Taflanidi. All rights reserved.
//

import XCTest
@testable import InputMask


class DayMonthYearShortCase: MaskTestCase {
    
    override func format() -> String {
        return "[90]{.}[90]{.}[0000]"
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
        XCTAssertEqual(acceptableTextLength, 8)
    }
    
    func testTotalTextLength_allSet_returnsCorrectCount() {
        let totalTextLength: Int = try! self.mask().totalTextLength()
        XCTAssertEqual(totalTextLength, 10)
    }
    
    func testAcceptableValueLength_allSet_returnsCorrectCount() {
        let acceptableValueLength: Int = try! self.mask().acceptableValueLength()
        XCTAssertEqual(acceptableValueLength, 8)
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
        let expectedValue:  String       = "1"
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            )
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(1, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApply_11_returns_11() {
        let inputString: String         = "11"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "11"
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            )
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(2, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApply_111_returns_11dot1() {
        let inputString: String         = "111"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.1"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "11.1"
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            )
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(2, result.affinity)
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
        
        XCTAssertEqual(3, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApply_123456_returns_12dot34dot56() {
        let inputString: String         = "123456"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12.34.56"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "12.34.56"
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            )
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(4, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApply_12dot3_returns_12dot3() {
        let inputString: String         = "12.3"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12.3"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "12.3"
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            )
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(4, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApply_12dot34_returns_12dot34() {
        let inputString: String         = "12.34"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12.34"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "12.34"
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            )
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(5, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApply_12dot34dot5_returns_12dot34dot5() {
        let inputString: String         = "12.34.5"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12.34.5"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "12.34.5"
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            )
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(7, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApply_12dot34dot56_returns_12dot34dot56() {
        let inputString: String         = "12.34.56"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12.34.56"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "12.34.56"
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            )
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(8, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApply_1234567_returns_12dot34dot567() {
        let inputString: String         = "1234567"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12.34.567"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "12.34.567"
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            )
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(5, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApply_12345678_returns_12dot34dot5678() {
        let inputString: String         = "12345678"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12.34.5678"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "12.34.5678"
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            )
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(6, result.affinity)
        XCTAssertEqual(true, result.complete)
    }
    
    func testApply_1111_StartIndex_returns_11dot11_StartIndex() {
        let inputString: String         = "1111"
        let inputCaret:  String.Index   = inputString.startIndex
        
        let expectedString: String       = "11.11"
        let expectedCaret:  String.Index = expectedString.startIndex
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
        
        XCTAssertEqual(3, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApply_1111_ThirdIndex_returns_11dot11_FourthIndex() {
        let inputString: String         = "1111"
        let inputCaret:  String.Index   = inputString.index(inputString.startIndex, offsetBy: 2)
        
        let expectedString: String       = "11.11"
        let expectedCaret:  String.Index = expectedString.index(expectedString.startIndex, offsetBy: 3)
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
        
        XCTAssertEqual(3, result.affinity)
        XCTAssertEqual(false, result.complete)
    }

    func testApply_abc1111_returns_11dot11() {
        let inputString: String         = "abc1111"
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
        
        XCTAssertEqual(0, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApply_abc1de111_returns_11dot11() {
        let inputString: String         = "abc1de111"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "1.11.1"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "1.11.1"
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            )
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(-4, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApply_abc1de1fg11_returns_11dot11() {
        let inputString: String         = "abc1de1fg11"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "1.1.11"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "1.1.11"
        
        let result: Mask.Result = try! self.mask().apply(
            toText: CaretString(
                string: inputString,
                caretPosition: inputCaret
            )
        )
        
        XCTAssertEqual(expectedString, result.formattedText.string)
        XCTAssertEqual(expectedCaret, result.formattedText.caretPosition)
        XCTAssertEqual(expectedValue, result.extractedValue)
        
        XCTAssertEqual(-7, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApply_a_returns_empty() {
        let inputString: String         = "a"
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
        
        XCTAssertEqual(-1, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_empty_returns_empty() {
        let inputString: String         = ""
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = ""
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = ""
        
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
        
        XCTAssertEqual(0, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_1_returns_1() {
        let inputString: String         = "1"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "1"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "1"
        
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
        
        XCTAssertEqual(1, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_11_returns_11dot() {
        let inputString: String         = "11"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11."
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "11."
        
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
        
        XCTAssertEqual(2, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_112_returns_11dot2() {
        let inputString: String         = "112"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.2"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "11.2"
        
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
        
        XCTAssertEqual(2, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_1122_returns_11dot22dot() {
        let inputString: String         = "1122"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.22."
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "11.22."
        
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
        
        XCTAssertEqual(3, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_11223_returns_11dot22dot3() {
        let inputString: String         = "11223"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.22.3"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "11.22.3"
        
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
        
        XCTAssertEqual(3, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_112233_returns_11dot22dot33() {
        let inputString: String         = "112233"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.22.33"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "11.22.33"
        
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
        
        XCTAssertEqual(4, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_1122333_returns_11dot22dot333() {
        let inputString: String         = "1122333"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.22.333"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "11.22.333"
        
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
        
        XCTAssertEqual(5, result.affinity)
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_11223333_returns_11dot22dot3333() {
        let inputString: String         = "11223333"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.22.3333"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "11.22.3333"
        
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
        
        XCTAssertEqual(6, result.affinity)
        XCTAssertEqual(true, result.complete)
    }
    
    func testApplyAutocomplete_112233334_returns_11dot22dot3333() {
        let inputString: String         = "112233334"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11.22.3333"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "11.22.3333"
        
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
        
        XCTAssertEqual(5, result.affinity)
        XCTAssertEqual(true, result.complete)
    }
    
}
