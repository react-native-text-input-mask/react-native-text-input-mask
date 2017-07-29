//
//  InputMask
//
//  Created by Egor Taflanidi on 16.08.28.
//  Copyright © 28 Heisei Egor Taflanidi. All rights reserved.
//

import Foundation


/**
 ### CaretString
 
 Model object that represents string with current cursor position.
 */
public struct CaretString: CustomDebugStringConvertible, CustomStringConvertible {
    
    /**
     Text from the user.
     */
    public let string: String
    
    /**
     Cursor position from the input text field.
     */
    public let caretPosition: String.Index
    
    /**
     Constructor.
     
     - parameter string: text from the user.
     - parameter caretPosition: cursor position from the input text field.
     */
    public init(string: String, caretPosition: String.Index) {
        self.string = string
        self.caretPosition = caretPosition
    }
    
    public var debugDescription: String {
        get {
            return "STRING: \(self.string)\nCARET POSITION: \(self.caretPosition)"
        }
    }
    
    public var description: String {
        get {
            return self.debugDescription
        }
    }
    
}
