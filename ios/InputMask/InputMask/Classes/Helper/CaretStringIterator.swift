//
// Project «InputMask»
// Created by Jeorge Taflanidi
//


import Foundation


/**
 ### CaretStringIterator
 
 Iterates over CaretString.string characters. Each ```next()``` call returns current character and adjusts iterator 
 position.
 
 ```CaretStringIterator``` is used by the ```Mask``` instance to iterate over the string that should be formatted.
 */
class CaretStringIterator {
    
    let caretString: CaretString
    var currentIndex: String.Index
    
    /**
     Constructor
     
     - parameter caretString: ```CaretString``` object, over which the iterator is going to iterate.
     
     - returns: Initialized ```CaretStringIterator``` pointing at the beginning of provided ```CaretString.string```
     */
    init(caretString: CaretString) {
        self.caretString  = caretString
        self.currentIndex = self.caretString.string.startIndex
    }
    
    /**
     Inspect, whether ```CaretStringIterator``` has reached ```CaretString.caretPosition``` or not.
     
     Each ```CaretString``` object contains cursor position for its ```CaretString.string```. 
     
     For the ```Mask``` instance it is important to know, whether it should adjust the cursor position or not when
     inserting new symbols into the formatted line.
     
     **Example**
     
     Let the ```CaretString``` instance contains two symbols, with the caret at the end of the line.
     ```
     string:    ab
     caret:      ^
     ```
     In this case ```CaretStringIterator.beforeCaret()``` will always return ```true``` until there's no more
     characters left in the line to iterate over.
     
     **Example 2**
     
     Let the ```CaretString``` instance contains two symbols, with the caret at the beginning of the line.
     ```
     string:    ab
     caret:     ^
     ```
     In this case ```CaretStringIterator.beforeCaret()``` will only return ```true``` for the first iteration. After the
     ```next()``` method is fired, ```beforeCaret()``` will return false.
     
     - returns: ```True```, if current iterator position is less than or equal to ```CaretString.caretPosition```
     */
    func beforeCaret() -> Bool {
        let currentIndex:  Int = self.caretString.string.distanceFromStartIndex(to: self.currentIndex)
        let caretPosition: Int = self.caretString.string.distanceFromStartIndex(to: self.caretString.caretPosition)
        
        return self.currentIndex <= self.caretString.caretPosition
            || (0 == currentIndex && 0 == caretPosition)
    }
    
    /**
     Iterate over the ```CaretString.string```
     
     - postcondition: Iterator position is moved to the next symbol.
     
     - returns: Current symbol. If the iterator reached the end of the line, returns ```nil```.
     */
    func next() -> Character? {
        if self.currentIndex >= self.caretString.string.endIndex {
            return nil
        }
        
        let character: Character = self.caretString.string[self.currentIndex]
        self.currentIndex = self.caretString.string.index(after: self.currentIndex)
        return character
    }
    
}
