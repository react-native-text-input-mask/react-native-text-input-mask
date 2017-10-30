//
//  RNMask.swift
//  InputMask
//
//  Created by Ivan Zotov on 8/4/17.
//  Copyright © 2017 Ivan Zotov. All rights reserved.
//

import Foundation

open class RNMask : NSObject {
    public static func maskValue(text: String, format: String) -> String {
        let mask : Mask = try! Mask.getOrCreate(withFormat: format)

        let result: Mask.Result = mask.apply(
            toText: CaretString(
                string: text,
                caretPosition: text.endIndex
            ),
            autocomplete: true
        )

        var maskedString = result.formattedText.string;
                if("currency" == format) {
                    maskedString = text.currencyInputFormatting(showSymbol: false)
                } else if("currency$" == format) {
                    maskedString = text.currencyInputFormatting(showSymbol: true)
                }

        return maskedString;
    }
    
    public static func unmaskValue(text: String, format: String) -> String {
        let mask : Mask = try! Mask.getOrCreate(withFormat: format)

        let result: Mask.Result = mask.apply(
            toText: CaretString(
                string: text,
                caretPosition: text.endIndex
            ),
            autocomplete: true
        )

        return result.extractedValue
    }
}
