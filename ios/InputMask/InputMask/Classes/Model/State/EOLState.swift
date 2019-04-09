//
// Project «InputMask»
// Created by Jeorge Taflanidi
//


import Foundation


/**
 ### EOLState
 
 End-of-line state. Serves as mask format terminator character.
 
 Does not accept any character. Always returns ```self``` as the next state, ignoring the child state given during
 initialization.
 */
class EOLState: State {
    
    convenience init() {
        self.init(child: nil)
    }
    
    override init(child: State?) {
        super.init(child: nil)
    }
    
    override func nextState() -> State {
        return self
    }
    
    override func accept(character char: Character) -> Next? {
        return nil
    }
    
    override var debugDescription: String {
        return "EOL"
    }
    
}
