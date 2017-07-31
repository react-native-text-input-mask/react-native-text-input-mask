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
#import "RCTUITextField.h"
#import "RNTextInputMask.h"

@import InputMask;

@implementation RNTextInputMask
@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue {
    return self.bridge.uiManager.methodQueue;
}

RCT_EXPORT_METHOD(setMask:(nonnull NSNumber *)reactNode mask:(NSString *)mask) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry ) {
        UIView *view = viewRegistry[reactNode];
        RCTUITextField *textView = ((RCTUITextField *)view);

        dispatch_async(dispatch_get_main_queue(), ^{
            _maskedDelegate = [[MaskedTextFieldDelegate alloc] initWithFormat:mask];
            textView.delegate = _maskedDelegate;
        });
    }];
}
@end
