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

if (!RNTextInputMask) {
  throw new Error(`NativeModule: RNTextInputMask is null.
To fix this issue try these steps:
  • Rebuild and restart the app.
  • Run the packager with \`--clearCache\` flag.
  • If happening on iOS, run \`pod install\` in the \`ios\` directory and then rebuild and re-run the app.
  • If this happens while testing with Jest, make sure to follow instructions in https://github.com/react-native-text-input-mask/react-native-text-input-mask#testing
`);
}

export const { mask, unmask, setMask } = RNTextInputMask

const TextInputMask = forwardRef<Handles, TextInputMaskProps>(({ mask: inputMask, defaultValue, value , multiline, onChangeText, autocomplete= true, autoskip = true, ...rest }, ref) => {
  const input = useRef<TextInput>(null)
  const [ maskedValue, setMaskedValue ] = useState<string>()

  useEffectAsync(async () => {
    if (!defaultValue) return
    if (inputMask) {
      const masked = await mask(inputMask, defaultValue, false)
      setMaskedValue(masked)
    } else {
      setMaskedValue(defaultValue)
    }
  }, [])

  useEffectAsync(async () => {
    if (value === maskedValue) return
    if (inputMask && value) {
      const masked = await mask(inputMask, value, false)
      setMaskedValue(masked)
    } else {
      setMaskedValue(value)
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
          ref={input}
          value={maskedValue}
          multiline={inputMask && Platform.OS === 'ios' ? false : multiline}
          onChangeText={async (masked) => {
            setMaskedValue(masked)
            if (inputMask) {
              const unmasked = await unmask(inputMask, masked, true)
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
  mask: (mask: string, value: string, autocomplete: boolean) => Promise<string>,
  unmask: (mask: string, value: string, autocomplete: boolean) => Promise<string>
  setMask: (reactNode: number, mask: string, autocomplete: boolean, autoskip: boolean) => void
}

export interface TextInputMaskProps extends TextInputProps {
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
