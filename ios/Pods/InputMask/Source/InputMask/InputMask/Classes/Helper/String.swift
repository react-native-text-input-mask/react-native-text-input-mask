//
//  InputMask
//
//  Created by Egor Taflanidi on 10.08.28.
//  Copyright © 28 Heisei Egor Taflanidi. All rights reserved.
//

import Foundation


/**
 Utility extension for comonly used ```Mask``` operations upon strings.
 */
extension String {
    
    /**
     Make a string by cutting the first character of current.
     
     - returns: Current string without first character.
     
     - throws: EXC_BAD_INSTRUCTION for empty strings.
     */
    func truncateFirst() -> String {
        return self.substring(from: self.index(after: self.startIndex))
    }
    
}
