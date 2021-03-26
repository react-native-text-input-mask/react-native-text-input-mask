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

const TextInputMask = forwardRef<Handles, TextInputMaskProps>(({
    mask: primaryFormat,
    defaultValue,
    value ,
    multiline,
    onChangeText,
    affineFormats,
    customNotations,
    affinityCalculationStrategy,
    autocomplete= true,
    autoskip = true,
    rightToLeft,
    ...rest
}, ref) => {
  const input = useRef<TextInput>(null)
  const [ maskedValue, setMaskedValue ] = useState<string>()

  useEffectAsync(async () => {
    const initialValue = value ?? defaultValue
    if (!initialValue) return
    if (primaryFormat) {
      const masked = await mask(primaryFormat, initialValue, false)
      setMaskedValue(masked)
    } else {
      setMaskedValue(initialValue)
    }
  }, [])

  useEffectAsync(async () => {
    if (value === maskedValue) return
    if (primaryFormat && value) {
      const masked = await mask(primaryFormat, value, false)
      setMaskedValue(masked)
    } else {
      setMaskedValue(value)
    }
  }, [value])

  useEffect(() => {
    const nodeId = findNodeHandle(input.current)
    if (primaryFormat && nodeId) {
      setMask(nodeId, primaryFormat, { affineFormats, affinityCalculationStrategy, customNotations, autocomplete, autoskip, rightToLeft })
    }
  }, [primaryFormat])

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
          multiline={primaryFormat && Platform.OS === 'ios' ? false : multiline}
          onChangeText={async (masked) => {
            setMaskedValue(masked)
            if (primaryFormat) {
              const unmasked = await unmask(primaryFormat, masked, true)
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
  setMask: (reactNode: number, primaryFormat: string, options?: MaskOptions) => void
}

interface MaskOptions {
  affineFormats?: string[]
  customNotations?: Notation[]
  affinityCalculationStrategy?: AffinityCalculationStrategy
  /**
   * autocomplete pattern while editing text
   */
  autocomplete?: boolean
  /**
   * automatically remove mask characters on backspace
   */
  autoskip?: boolean
  rightToLeft?: boolean
}

type AffinityCalculationStrategy =
/**
 * Default strategy.
 *
 * Uses ```Mask``` built-in mechanism to calculate total affinity between the text and the mask format.
 *
 * For example:
 * ```
 * format: [00].[00]
 *
 * input1: 1234
 * input2: 12.34
 * input3: 1.234
 *
 * affinity1 = 4 (symbols) - 1 (missed dot)                       = 3
 * affinity2 = 5 (symbols)                                        = 5
 * affinity3 = 5 (symbols) - 1 (superfluous dot) - 1 (missed dot) = 3
 * ```
 */
    'WHOLE_STRING' |

/**
 * Finds the longest common prefix between the original text and the same text after applying the mask.
 *
 * For example:
 * ```
 * format1: +7 [000] [000]
 * format2: 8 [000] [000]
 *
 * input: +7 12 345
 * affinity1 = 5
 * affinity2 = 0
 *
 * input: 8 12 345
 * affinity1 = 0
 * affinity2 = 4
 * ```
 */
'PREFIX' |

    /**
     * Affinity is tolerance between the length of the input and the total amount of text current mask can accommodate.
     *
     * If current mask can't accommodate all the text, the affinity equals `Int.min`.
     *
     * For example:
     * ```
     * format1: [00]-[0]
     * format2: [00]-[000]
     * format3: [00]-[00000]
     *
     * input          affinity1          affinity2    affinity3
     * 1              -3                 -5           -7
     * 12             -2                 -4           -6
     * 123            -1                 -3           -5
     * 12-3           0                  -2           -4
     * 1234           0                  -2           -4
     * 12345          Int.MIN_VALUE      -1           -3
     * 123456         Int.MIN_VALUE      0            -2
     * ```
     *
     * This affinity calculation strategy comes in handy when the mask format radically changes depending on the input
     * length.
     *
     * N.B.: Make sure the widest mask format is the primary mask format.
     */
    'CAPACITY' |

    /**
     * Affinity is tolerance between the length of the extracted value and the total extracted value length current mask can accommodate.
     *
     * If current mask can't accommodate all the text, the affinity equals `Int.min`.
     *
     * For example:
     * ```
     * format1: [00]-[0]
     * format2: [00]-[000]
     * format3: [00]-[00000]
     *
     * input          affinity1          affinity2          affinity3
     * 1              -2                 -4                 -6
     * 12             -1                 -3                 -5
     * 123            0                  -2                 -4
     * 12-3           0                  -2                 -4
     * 1234           Int.MIN_VALUE      -1                 -3
     * 12345          Int.MIN_VALUE      0                  -2
     * 123456         Int.MIN_VALUE      Int.MIN_VALUE      -1
     * ```
     *
     * This affinity calculation strategy comes in handy when the mask format radically changes depending on the value
     * length.
     *
     * N.B.: Make sure the widest mask format is the primary mask format.
     */
    'EXTRACTED_VALUE_CAPACITY'

interface Notation {
  /**
   * A symbol in format string.
   */
  character: string,
  /**
   * An associated character set of acceptable input characters.
   */
  characterSet: string,
  /**
   * Is it an optional symbol or mandatory?
   */
  isOptional: boolean
}

export interface TextInputMaskProps extends TextInputProps, MaskOptions{
  mask?: string
  onChangeText?: (formatted: string, extracted?: string) => void
}

interface Handles {
  focus: () => void
  blur: () => void
}

export default TextInputMask
