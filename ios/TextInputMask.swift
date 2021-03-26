import Foundation
import InputMask

@objc(RNTextInputMask)
class TextInputMask: NSObject, RCTBridgeModule, MaskedTextFieldDelegateListener {
    static func moduleName() -> String {
        "TextInputMask"
    }

    @objc static func requiresMainQueueSetup() -> Bool {
        true
    }

    var methodQueue: DispatchQueue {
        bridge.uiManager.methodQueue
    }

    var bridge: RCTBridge!
    var masks: [String: MaskedTextFieldDelegate] = [:]

    var listeners: [String: MaskedTextFieldDelegateListener] = [:]

    @objc(mask:inputValue:autocomplete:resolver:rejecter:)
    func mask(mask: String, inputValue: String, autocomplete: Bool, resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
        let output = RNMask.maskValue(text: inputValue, format: mask, autcomplete: autocomplete)
        resolve(output)
    }

    @objc(unmask:inputValue:autocomplete:resolver:rejecter:)
    func unmask(mask: String, inputValue: String, autocomplete: Bool, resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
        let output = RNMask.unmaskValue(text: inputValue, format: mask, autocomplete: autocomplete)
        resolve(output)
    }

    @objc(setMask:mask:options:)
    func setMask(reactNode: NSNumber, mask: String, options: NSDictionary) {
        bridge.uiManager.addUIBlock { (uiManager, viewRegistry) in
            DispatchQueue.main.async {
                guard let view = viewRegistry?[reactNode] as? RCTBaseTextInputView else { return }
                let textView = view.backedTextInputView as! RCTUITextField
                let autocomplete = options["autocomplete"] as? Bool ?? true
                let autoskip = options["autoskip"] as? Bool ?? false
                let affineFormats = options["affineFormats"] as? [String] ?? []
                let customNotations = (options["customNotations"] as? [[String:Any]])?.map { $0.toNotation() } ?? []
                let rightToLeft = options["rightToLeft"] as? Bool ?? false
                var affinityCalculationStrategy = AffinityCalculationStrategy.forString(rawValue: options["affinityCalculationStrategy"] as? String)
                
                let maskedDelegate = MaskedTextFieldDelegate(primaryFormat: mask, autocomplete: autocomplete, autoskip: autoskip, affineFormats: affineFormats, customNotations: customNotations) { (_, value, complete) in
                    // trigger onChange directly to avoid trigger a second evaluation in native code (causes issue with some input masks like [00] {/} [00]
                    let textField = textView as! UITextField
                    view.onChange?([
                        "text": textField.text,
                        "target": view.reactTag,
                        "eventCount": view.nativeEventCount,
                    ])
                }
                let key = reactNode.stringValue
                self.listeners[key] = MaskedRCTBackedTextFieldDelegateAdapter(textField: textView)
                maskedDelegate.listener = self.listeners[key]
                self.masks[key] = maskedDelegate

                textView.delegate = self.masks[key]
            }
        }
    }
}

class MaskedRCTBackedTextFieldDelegateAdapter : RCTBackedTextFieldDelegateAdapter, MaskedTextFieldDelegateListener {}

extension Dictionary where Key == String, Value == Any {
    func toNotation() -> Notation {
        let character = Array((self["character"] as! String))[0]
        let characterSet = CharacterSet(charactersIn: (self["characterSet"] as! String))
        let isOptional = self["isOptional"] as! Bool
        return Notation(character: character, characterSet: characterSet, isOptional: isOptional)
    }
}

extension AffinityCalculationStrategy {
    static func forString(rawValue: String?) -> AffinityCalculationStrategy? {
        if (rawValue == nil) {
            return nil
        }
        switch rawValue {
            case "WHOLE_STRING":
                return AffinityCalculationStrategy.wholeString
            case "PREFIX":
                return AffinityCalculationStrategy.prefix
            case "CAPACITY":
                return AffinityCalculationStrategy.capacity
            case "EXTRACTED_VALUE_CAPACITY":
                return AffinityCalculationStrategy.extractedValueCapacity
            default:
                return nil
        }
    }
}
