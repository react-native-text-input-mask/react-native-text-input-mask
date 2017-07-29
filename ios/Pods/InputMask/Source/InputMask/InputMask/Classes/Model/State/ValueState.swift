//
//  InputMask
//
//  Created by Egor Taflanidi on 16.08.28.
//  Copyright © 28 Heisei Egor Taflanidi. All rights reserved.
//

import Foundation


/**
 ### ValueState
 
 Represents mandatory characters in square brackets [].
 
 Accepts only characters of own type (see ```StateType```). Puts accepted characters into the result string.
 
 Returns accepted characters as an extracted value.
 
 - seealso: ```ValueState.StateType```
 */
class ValueState: State {
    
    /**
     ### StateType
     
     * ```Numeric``` stands for [9] characters
     * ```Literal``` stands for [a] characters
     * ```AlphaNumeric``` stands for [-] characters
     */
    enum StateType {
        case numeric
        case literal
        case alphaNumeric
    }
    
    let type: StateType
    
    func accepts(character char: Character) -> Bool {
        switch self.type {
            case .numeric:
                return CharacterSet.decimalDigits.isMember(char)
            case .literal:
                return CharacterSet.letters.isMember(char)
            case .alphaNumeric:
                return CharacterSet.alphanumerics.isMember(char)
        }
    }
    
    override func accept(character char: Character) -> Next? {
        if !self.accepts(character: char) {
            return nil
        }
        
        return Next(
            state: self.nextState(),
            insert: char,
            pass: true,
            value: char
        )
    }
    
    /**
     Constructor.
     
     - parameter child: next ```State```
     - parameter type: type of the accepted characters
     
     - seealso: ```ValueState.StateType```
     
     - returns: Initialized ```ValueState``` instance.
     */
    init(
        child: State,
        type: StateType
    ) {
        self.type = type
        super.init(child: child)
    }
    
    override var debugDescription: String {
        get {
            switch self.type {
                case .literal:
                    return "[A] -> " + (nil != self.child ? self.child!.debugDescription : "nil")
                case .numeric:
                    return "[0] -> " + (nil != self.child ? self.child!.debugDescription : "nil")
                case .alphaNumeric:
                    return "[_] -> " + (nil != self.child ? self.child!.debugDescription : "nil")
            }
        }
    }
    
}
