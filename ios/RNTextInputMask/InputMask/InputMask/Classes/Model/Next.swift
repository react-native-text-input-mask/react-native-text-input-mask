//
//  InputMask
//
//  Created by Egor Taflanidi on 16.08.28.
//  Copyright © 28 Heisei Egor Taflanidi. All rights reserved.
//

import Foundation


/**
 ### Next
 
 Model object that represents a set of actions that should take place when transition from one ```State``` to another 
 occurs.
 */
struct Next {
    
    /**
     Next ```State``` of the ```Mask```.
     */
    let state: State
    
    /**
     Insert a character into the resulting formatted string.
     */
    let insert: Character?
    
    /**
     Pass to the next character of the input string.
     */
    let pass: Bool
    
    /**
     Add character to the extracted value string.
     Value is extracted from the user input string.
     */
    let value: Character?

}
