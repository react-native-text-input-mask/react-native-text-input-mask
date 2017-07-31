//
//  PhoneCase.swift
//  InputMask
//
//  Created by Egor Taflanidi on 17.08.28.
//  Copyright © 28 Heisei Egor Taflanidi. All rights reserved.
//

import XCTest
@testable import InputMask


class PhoneCase: MaskTestCase {
    
    override func format() -> String {
        return "+7 ([000]) [000] [00] [00]"
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
        XCTAssertEqual(placeholder, "+7 (000) 000 00 00")
    }
    
    func testAcceptableTextLength_allSet_returnsCorrectCount() {
        let acceptableTextLength: Int = try! self.mask().acceptableTextLength()
        XCTAssertEqual(acceptableTextLength, 18)
    }
    
    func testTotalTextLength_allSet_returnsCorrectCount() {
        let totalTextLength: Int = try! self.mask().totalTextLength()
        XCTAssertEqual(totalTextLength, 18)
    }
    
    func testAcceptableValueLength_allSet_returnsCorrectCount() {
        let acceptableValueLength: Int = try! self.mask().acceptableValueLength()
        XCTAssertEqual(acceptableValueLength, 10)
    }
    
    func testTotalValueLength_allSet_returnsCorrectCount() {
        let totalValueLength: Int = try! self.mask().totalValueLength()
        XCTAssertEqual(totalValueLength, 10)
    }
    
    func testApply_plus_return_plus() {
        let inputString: String         = "+"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = ""
        
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
    
    func testApply_plus7_return_plus7() {
        let inputString: String         = "+7"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = ""
        
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
    
    func testApply_plus7space_return_plus7space() {
        let inputString: String         = "+7 "
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 "
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = ""
        
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
    
    func testApply_plus7spaceBrace_return_plus7spaceBrace() {
        let inputString: String         = "+7 ("
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 ("
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = ""
        
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
    
    func testApply_plus7spaceBrace1_return_plus7spaceBrace1() {
        let inputString: String         = "+7 (1"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (1"
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
        
        XCTAssertEqual(false, result.complete)
    }
    
    func testApply_plus7spaceBrace12_return_plus7spaceBrace12() {
        let inputString: String         = "+7 (12"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (12"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "12"
        
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
    
    func testApply_plus7spaceBrace123_return_plus7spaceBrace123() {
        let inputString: String         = "+7 (123"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (123"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "123"
        
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
    
    func testApply_plus7spaceBrace123brace_return_plus7spaceBrace123brace() {
        let inputString: String         = "+7 (123)"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (123)"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "123"
        
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
    
    func testApply_plus7spaceBrace123braceSpace_return_plus7spaceBrace123braceSpace() {
        let inputString: String         = "+7 (123) "
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (123) "
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "123"
        
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
    
    func testApply_plus7spaceBrace123braceSpace4_return_plus7spaceBrace123braceSpace4() {
        let inputString: String         = "+7 (123) 4"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (123) 4"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "1234"
        
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
    
    func testApply_plus7spaceBrace123braceSpace45_return_plus7spaceBrace123braceSpace45() {
        let inputString: String         = "+7 (123) 45"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (123) 45"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "12345"
        
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
    
    func testApply_plus7spaceBrace123braceSpace456_return_plus7spaceBrace123braceSpace456() {
        let inputString: String         = "+7 (123) 456"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (123) 456"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "123456"
        
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
    
    func testApply_plus7spaceBrace123braceSpace456space_return_plus7spaceBrace123braceSpace456space() {
        let inputString: String         = "+7 (123) 456 "
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (123) 456 "
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "123456"
        
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
    
    func testApply_plus7spaceBrace123braceSpace456space7_return_plus7spaceBrace123braceSpace456space7() {
        let inputString: String         = "+7 (123) 456 7"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (123) 456 7"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "1234567"
        
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
    
    func testApply_plus7spaceBrace123braceSpace456space78_return_plus7spaceBrace123braceSpace456space78() {
        let inputString: String         = "+7 (123) 456 78"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (123) 456 78"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "12345678"
        
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
    
    func testApply_plus7spaceBrace123braceSpace456space78space_return_plus7spaceBrace123braceSpace456space78space() {
        let inputString: String         = "+7 (123) 456 78 "
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (123) 456 78 "
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "12345678"
        
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
    
    func testApply_plus7spaceBrace123braceSpace456space78space9_return_plus7spaceBrace123braceSpace456space78space9() {
        let inputString: String         = "+7 (123) 456 78 9"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (123) 456 78 9"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "123456789"
        
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
    
    func testApply_plus7spaceBrace123braceSpace456space78space90_return_plus7spaceBrace123braceSpace456space78space90() {
        let inputString: String         = "+7 (123) 456 78 90"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (123) 456 78 90"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "1234567890"
        
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
    
    func testApply_7_return_plus7() {
        let inputString: String         = "7"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = ""
        
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
    
    func testApply_9_return_plus7spaceBrace9() {
        let inputString: String         = "9"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (9"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "9"
        
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
    
    func testApply_1234567890_return_plus7spaceBrace123braceSpace456space78space90() {
        let inputString: String         = "1234567890"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (123) 456 78 90"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "1234567890"
        
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
    
    func testApply_12345678901_return_plus7spaceBrace123braceSpace456space78space90() {
        let inputString: String         = "12345678901"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (123) 456 78 90"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "1234567890"
        
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
    
    func testApply_plus1234567890_return_plus7spaceBrace123braceSpace456space78space90() {
        let inputString: String         = "+1234567890"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (123) 456 78 90"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "1234567890"
        
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
    
    func testApply_plusBrace123brace456dash78dash90_return_plus7spaceBrace123braceSpace456space78space90() {
        let inputString: String         = "+(123)456-78-90"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (123) 456 78 90"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "1234567890"
        
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
    
    func testApplyAutocomplete_empty_return_plus7spaceBrace() {
        let inputString: String         = ""
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 ("
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
        
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_plus_return_plus7spaceBrace() {
        let inputString: String         = "+"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 ("
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
        
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_plus7_return_plus7spaceBrace() {
        let inputString: String         = "+7"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 ("
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
        
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_plus7space_return_plus7spaceBrace() {
        let inputString: String         = "+7 "
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 ("
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
        
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_plus7spaceBrace_return_plus7spaceBrace() {
        let inputString: String         = "+7 ("
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 ("
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
        
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_a_return_plus7spaceBrace() {
        let inputString: String         = "a"
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 ("
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
        
        XCTAssertEqual(false, result.complete)
    }
    
    func testApplyAutocomplete_aPlus7spaceBrace_return_plus7spaceBrace() {
        let inputString: String         = "a+7 ("
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 (7"
        let expectedCaret:  String.Index = expectedString.endIndex
        let expectedValue:  String       = "7"
        
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
    
    func testApplyAutocomplete_7space_return_plus7spaceBrace() {
        let inputString: String         = "7 "
        let inputCaret:  String.Index   = inputString.endIndex
        
        let expectedString: String       = "+7 ("
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
        
        XCTAssertEqual(false, result.complete)
    }
    
}
