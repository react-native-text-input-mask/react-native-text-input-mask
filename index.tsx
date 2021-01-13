import React, { useEffect, useImperativeHandle } from 'react'

import { findNodeHandle, NativeModules, Platform, TextInput, TextInputProps } from 'react-native'

export const { mask, unmask, setMask } = NativeModules.RNTextInputMask as MaskOperations

const TextInputMask = React.forwardRef<Handles, TextInputMaskProps>(({ maskDefaultValue = true, mask: maskProp, value, multiline, onChangeText, ...rest }, ref) => {
  const input = React.useRef<TextInput>(null)

  useEffect(() => {
    if (maskDefaultValue && maskProp && value) {
      mask(maskProp, `${value}`, (text) =>
          input.current?.setNativeProps({ text }),
      )
    }
    const nodeId = findNodeHandle(input.current)
    if (maskProp && nodeId) {
      setMask(nodeId, maskProp)
    }
  }, [maskDefaultValue, maskProp, value])

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
        multiline={maskProp && Platform.OS === 'ios' ? false : multiline}
        onChangeText={masked => {
          if (maskProp) {
            unmask(maskProp, masked, (unmasked) => {
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
