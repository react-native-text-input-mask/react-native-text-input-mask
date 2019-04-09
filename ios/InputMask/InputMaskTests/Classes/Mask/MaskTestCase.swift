//
// Project «InputMask»
// Created by Jeorge Taflanidi
//


import XCTest
@testable import InputMask


class MaskTestCase: XCTestCase {
    
    func mask() throws -> Mask {
        return try Mask(format: self.format())
    }
    
    func format() -> String {
        fatalError("format() method is abstract")
    }
    
    func testInit_nestedBrackets_throwsWrongFormatCompilerError() {
        do {
            _ = try Mask(format: "[[00]000]")
            XCTFail()
        } catch Compiler.CompilerError.wrongFormat {
            // success
        } catch {
            XCTFail()
        }
    }
    
    func testInit_mixedCharacters_initialized() {
        do {
            _ = try Mask(format: "[00000Aa]")
        } catch Compiler.CompilerError.wrongFormat {
            XCTFail()
        } catch {
            XCTFail()
        }
    }
    
}
