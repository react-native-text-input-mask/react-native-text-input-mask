import React, { useEffect, useRef, useState } from 'react';
import PropTypes from 'prop-types';
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

TextInputMask.propTypes = {
  mask: PropTypes.string.isRequired,
  value: PropTypes.string.isRequired,
  maskDefaultValue: PropTypes.bool.isRequired,
  refInput: PropTypes.func,
  multiline: PropTypes.bool,
  onChangeText: PropTypes.func.isRequired,
}

TextInputMask.defaultProps = {
  maskDefaultValue: true,
  multiline: false,
  refInput: () => null,
}

export default TextInputMask;
