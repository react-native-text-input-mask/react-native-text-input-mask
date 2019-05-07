//
// Project «InputMask»
// Created by Jeorge Taflanidi
//


import Foundation


/**
 ### CaretString
 
 Model object that represents string with current cursor position.
 */
public struct CaretString: CustomDebugStringConvertible, CustomStringConvertible, Equatable {
    
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

    /**
     Constructor.
     
     Same as the ```init(string:caretPosition:)```, with the caret position equal to the end of the line.
     */
    public init(string: String) {
        self.init(string: string, caretPosition: string.endIndex)
    }
    
    public var debugDescription: String {
        return "STRING: \(self.string)\nCARET POSITION: \(self.caretPosition)"
    }
    
    public var description: String {
        return self.debugDescription
    }

    /**
     Creates a reversed ```CaretString``` instance with reversed string and corresponding caret position.
     */
    func reversed() -> CaretString {
        let reversedString:        String       = self.string.reversed
        let caretPositionInt:      Int          = self.string.distanceFromStartIndex(to: self.caretPosition)
        let reversedCaretPosition: String.Index = reversedString.startIndex(offsetBy: self.string.count - caretPositionInt)
        return CaretString(
            string: reversedString,
            caretPosition: reversedCaretPosition
        )
    }
    
}


public func ==(left: CaretString, right: CaretString) -> Bool {
    return left.caretPosition == right.caretPosition
        && left.string        == right.string
}
