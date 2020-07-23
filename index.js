import React, { useEffect, useRef, useState, forwardRef } from 'react';
import {
  TextInput,
  findNodeHandle,
  NativeModules,
  Platform,
} from 'react-native';

export const nativeMask = NativeModules.RNTextInputMask.mask;
export const nativeUnmask = NativeModules.RNTextInputMask.unmask;
export const nativeSetMask = NativeModules.RNTextInputMask.setMask;

const TextInputMask = ({
  mask,
  value,
  maskDefaultValue,
  refInput,
  multiline,
  onChangeText,
  ...rest
}) => {
  const [masked, setMasked] = useState(false);
  const input = useRef(null);

  useEffect(() => {
    if (
      maskDefaultValue &&
      mask &&
      value
    ) {
      mask(mask, value, text => input?.setNativeProps({ text }));
    }

    if (mask && !masked) {
      setMasked(true);
      nativeSetMask(findNodeHandle(input.current), mask);
    }
  }, [mask, masked]);

  const handleChangeText = maskedText => {
    if (mask) {
      nativeUnmask(mask, maskedText, unmasked => {
        onChangeText(maskedText, unmasked);
      });
    } else {
      onChangeText(maskedText);
    }
  };

  const setRefComponent = componentRef => {
    input.current = componentRef;

    if (typeof refInput === 'function') {
      refInput(componentRef);
    }
  };

  return (
    <TextInput
      value={undefined}
      ref={setRefComponent}
      multiline={mask && Platform.OS === 'ios' ? false : multiline}
      onChangeText={handleChangeText}
      {...rest}
    />
  )
}

const ForwardedTextInputMask = ({ mask, ...props }, ref) => (
  <TextInput 
    key={mask}
    ref={refInput => {
      if (ref) {
        if (typeof ref === 'function') {
          ref(refInput)
        } else if (typeof ref === 'object' && ref !== null) {
          ref.current = refInput;
        }
      }
    }}
    {...props}
  />
);

export default forwardRef(ForwardedTextInputMask);
