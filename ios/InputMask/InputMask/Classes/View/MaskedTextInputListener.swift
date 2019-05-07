//
// Project «InputMask»
// Created by Jeorge Taflanidi
//


import Foundation
import UIKit


@available(iOS 11, *)
public protocol OnMaskedTextChangedListener: AnyObject {
    func textInput(_ textInput: UITextInput, didExtractValue: String, didFillMandatoryCharacters: Bool)
}


@available(iOS 11, *)
@IBDesignable
open class MaskedTextInputListener: NSObject {

    open weak var listener: OnMaskedTextChangedListener?
    open var onMaskedTextChangedCallback: ((_ textInput: UITextInput, _ value: String, _ complete: Bool) -> ())?

    @IBInspectable open var primaryMaskFormat:   String
    @IBInspectable open var autocomplete:        Bool
    @IBInspectable open var autocompleteOnFocus: Bool
    @IBInspectable open var rightToLeft:         Bool
    
    /**
     Shortly after new text is being pasted from the clipboard, ```UITextInput``` receives a new value for its
     `selectedTextRange` property from the system. This new range is not consistent with the formatted text and
     calculated caret position most of the time, yet it's being assigned just after ```set caretPosition``` call.
     
     To ensure correct caret position is set, it is assigned asynchronously (presumably after a vanishingly
     small delay), if caret movement is set to be non-atomic.
     
     Default is ```true```.
     */
    @IBInspectable open var atomicCaretMovement: Bool = true

    open var affineFormats:               [String]
    open var affinityCalculationStrategy: AffinityCalculationStrategy
    open var customNotations:             [Notation]
    
    open var primaryMask: Mask {
        return try! maskGetOrCreate(withFormat: primaryMaskFormat, customNotations: customNotations)
    }
    
    public init(
        primaryFormat: String = "",
        autocomplete: Bool = true,
        autocompleteOnFocus: Bool = true,
        rightToLeft: Bool = false,
        affineFormats: [String] = [],
        affinityCalculationStrategy: AffinityCalculationStrategy = .wholeString,
        customNotations: [Notation] = [],
        onMaskedTextChangedCallback: ((_ textInput: UITextInput, _ value: String, _ complete: Bool) -> ())? = nil
    ) {
        self.primaryMaskFormat = primaryFormat
        self.autocomplete = autocomplete
        self.autocompleteOnFocus = autocompleteOnFocus
        self.rightToLeft = rightToLeft
        self.affineFormats = affineFormats
        self.affinityCalculationStrategy = affinityCalculationStrategy
        self.customNotations = customNotations
        self.onMaskedTextChangedCallback = onMaskedTextChangedCallback
        super.init()
    }
    
    public override init() {
        /**
         Interface Builder support
         
         https://developer.apple.com/documentation/xcode_release_notes/xcode_10_2_release_notes/swift_5_release_notes_for_xcode_10_2
         From known issue no.2:
         
         > To reduce the size taken up by Swift metadata, convenience initializers defined in Swift now only allocate an
         > object ahead of time if they’re calling a designated initializer defined in Objective-C. In most cases, this
         > has no effect on your program, but if your convenience initializer is called from Objective-C, the initial
         > allocation from +alloc is released without any initializer being called.
         */
        self.primaryMaskFormat = ""
        self.autocomplete = true
        self.autocompleteOnFocus = true
        self.rightToLeft = false
        self.affineFormats = []
        self.affinityCalculationStrategy = .wholeString
        self.customNotations = []
        self.onMaskedTextChangedCallback = nil
        super.init()
    }
    
    /**
     Maximal length of the text inside the field.
     
     - returns: Total available count of mandatory and optional characters inside the text field.
     */
    open var placeholder: String {
        return primaryMask.placeholder
    }
    
    /**
     Minimal length of the text inside the field to fill all mandatory characters in the mask.
     
     - returns: Minimal satisfying count of characters inside the text field.
     */
    open var acceptableTextLength: Int {
        return primaryMask.acceptableTextLength
    }
    
