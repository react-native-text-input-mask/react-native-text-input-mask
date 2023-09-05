import React, { forwardRef, useImperativeHandle, useRef } from "react";

import { TextInput } from "react-native";
import { Handles, TextInputMaskProps } from "./types";
import { useTextInputMask } from "./useTextInputMask";

export const TextInputMask = forwardRef<Handles, TextInputMaskProps>(
  (props, ref) => {
    const inputRef = useRef<TextInput>(null);

    const inputProps = useTextInputMask({ ...props, inputRef });

    useImperativeHandle(ref, () => ({
      focus: () => {
        inputRef.current?.focus();
      },
      blur: () => {
        inputRef.current?.blur();
      },
    }));

    return <TextInput ref={inputRef} {...inputProps} />;
  }
);
