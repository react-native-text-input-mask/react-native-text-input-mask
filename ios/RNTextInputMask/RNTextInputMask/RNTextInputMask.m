//
//  RNTextInputMask.m
//  RNTextInputMask
//
//  Created by Ivan Zotov on 7/29/17.
//
//

#import <React/RCTBridge.h>
#import <React/RCTConvert.h>
#import <React/RCTUIManager.h>
#import <React/RCTEventDispatcher.h>
#import "RCTSinglelineTextInputView.h"
#import "RCTUITextField.h"
#import "RNTextInputMask.h"

@import InputMask;

@implementation RNTextInputMask {
    NSMutableDictionary *masks;
}

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue {
    return self.bridge.uiManager.methodQueue;
}

RCT_EXPORT_METHOD(mask:(NSString *)maskString inputValue:(NSString *)inputValue onResult:(RCTResponseSenderBlock)onResult) {
    NSString *output = [RNMask maskValueWithText:inputValue format:maskString];
    onResult(@[output]);
}

RCT_EXPORT_METHOD(unmask:(NSString *)maskString inputValue:(NSString *)inputValue onResult:(RCTResponseSenderBlock)onResult) {
    NSString *output = [RNMask unmaskValueWithText:inputValue format:maskString];
    onResult(@[output]);
}

RCT_EXPORT_METHOD(setMask:(nonnull NSNumber *)reactNode mask:(NSString *)mask) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *, RCTSinglelineTextInputView *> *viewRegistry ) {
        dispatch_async(dispatch_get_main_queue(), ^{
            RCTSinglelineTextInputView *view = viewRegistry[reactNode];
            RCTUITextField *textView = [view backedTextInputView];
            
            if (!masks) {
                masks = [[NSMutableDictionary alloc] init];
            }
            
            NSString *key = [NSString stringWithFormat:@"%@", reactNode];
            MaskedTextFieldDelegate* maskedDelegate = [[MaskedTextFieldDelegate alloc] initWithFormat:mask];
            masks[key] = maskedDelegate;
            [masks[key] setListener:self];
            textView.delegate = masks[key];
            
            [self updateTextField:maskedDelegate textView:textView];
        });
    }];
}

- (void)textField:(RCTUITextField *)textField didFillMandatoryCharacters:(BOOL)complete didExtractValue:(NSString *)value
{
    [self.bridge.eventDispatcher sendTextEventWithType:RCTTextEventTypeChange
                                              reactTag:[[textField reactSuperview] reactTag]
                                                  text:textField.attributedText.string
                                                   key:nil
                                            eventCount:1];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.bridge.eventDispatcher sendTextEventWithType:RCTTextEventTypeFocus
                                              reactTag:[[textField reactSuperview] reactTag]
                                                  text:textField.attributedText.string
                                                   key:nil
                                            eventCount:1];
}

- (void)textFieldDidEndEditing:(RCTUITextField *)textField
{
    [self.bridge.eventDispatcher sendTextEventWithType:RCTTextEventTypeBlur
                                              reactTag:[[textField reactSuperview] reactTag]
                                                  text:textField.attributedText.string
                                                   key:nil
                                            eventCount:1];
}


- (void)updateTextField:(MaskedTextFieldDelegate *)maskedDelegate textView:(RCTUITextField *)textView {
    if(textView.attributedText.string.length> 0){
        NSString *originalString = textView.attributedText.string;
        NSString *croppedText = [originalString substringToIndex:[originalString length] -1];
        
        [textView setAttributedText:[[NSAttributedString alloc] initWithString:croppedText]];
        NSString *last = [originalString substringFromIndex:[originalString length] - 1];
        
        [maskedDelegate textField:(UITextField*)textView
    shouldChangeCharactersInRange: (NSRange){[textView.attributedText.string length], 0}
                replacementString:last];
    }
}

@end

