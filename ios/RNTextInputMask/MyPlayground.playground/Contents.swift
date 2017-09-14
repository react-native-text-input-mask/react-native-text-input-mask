//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let amount: Double = 123.45
let amountString = String(format: "$%.02f", amount)

let myString = "556.294"
let myFloat = (myString as NSString).doubleValue

let formatter = NumberFormatter()
formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
formatter.numberStyle = .currency
if let formattedTipAmount = formatter.string(from: myFloat as NSNumber) {
    let finalText = "Tip Amount: \(formattedTipAmount)"
}