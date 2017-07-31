//
//  InputMask
//
//  Created by Egor Taflanidi on 10.08.28.
//  Copyright © 28 Heisei Egor Taflanidi. All rights reserved.
//

import XCTest
@testable import InputMask


class MonthYearDoubledoubleShashCase: MaskTestCase {
    
    override func format() -> String {
        return "[00]{//}[0000]"
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
        XCTAssertEqual(placeholder, "00//0000")
    }
    
    func testAcceptableTextLength_allSet_returnsCorrectCount() {
        let acceptableTextLength: Int = try! self.mask().acceptableTextLength()
        XCTAssertEqual(acceptableTextLength, 8)
    }
    
    func testTotalTextLength_allSet_returnsCorrectCount() {
        let totalTextLength: Int = try! self.mask().totalTextLength()
        XCTAssertEqual(totalTextLength, 8)
    }
    
    func testAcceptableValueLength_allSet_returnsCorrectCount() {
        let acceptableValueLength: Int = try! self.mask().acceptableValueLength()
        XCTAssertEqual(acceptableValueLength, 8)
    }
    
    func testTotalValueLength_allSet_returnsCorrectCount() {
        let totalValueLength: Int = try! self.mask().totalValueLength()
        XCTAssertEqual(totalValueLength, 8)
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
    
    func testApply_111_returns_11doubleShash1() {
        let inputString: String         = "111"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11//1"
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
    
    func testApply_1111_returns_11doubleShash11() {
        let inputString: String         = "1111"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11//11"
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
    
    func testApply_123456_returns_12doubleShash3456() {
        let inputString: String         = "123456"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12//3456"
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
    
    func testApply_12shash3_returns_12doubleShash3() {
        let inputString: String         = "12/3"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12//3"
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
    
    func testApply_12doubleShash3_returns_12doubleShash3() {
        let inputString: String         = "12//3"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12//3"
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
    
    func testApply_12shash34_returns_12doubleShash34() {
        let inputString: String         = "12/34"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12//34"
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
    
    func testApply_12doubleShash34_returns_12doubleShash34() {
        let inputString: String         = "12//34"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12//34"
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
    
    func testApply_12doubleShash345_returns_12doubleShash345() {
        let inputString: String         = "12//345"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12//345"
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
    
    func testApply_12doubleShash3456_returns_12doubleShash3456() {
        let inputString: String         = "12//3456"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12//3456"
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
    
    func testApply_1234567_returns_12doubleShash3456() {
        let inputString: String         = "1234567"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12//3456"
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
    
    func testApply_12345678_returns_12doubleShash3456() {
        let inputString: String         = "12345678"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "12//3456"
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
    
    func testApply_1111_StartIndex_returns_11doubleShash11_StartIndex() {
        let inputString: String         = "1111"
        let inputCaret:  String.Index   = inputString.startIndex
        
        let expectedString: String       = "11//11"
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
    
    func testApply_1111_ThirdIndex_returns_11doubleShash11_FourthIndex() {
        let inputString: String         = "1111"
        let inputCaret:  String.Index   = inputString.index(inputString.startIndex, offsetBy: 2)
        
        let expectedString: String       = "11//11"
        let expectedCaret:  String.Index = expectedString.index(expectedString.startIndex, offsetBy: 4)
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

    func testApply_abc1111_returns_11doubleShash11() {
        let inputString: String         = "abc1111"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11//11"
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
    
    func testApply_abc1de111_returns_11doubleShash11() {
        let inputString: String         = "abc1de111"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11//11"
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
    
    func testApply_abc1de1fg11_returns_11doubleShash11() {
        let inputString: String         = "abc1de1fg11"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "11//11"
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
    
}
