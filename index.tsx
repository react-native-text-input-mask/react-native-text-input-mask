import React, { forwardRef, useEffect, useImperativeHandle, useRef, useState } from 'react'

import { findNodeHandle, NativeModules, Platform, TextInput, TextInputProps } from 'react-native'
const { RNTextInputMask } = NativeModules as { RNTextInputMask: MaskOperations }
export const { mask, unmask, setMask } = RNTextInputMask

const TextInputMask = forwardRef<Handles, TextInputMaskProps>(({ maskDefaultValue = true, mask: inputMask, value: defaultValue, multiline, onChangeText, ...rest }, ref) => {
  const input = useRef<TextInput>(null)
  const [value, setValue] = useState<string>()

  useEffect(() => {
    if (maskDefaultValue && inputMask && defaultValue) {
      mask(inputMask, `${defaultValue}`, (text) => setValue(text))
    } else if (!inputMask) {
      setValue(defaultValue)
    }
  }, [])

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
        value={value}
        ref={input}
        multiline={inputMask && Platform.OS === 'ios' ? false : multiline}
        onChangeText={masked => {
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
