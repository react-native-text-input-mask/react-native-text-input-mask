import React, {
  DependencyList,
  forwardRef,
  useEffect,
  useImperativeHandle,
  useRef,
  useState
} from 'react'

import { findNodeHandle, NativeModules, Platform, TextInput, TextInputProps } from 'react-native'
const { RNTextInputMask } = NativeModules as { RNTextInputMask: MaskOperations }
export const { mask, unmask, setMask } = RNTextInputMask

const TextInputMask = forwardRef<Handles, TextInputMaskProps>(({ maskDefaultValue = true, mask: inputMask, defaultValue, value, multiline, onChangeText, autocomplete= true, autoskip = true, ...rest }, ref) => {
  const input = useRef<TextInput>(null)
  const [maskedDefaultValue, setMaskedDefaultValue] = useState<string>()

  // hold onto masked value while editing input to prevent useEffect trigger while editing
  const currentMaskedValue = useRef<string>()

  useEffectAsync(async () => {
    if (maskDefaultValue && inputMask && defaultValue) {
      const text = await mask(inputMask, defaultValue)
      setMaskedDefaultValue(text)
    } else if (!inputMask) {
      setMaskedDefaultValue(defaultValue)
    }
  }, [])

  useEffectAsync(async () => {
    // don't update state value if value is same as current value reference
    if (value === currentMaskedValue.current) return
    if (inputMask && value) {
      const text = await mask(inputMask, value)
        input.current?.setNativeProps({ text })
      input.current?.setNativeProps({ text })
    } else if (!inputMask && value) {
      input.current?.setNativeProps({ text: value })
    }
  }, [value])

  useEffect(() => {
    const nodeId = findNodeHandle(input.current)
    if (inputMask && nodeId) {
      setMask(nodeId, inputMask, autocomplete, autoskip)
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
          defaultValue={maskedDefaultValue}
          ref={input}
          multiline={inputMask && Platform.OS === 'ios' ? false : multiline}
          onChangeText={async (masked) => {
            currentMaskedValue.current = masked
            if (inputMask) {
              const unmasked = await unmask(inputMask, masked)
                onChangeText?.(masked, unmasked)
              onChangeText?.(masked, unmasked)
            } else {
              onChangeText?.(masked)
            }
          }}
      />
  )
})

export const useEffectAsync = (
    operation: () => Promise<void>,
    deps?: DependencyList
) => {
  useEffect(() => {
    operation().then()
  }, deps)
}

interface MaskOperations {
  mask: (mask: string, value: string) => Promise<string>,
  unmask: (mask: string, value: string) => Promise<string>
  setMask: (reactNode: number, mask: string, autocomplete: boolean, autoskip: boolean) => void
}

export interface TextInputMaskProps extends TextInputProps {
  maskDefaultValue?: boolean
  mask?: string
  onChangeText?: (formatted: string, extracted?: string) => void
  /**
   * autocomplete pattern while editing text
   */
  autocomplete?: boolean
  /**
   * automatically remove mask characters on backspace
   */
  autoskip?: boolean
}

interface Handles {
  focus: () => void
  blur: () => void
}

export default TextInputMask
