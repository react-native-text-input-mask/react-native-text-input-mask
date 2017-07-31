//
//  InputMask
//
//  Created by Egor Taflanidi on 10.08.28.
//  Copyright © 28 Heisei Egor Taflanidi. All rights reserved.
//

import Foundation


/**
 Utility extension to make ```NSCharacterSet``` interact with ```Character``` instances.
 */
extension CharacterSet {
    
    /**
     Implements ```NSCharacterSet.characterIsMember(:unichar)``` for ```Character``` instances.
     */
    func isMember(character: Character) -> Bool {
        let string: String = String(character)
        for char in string.unicodeScalars {
            if !self.contains(char) {
                return false
            }
        }
        
        return true
    }
    
}
