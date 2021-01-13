import React, { forwardRef, useEffect, useImperativeHandle, useRef } from 'react'

import { findNodeHandle, NativeModules, Platform, TextInput, TextInputProps } from 'react-native'
const { RNTextInputMask } = NativeModules as { RNTextInputMask: MaskOperations }
const { mask, unmask, setMask } = RNTextInputMask

const TextInputMask = forwardRef<Handles, TextInputMaskProps>(({ maskDefaultValue = true, mask: inputMask, value, multiline, onChangeText, ...rest }, ref) => {
  const input = useRef<TextInput>(null)

  useEffect(() => {
    if (maskDefaultValue && inputMask && value) {
      mask(inputMask, `${value}`, (text) =>
          input.current?.setNativeProps({ text }),
      )
    }
    const nodeId = findNodeHandle(input.current)
    if (inputMask && nodeId) {
      setMask(nodeId, inputMask)
    }
  }, [maskDefaultValue, inputMask, value])

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
        value={undefined}
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
