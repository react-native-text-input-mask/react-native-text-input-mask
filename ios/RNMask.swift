//
//  RNMask.swift
//  InputMask
//
//  Created by Ivan Zotov on 8/4/17.
//  Copyright © 2017 Ivan Zotov. All rights reserved.
//
import Foundation
import InputMask

@objcMembers
open class RNMask : NSObject {
    public static func maskValue(text: String, format: String, autcomplete: Bool) -> String {
        let mask : Mask = try! Mask.getOrCreate(withFormat: format)

        let result: Mask.Result = mask.apply(
            toText: CaretString(
                string: text,
                caretPosition: text.endIndex,
                caretGravity: CaretString.CaretGravity.forward(autocomplete: autcomplete)
            )
        )

        return result.formattedText.string
    }

    public static func unmaskValue(text: String, format: String, autocomplete: Bool) -> String {
        let mask : Mask = try! Mask.getOrCreate(withFormat: format)

        let result: Mask.Result = mask.apply(
            toText: CaretString(
                string: text,
                caretPosition: text.endIndex,
                caretGravity: CaretString.CaretGravity.forward(autocomplete: autocomplete)
            )
        )

        return result.extractedValue
    }
}
