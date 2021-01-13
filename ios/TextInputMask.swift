import Foundation
import InputMask

@objc(RNTextInputMask)
class TextInputMask: NSObject, RCTBridgeModule, MaskedTextFieldDelegateListener {
    static func moduleName() -> String { return "TextInputMask" }
    
    @objc static func requiresMainQueueSetup() -> Bool {
        true
    }
    
    var methodQueue: DispatchQueue {
        return self.bridge.uiManager.methodQueue
    }
    
    var bridge: RCTBridge!
    var masks: [String: MaskedTextFieldDelegate] = [:]
    
    @objc(mask:inputValue:onResult:)
    func mask(mask: String, inputValue: String, onResult: RCTResponseSenderBlock) {
        let output = RNMask.maskValue(text: inputValue, format: mask)
        onResult([output])
    }
    
    @objc(unmask:inputValue:onResult:)
    func unmask(mask: String, inputValue: String, onResult: RCTResponseSenderBlock) {
        let output = RNMask.unmaskValue(text: inputValue, format: mask)
        onResult([output])
    }
    
    @objc(setMask:mask:)
    func setMask(reactNode: NSNumber, mask: String) {
        self.bridge.uiManager.addUIBlock { (uiManager, viewRegistry) in
            DispatchQueue.main.async {
                guard let view = viewRegistry?[reactNode] as? RCTBaseTextInputView else { return }
                let textView = view.backedTextInputView as! RCTUITextField
                let maskedDelegate = MaskedTextFieldDelegate()
                maskedDelegate.onMaskedTextChangedCallback = { (view, value, complete) in
                    textView.textInputDelegate?.textInputDidChange()
                }
                maskedDelegate.primaryMaskFormat = mask
                maskedDelegate.listener = textView.delegate as? UITextFieldDelegate & MaskedTextFieldDelegateListener
                let key = reactNode.stringValue
                self.masks[key] = maskedDelegate
                textView.delegate = self.masks[key]
            }
        }
    }
}
