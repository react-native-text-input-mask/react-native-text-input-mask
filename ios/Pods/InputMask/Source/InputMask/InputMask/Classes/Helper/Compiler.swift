//
//  InputMask
//
//  Created by Egor Taflanidi on 16.08.28.
//  Copyright © 28 Heisei Egor Taflanidi. All rights reserved.
//

import Foundation


/**
 ### Compiler
 
 Creates a sequence of states from the mask format string.
 
 - seealso: ```State``` class.
 
 - complexity: ```O(formatString.characters.count)``` plus ```FormatSanitizer``` complexity.
 
 - requires: Format string to contain only flat groups of symbols in ```[]``` and ```{}``` brackets without nested
 brackets, like ```[[000]99]```. Also, ```[…]``` groups may contain only the specified characters ("0", "9", "A", "a", 
 "_" and "-"). Square bracket ```[]``` groups cannot contain mixed types of symbols ("0" and "9" with "A" and "a" or
 "_" and "-").

 ```Compiler``` object is initialized and ```Compiler.compile(formatString:)``` is called during the ```Mask``` instance
 initialization.
 
 ```Compiler``` uses ```FormatSanitizer``` to prepare ```formatString``` for the compilation.
 */
public class Compiler {
    
    /**
     ### CompilerError
     
     Compiler error exception type, thrown when ```formatString``` contains inappropriate character sequences.
     
     ```CompilerError``` is used by the ```Compiler``` and ```FormatSanitizer``` classes.
     */
    public enum CompilerError: Error {
        case WrongFormat
    }
    
    /**
     Compile ```formatString``` into the sequence of states.
     
     * "Free" characters from ```formatString``` are converted to ```FreeState```-s.
     * Characters in square brackets are converted to ```ValueState```-s and ```OptionalValueState```-s.
     * Characters in curly brackets are converted to ```FixedState```-s.
     * End of the formatString line makes ```EOLState```.
     
     For instance,
     ```
     [09]{.}[09]{.}19[00]
     ```
     is converted to sequence:
     ```
     0. ValueState.Numeric          [0]
     1. OptionalValueState.Numeric  [9]
     2. FixedState                  {.}
     3. ValueState.Numeric          [0]
     4. OptionalValueState.Numeric  [9]
     5. FixedState                  {.}
     6. FreeState                    1
     7. FreeState                    9
     8. ValueState.Numeric          [0]
     9. ValueState.Numeric          [0]
     ```
     
     - parameter formatString: string with a mask format.
     
     - seealso: ```State``` class.
     
     - complexity: ```O(formatString.characters.count)``` plus ```FormatSanitizer``` complexity.
     
     - requires: Format string to contain only flat groups of symbols in ```[]``` and ```{}``` brackets without nested
     brackets, like ```[[000]99]```. Also, ```[…]``` groups may contain only the specified characters ("0", "9", "A", "a",
     "_" and "-").
     
     - returns: Initialized ```State``` object with assigned ```State.child``` chain.
     
     - throws: ```CompilerError``` if ```formatString``` does not conform to the method requirements.
     */
    func compile(formatString string: String) throws -> State {
        let sanitizedFormat: String = try FormatSanitizer().sanitize(formatString: string)
        
        return try self.compile(
            sanitizedFormat,
            valueable: false,
            fixed: false
        )
    }
    
}

private extension Compiler {
    
    func compile(_ string: String, valueable: Bool, fixed: Bool) throws -> State {
        guard
            let char: Character = string.characters.first
        else {
            return EOLState()
        }
        
        if "[" == char {
            return try self.compile(
                string.truncateFirst(),
                valueable: true,
                fixed: false
            )
        }
        
        if "{" == char {
            return try self.compile(
                string.truncateFirst(),
                valueable: false,
                fixed: true
            )
        }
        
        if "]" == char {
            return try self.compile(
                string.truncateFirst(),
                valueable: false,
                fixed: false
            )
        }
        
        if "}" == char {
            return try self.compile(
                string.truncateFirst(),
                valueable: false,
                fixed: false
            )
        }
        
        if valueable {
            if "0" == char {
                return ValueState(
                    child: try self.compile(
                        string.truncateFirst(),
                        valueable: true,
                        fixed: false
                    ),
                    type: ValueState.StateType.Numeric
                )
            }
            
            if "A" == char {
                return ValueState(
                    child: try self.compile(
                        string.truncateFirst(),
                        valueable: true,
                        fixed: false
                    ),
                    type: ValueState.StateType.Literal
                )
            }
            
            if "_" == char {
                return ValueState(
                    child: try self.compile(
                        string.truncateFirst(),
                        valueable: true,
                        fixed: false
                    ),
                    type: ValueState.StateType.AlphaNumeric
                )
            }
            
            if "9" == char {
                return OptionalValueState(
                    child: try self.compile(
                        string.truncateFirst(),
                        valueable: true,
                        fixed: false
                    ),
                    type: OptionalValueState.StateType.Numeric
                )
            }
            
            if "a" == char {
                return OptionalValueState(
                    child: try self.compile(
                        string.truncateFirst(),
                        valueable: true,
                        fixed: false
                    ),
                    type: OptionalValueState.StateType.Literal
                )
            }
            
            if "-" == char {
                return OptionalValueState(
                    child: try self.compile(
                        string.truncateFirst(),
                        valueable: true,
                        fixed: false
                    ),
                    type: OptionalValueState.StateType.AlphaNumeric
                )
            }
            
            throw CompilerError.WrongFormat
        }
        
        if fixed {
            return FixedState(
                child: try self.compile(
                    string.truncateFirst(),
                    valueable: false,
                    fixed: true
                ),
                ownCharacter: char
            )
        }
        
        return FreeState(
            child: try self.compile(
                string.truncateFirst(),
                valueable: false,
                fixed: false),
            ownCharacter: char
        )
    }
    
}
