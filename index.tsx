import React, { forwardRef, useEffect, useImperativeHandle, useRef, useState } from 'react'

import { findNodeHandle, NativeModules, Platform, TextInput, TextInputProps } from 'react-native'
const { RNTextInputMask } = NativeModules as { RNTextInputMask: MaskOperations }
export const { mask, unmask, setMask } = RNTextInputMask

const TextInputMask = forwardRef<Handles, TextInputMaskProps>(({ maskDefaultValue = true, mask: inputMask, defaultValue, value, multiline, onChangeText, ...rest }, ref) => {
  const input = useRef<TextInput>(null)
  const [maskedValue, setMaskedValue] = useState<string>()
  const [maskedDefaultValue, setMaskedDefaultValue] = useState<string>()

  // hold onto masked value while editing input to prevent useEffect trigger while editing
  const currentMaskedValue = useRef<string>()

  useEffect(() => {
    if (maskDefaultValue && inputMask && defaultValue) {
      mask(inputMask, defaultValue, (text) => setMaskedDefaultValue(text))
    } else if (!inputMask) {
      setMaskedDefaultValue(defaultValue)
    }
  }, [inputMask, defaultValue])

  useEffect(() => {
    // don't update state value if value is same as current value reference
    if (value === currentMaskedValue.current) return
    if (inputMask && value) {
      mask(inputMask, value, (text) => setMaskedValue(text))
    } else if (!inputMask) {
      setMaskedValue(value)
    }
  }, [inputMask, value])

  useEffect(() => {
    const nodeId = findNodeHandle(input.current)
    if (inputMask && nodeId) {
      setMask(nodeId, inputMask)
    }
  }, [inputMask])

  useImperativeHandle(ref, () => ({
    focus: () => {
      input.current?.focus()
    },
    blur: () => {
      input.current?.blur()
    }
  }))

  return (
      <TextInput
          {...rest}
          value={maskedValue}
          defaultValue={maskedDefaultValue}
          ref={input}
          multiline={inputMask && Platform.OS === 'ios' ? false : multiline}
          onChangeText={masked => {
            currentMaskedValue.current = masked
            if (inputMask) {
              unmask(inputMask, masked, (unmasked) => {
                onChangeText?.(masked, unmasked)
              })
            } else {
              onChangeText?.(masked)
            }
          }}
      />
  )
})

interface MaskOperations {
  mask: (mask: string, value: string, onResult: (masked: string) => void) => void,
  unmask: (mask: string, value: string, onResult: (unmasked: string) => void) => void
  setMask: (reactNode: number, mask: string) => void
}

export interface TextInputMaskProps extends TextInputProps {
  maskDefaultValue?: boolean
  mask?: string
  onChangeText?: (formatted: string, extracted?: string) => void
}

interface Handles {
  focus: () => void
  blur: () => void
}

export default TextInputMask
