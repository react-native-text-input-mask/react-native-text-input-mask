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
#import "RCTTextField.h"
#import "RCTUITextField.h"
#import "RNTextInputMask.h"

@import InputMask;

@implementation RNTextInputMask
@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue {
    return self.bridge.uiManager.methodQueue;
}

RCT_EXPORT_METHOD(mask:(NSString *)maskString inputValue:(NSString *)inputValue onResult:(RCTResponseSenderBlock)onResult) {
    NSString *output = [RNMask maskValueWithText:inputValue format:maskString];
    onResult(@[output]);
}

RCT_EXPORT_METHOD(setMask:(nonnull NSNumber *)reactNode mask:(NSString *)mask) {
    _reactTag = reactNode;

    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *, RCTTextField *> *viewRegistry ) {
        _view = viewRegistry[reactNode];
        RCTUITextField *textView = [_view textField];

        dispatch_async(dispatch_get_main_queue(), ^{
            _maskedDelegate = [[MaskedTextFieldDelegate alloc] initWithFormat:mask];
            _maskedDelegate.listener = self;
            textView.delegate = _maskedDelegate;
        });
    }];
}

- (void)textField:(RCTUITextField *)textField didFillMandatoryCharacters:(BOOL)complete didExtractValue:(NSString *)value
{
    [self.bridge.eventDispatcher sendTextEventWithType:RCTTextEventTypeChange
                                   reactTag:_reactTag
                                       text:textField.text
                                        key:nil
                                 eventCount:1];
}

@end
