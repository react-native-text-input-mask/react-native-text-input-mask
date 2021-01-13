#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNTextInputMask, NSObject)

RCT_EXTERN_METHOD(mask:(NSString *)maskString inputValue:(NSString *)inputValue onResult:(RCTResponseSenderBlock)onResult)

RCT_EXTERN_METHOD(unmask:(NSString *)maskString inputValue:(NSString *)inputValue onResult:(RCTResponseSenderBlock)onResult)

RCT_EXTERN_METHOD(setMask:(nonnull NSNumber *)reactNode mask:(NSString *)mask)

@end
