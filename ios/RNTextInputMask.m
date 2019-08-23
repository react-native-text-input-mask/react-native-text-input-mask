#import <React/RCTBridge.h>
#import <React/RCTConvert.h>
#import <React/RCTUIManager.h>
#import "RCTBaseTextInputView.h"
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
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *, RCTBaseTextInputView *> *viewRegistry ) {
        dispatch_async(dispatch_get_main_queue(), ^{
            RCTBaseTextInputView *view = viewRegistry[reactNode];
            RCTUITextField *textView = [view backedTextInputView];

            if (!masks) {
                masks = [[NSMutableDictionary alloc] init];
            }

            NSString *key = [NSString stringWithFormat:@"%@", reactNode];
            MaskedTextFieldDelegate* maskedDelegate = [MaskedTextFieldDelegate new];
            maskedDelegate.onMaskedTextChangedCallback = ^(UITextField *view, NSString *value, BOOL complete) {
                [textView.textInputDelegate textInputDidChange];
            };
            maskedDelegate.primaryMaskFormat = mask;
            maskedDelegate.listener = textView.delegate;
            masks[key] = maskedDelegate;
            textView.delegate = masks[key];
        });
    }];
}
@end
