//
//  InputMask
//
//  Created by Egor Taflanidi on 10.08.28.
//  Copyright © 28 Heisei Egor Taflanidi. All rights reserved.
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
        } catch Compiler.CompilerError.WrongFormat {
            // success
        } catch {
            XCTFail()
        }
    }
    
    func testInit_mixedCharacters_initialized() {
        do {
            _ = try Mask(format: "[00000Aa]")
        } catch Compiler.CompilerError.WrongFormat {
            XCTFail()
        } catch {
            XCTFail()
        }
    }
    
}
