import { useState, useEffect, DependencyList, useCallback } from "react";
import {
  findNodeHandle,
  NativeModules,
  Platform,
  TextInputProps,
} from "react-native";
import {
  MaskOperations,
  UseTextnputMaskArgs as UseTextInputMaskArgs,
} from "./types";

const { RNTextInputMask } = NativeModules as {
  RNTextInputMask: MaskOperations;
};

if (!RNTextInputMask) {
  throw new Error(`NativeModule: RNTextInputMask is null.
  To fix this issue try these steps:
    • Rebuild and restart the app.
    • Run the packager with \`--clearCache\` flag.
    • If happening on iOS, run \`pod install\` in the \`ios\` directory and then rebuild and re-run the app.
    • If this happens while testing with Jest, make sure to follow instructions in https://github.com/react-native-text-input-mask/react-native-text-input-mask#testing
  `);
}

export const { mask, unmask, setMask } = RNTextInputMask;

export const useTextInputMask = (
  args: UseTextInputMaskArgs
): TextInputProps => {
  const {
    mask: primaryFormat,
    defaultValue,
    value,
    multiline,
    onChangeText,
    affineFormats,
    customNotations,
    affinityCalculationStrategy,
    autocomplete = true,
    autoskip = true,
    rightToLeft,
    inputRef,
    ...rest
  } = args;

  const [maskedValue, setMaskedValue] = useState<string>();

  useEffectAsync(async () => {
    const initialValue = value ?? defaultValue;
    if (!initialValue) return;
    if (primaryFormat) {
      const masked = await mask(primaryFormat, initialValue, false);
      setMaskedValue(masked);
    } else {
      setMaskedValue(initialValue);
    }
  }, []);

  useEffectAsync(async () => {
    if (value === maskedValue) return;
    if (primaryFormat && value) {
      const masked = await mask(primaryFormat, value, false);
      setMaskedValue(masked);
    } else {
      setMaskedValue(value);
    }
  }, [value, primaryFormat]);

  useEffect(() => {
    const nodeId = findNodeHandle(inputRef.current);
    if (primaryFormat && nodeId) {
      setMask(nodeId, primaryFormat, {
        affineFormats,
        affinityCalculationStrategy,
        customNotations,
        autocomplete,
        autoskip,
        rightToLeft,
      });
    }
  }, [primaryFormat]);

  const handleChangeText = useCallback(
    async (masked: string) => {
      setMaskedValue(masked);
      if (primaryFormat) {
        const unmasked = await unmask(primaryFormat, masked, true);
        onChangeText?.(masked, unmasked);
      } else {
        onChangeText?.(masked);
      }
    },
    [primaryFormat, onChangeText]
  );

  const isMultiline =
    primaryFormat && Platform.OS === "ios" ? false : multiline;

  return {
    value: maskedValue,
    multiline: isMultiline,
    onChangeText: handleChangeText,
    ...rest,
  };
};

const useEffectAsync = (
  operation: () => Promise<void>,
  deps?: DependencyList
) => {
  useEffect(() => {
    operation().then();
  }, deps);
};
