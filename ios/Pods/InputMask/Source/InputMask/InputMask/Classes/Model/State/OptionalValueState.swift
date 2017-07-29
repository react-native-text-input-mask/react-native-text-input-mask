//
//  InputMask
//
//  Created by Egor Taflanidi on 17.08.28.
//  Copyright © 28 Heisei Egor Taflanidi. All rights reserved.
//

import Foundation


/**
 ### OptionalValueState
 
 Represents optional characters in square brackets [].
 
 Accepts any characters, but puts into the result string only the characters of own type (see ```StateType```).
 
 Returns accepted characters of own type as an extracted value.
 
 - seealso: ```OptionalValueState.StateType```
 */
class OptionalValueState: State {
    
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
        if self.accepts(character: char) {
            return Next(
                state: self.nextState(),
                insert: char,
                pass: true,
                value: char
            )
        } else {
            return Next(
                state: self.nextState(),
                insert: nil,
                pass: false,
                value: nil
            )
        }
    }
    
    /**
     Constructor.
     
     - parameter child: next ```State```
     - parameter type: type of the accepted characters
     
     - seealso: ```OptionalValueState.StateType```
     
     - returns: Initialized ```OptionalValueState``` instance.
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
                    return "[a] -> " + (nil != self.child ? self.child!.debugDescription : "nil")
                case .numeric:
                    return "[9] -> " + (nil != self.child ? self.child!.debugDescription : "nil")
                case .alphaNumeric:
                    return "[-] -> " + (nil != self.child ? self.child!.debugDescription : "nil")
            }
        }
    }
    
}