    /**
     Maximal length of the text inside the field.
     
     - returns: Total available count of mandatory and optional characters inside the text field.
     */
    open var totalTextLength: Int {
        return primaryMask.totalTextLength
    }
    
    /**
     Minimal length of the extracted value with all mandatory characters filled.
     
     - returns: Minimal satisfying count of characters in extracted value.
     */
    open var acceptableValueLength: Int {
        return primaryMask.acceptableValueLength
    }
    
    /**
     Maximal length of the extracted value.
     
     - returns: Total available count of mandatory and optional characters for extracted value.
     */
    open var totalValueLength: Int {
        return primaryMask.totalValueLength
    }

    @discardableResult
    open func put(text: String, into field: UITextInput, autocomplete putAutocomplete: Bool? = nil) -> Mask.Result {
        let autocomplete: Bool = putAutocomplete ?? self.autocomplete
        let mask: Mask = pickMask(forText: CaretString(string: text), autocomplete: autocomplete)

        let result: Mask.Result = mask.apply(
            toText: CaretString(string: text),
            autocomplete: autocomplete
        )

        field.allText = result.formattedText.string
        field.caretPosition = result.formattedText.string.distanceFromStartIndex(
            to: result.formattedText.caretPosition
        )

        notifyOnMaskedTextChangedListeners(forTextInput: field, result: result)
        return result
    }
    
    @discardableResult
    open func textInput(
        _ textInput: UITextInput,
        isChangingCharactersIn range: NSRange,
        replacementString string: String
    ) -> Mask.Result {
        if isDeletion(inRange: range, string: string, field: textInput) {
            return deleteText(inRange: range, inTextInput: textInput)
        } else {
            return modifyText(inRange: range, inTextInput: textInput, withText: string)
        }
    }
    
    open func isDeletion(inRange range: NSRange, string: String, field: UITextInput) -> Bool {
        let isDeletion = 0 < range.length && 0 == string.count
        if field is UITextView {
            // UITextView edge case
            return isDeletion || (0 == range.length && 0 == range.location && 0 == string.count)
        }
        return isDeletion
    }
    
    open func deleteText(inRange range: NSRange, inTextInput field: UITextInput) -> Mask.Result {
        let updatedText: String = replaceCharacters(inText: field.allText, range: range, withCharacters: "")
        let caretPosition: String.Index = updatedText.startIndex(offsetBy: range.location)

        let mask: Mask = pickMask(
            forText: CaretString(string: updatedText, caretPosition: caretPosition),
            autocomplete: false
        )

        let result: Mask.Result = mask.apply(
            toText: CaretString(string: updatedText, caretPosition: caretPosition),
            autocomplete: false
        )
        
        field.allText = result.formattedText.string
        field.caretPosition = range.location
        
        return result
    }
    
    open func modifyText(inRange range: NSRange, inTextInput field: UITextInput, withText text: String) -> Mask.Result {
        let updatedText: String = replaceCharacters(inText: field.allText, range: range, withCharacters: text)
        let caretPosition: String.Index = updatedText.startIndex(offsetBy: range.location + text.count)
        
        let mask: Mask = pickMask(
            forText: CaretString(string: updatedText, caretPosition: caretPosition),
            autocomplete: autocomplete
        )
        
        let result: Mask.Result = mask.apply(
            toText: CaretString(string: updatedText, caretPosition: caretPosition),
            autocomplete: autocomplete
        )
        
        field.allText = result.formattedText.string
        
        if self.atomicCaretMovement {
            field.caretPosition = result.formattedText.string.distanceFromStartIndex(
                to: result.formattedText.caretPosition
            )
        } else {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                field.caretPosition = result.formattedText.string.distanceFromStartIndex(
                    to: result.formattedText.caretPosition
                )
            }
        }
        
