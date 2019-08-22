#import <React/RCTBridgeModule.h>

//! Project version number for RNTextInputMask.
FOUNDATION_EXPORT double RNTextInputMaskVersionNumber;

//! Project version string for RNTextInputMask.
FOUNDATION_EXPORT const unsigned char RNTextInputMaskVersionString[];

@protocol MaskedTextFieldDelegateListener;

@interface RNTextInputMask : NSObject <RCTBridgeModule, MaskedTextFieldDelegateListener>
@end
