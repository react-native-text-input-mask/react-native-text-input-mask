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

// formatting text for currency textField
extension String {
    func currencyInputFormatting(showSymbol: String, precision: Int, omittingRedundantCharacters: Bool = false) -> String {
        if isEmpty { return showSymbol + self }
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = showSymbol
        formatter.minimumFractionDigits = 0
        formatter.minimumIntegerDigits = 1
        formatter.maximumFractionDigits = precision
        formatter.roundingMode = .down
        
        var amountWithoutPrefix = self
        
        guard let regex = try? NSRegularExpression(pattern: "[^.0-9]", options: .caseInsensitive) else {
            return showSymbol + self
        }
        
        amountWithoutPrefix = regex.stringByReplacingMatches(in: amountWithoutPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithoutPrefix as NSString).doubleValue
        number = NSNumber(value: double)
        
        if omittingRedundantCharacters {
            return formatter.string(from: number)!
        }
        
        var dividers = amountWithoutPrefix.split(separator: ".", omittingEmptySubsequences: false)
        if dividers.count > 2 {
            amountWithoutPrefix.removeLast()
            dividers.removeLast()
        }
        
        if dividers.count > 1 {
            let fractionDigitNumber = min(dividers[1].count, precision)
            let fractionPart = dividers[1]
            amountWithoutPrefix = formatter.string(from: NSNumber(value: round(double)))!
            if precision > 0 {
                amountWithoutPrefix += "."
            }
            if fractionDigitNumber > 0 {
                amountWithoutPrefix += String(fractionPart[..<fractionPart.index(fractionPart.startIndex, offsetBy: fractionDigitNumber)])
            }
            return amountWithoutPrefix
        }
        
        return formatter.string(from: number) ?? (showSymbol + amountWithoutPrefix)
    }
}
