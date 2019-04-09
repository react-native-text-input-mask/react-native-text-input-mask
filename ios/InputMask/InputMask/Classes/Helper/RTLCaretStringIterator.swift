//
// Project «InputMask»
// Created by Jeorge Taflanidi
//


import Foundation


class RTLCaretStringIterator: CaretStringIterator {
    override func beforeCaret() -> Bool {
        return self.currentIndex < self.caretString.caretPosition
    }
}
