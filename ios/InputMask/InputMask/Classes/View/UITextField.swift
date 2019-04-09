//
// Project «InputMask»
// Created by Jeorge Taflanidi
//


import Foundation
import UIKit


@available(iOS, introduced: 8, deprecated: 11, message: "Use UITextInput extension instead")
public extension UITextField {
    
    var cursorPosition: Int {
        get {
            // Workaround for non-optional `beginningOfDocument`, which could actually be nil if field doesn't have focus
            guard isFirstResponder
            else { return text?.count ?? 0 }
            
            if let range: UITextRange = selectedTextRange {
                let selectedTextLocation: UITextPosition = range.start
                return offset(from: beginningOfDocument, to: selectedTextLocation)
            } else {
                return 0
            }
        }
        
        set(newPosition) {
            // Workaround for non-optional `beginningOfDocument`, which could actually be nil if field doesn't have focus
            guard isFirstResponder
            else { return }
            
            if newPosition > text?.count ?? 0 {
                return
            }
            
            let from: UITextPosition = position(from: beginningOfDocument, offset: newPosition)!
            let to:   UITextPosition = position(from: from, offset: 0)!
            selectedTextRange = textRange(from: from, to: to)
        }
    }
    
}
