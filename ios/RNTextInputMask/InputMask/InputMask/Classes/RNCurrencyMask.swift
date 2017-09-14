//
//  RNCurrencyMask.swift
//  InputMask
//
//  Created by Mark Mathis on 9/14/17.
//  Copyright © 2017 Egor Taflanidi. All rights reserved.
//

import Foundation

public class RNCurrencyMask : NSObject {
    public static func maskValue(text: String) -> String {
        return "$0.00";
    }
    
    public static func unmaskValue(text: String) -> String {
        return "0";
    }
}
