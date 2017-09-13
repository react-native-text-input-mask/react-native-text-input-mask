import React, { Component } from 'react'

import {
  TextInput,
  findNodeHandle,
  NativeModules
} from 'react-native'

const mask = NativeModules.RNTextInputMask.mask
const unmask = NativeModules.RNTextInputMask.unmask
export { mask, unmask }

export default class TextInputMask extends Component {
  static defaultProps = {
    maskDefaultValue: true,
  }

  masked = false

  componentDidMount() {
    if (this.props.maskDefaultValue &&
        this.props.mask &&
        this.props.value) {
      mask(this.props.mask, '' + this.props.value, text =>
        this.input.setNativeProps({ text }),
      )
    }

    if (this.props.mask && !this.masked) {
      this.masked = true
      NativeModules.RNTextInputMask.setMask(findNodeHandle(this.input), this.props.mask)
    }
  }

  render() {
    return (<TextInput
      {...this.props}
      ref={ref => {
        this.input = ref
        if (typeof this.props.refInput === 'function') {
          this.props.refInput(ref)
        }
      }}
      onChangeText={masked => {
        const _unmasked = unmask(this.props.mask, masked, unmasked => {
          this.props.onChangeText && this.props.onChangeText(masked, unmasked)
        })
      }}
    />);
  }
}