        return result
    }
    
    open func replaceCharacters(inText text: String, range: NSRange, withCharacters newText: String) -> String {
        if 0 < range.length {
            let result = NSMutableString(string: text)
            result.replaceCharacters(in: range, with: newText)
            return result as String
        } else {
            let result = NSMutableString(string: text)
            result.insert(newText, at: range.location)
            return result as String
        }
    }
    
    open func pickMask(forText text: CaretString, autocomplete: Bool) -> Mask {
        guard !affineFormats.isEmpty
        else { return primaryMask }

        let primaryAffinity: Int = affinityCalculationStrategy.calculateAffinity(ofMask: primaryMask, forText: text, autocomplete: autocomplete)
        
        var masksAndAffinities: [MaskAndAffinity] = affineFormats.map { (affineFormat: String) -> MaskAndAffinity in
            let mask = try! maskGetOrCreate(withFormat: affineFormat, customNotations: customNotations)
            let affinity = affinityCalculationStrategy.calculateAffinity(ofMask: mask, forText: text, autocomplete: autocomplete)
            return MaskAndAffinity(mask: mask, affinity: affinity)
        }.sorted { (left: MaskAndAffinity, right: MaskAndAffinity) -> Bool in
            return left.affinity > right.affinity
        }
        
        var insertIndex: Int = -1

        for (index, maskAndAffinity) in masksAndAffinities.enumerated() {
            if primaryAffinity >= maskAndAffinity.affinity {
                insertIndex = index
                break
            }
        }
        
        if (insertIndex >= 0) {
            masksAndAffinities.insert(MaskAndAffinity(mask: primaryMask, affinity: primaryAffinity), at: insertIndex)
        } else {
            masksAndAffinities.append(MaskAndAffinity(mask: primaryMask, affinity: primaryAffinity))
        }
        
        return masksAndAffinities.first!.mask
    }
    
    open func notifyOnMaskedTextChangedListeners(forTextInput textInput: UITextInput, result: Mask.Result) {
        listener?.textInput(textInput, didExtractValue: result.extractedValue, didFillMandatoryCharacters: result.complete)
        onMaskedTextChangedCallback?(textInput, result.extractedValue, result.complete)
    }

    private func maskGetOrCreate(withFormat format: String, customNotations: [Notation]) throws -> Mask {
        if rightToLeft {
            return try RTLMask.getOrCreate(withFormat: format, customNotations: customNotations)
        }
        return try Mask.getOrCreate(withFormat: format, customNotations: customNotations)
    }

    private struct MaskAndAffinity {
        let mask: Mask
        let affinity: Int
    }

    /**
     Workaround to support Interface Builder delegate outlets.

     Allows assigning ```MaskedTextFieldDelegate.listener``` within the Interface Builder.

     Consider using ```MaskedTextFieldDelegate.listener``` property from your source code instead of
     ```MaskedTextFieldDelegate.delegate``` outlet.
     */
    @IBOutlet public var delegate: NSObject? {
        get {
            return self.listener as? NSObject
        }

        set(newDelegate) {
            if let listener = newDelegate as? OnMaskedTextChangedListener {
                self.listener = listener
            }
        }
    }

}


@available(iOS 11, *)
extension MaskedTextInputListener: UITextFieldDelegate {

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if autocompleteOnFocus && (textField.text ?? "").isEmpty {
            let result: Mask.Result = put(text: "", into: textField, autocomplete: true)
            notifyOnMaskedTextChangedListeners(forTextInput: textField, result: result)
        }
    }

    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let result: Mask.Result = textInput(textField, isChangingCharactersIn: range, replacementString: string)
        notifyOnMaskedTextChangedListeners(forTextInput: textField, result: result)
        return false
    }

    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        let result: Mask.Result = put(text: "", into: textField, autocomplete: false)
        notifyOnMaskedTextChangedListeners(forTextInput: textField, result: result)
        return true
    }

}


@available(iOS 11, *)
extension MaskedTextInputListener: UITextViewDelegate {

    public func textViewDidBeginEditing(_ textView: UITextView) {
        if autocompleteOnFocus && textView.text.isEmpty {
            let result: Mask.Result = put(text: "", into: textView, autocomplete: true)
            notifyOnMaskedTextChangedListeners(forTextInput: textView, result: result)
        }
    }

    public func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
    ) -> Bool {
        let result: Mask.Result = textInput(textView, isChangingCharactersIn: range, replacementString: text)
        notifyOnMaskedTextChangedListeners(forTextInput: textView, result: result)
        return false
    }

}
