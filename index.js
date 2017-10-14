import React, { Component } from 'react'

import {
  TextInput,
  findNodeHandle,
  NativeModules
} from 'react-native'

const mask = NativeModules.RNTextInputMask.mask
const unmask = NativeModules.RNTextInputMask.unmask
const setMask = NativeModules.RNTextInputMask.setMask
export { mask, unmask, setMask }

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
      setMask(findNodeHandle(this.input), this.props.mask)
    }
  }

  componentWillReceiveProps(nextProps) {
    if (this.props.value != nextProps.value) {
      mask(this.props.mask, '' + nextProps.value, text =>
        this.input.setNativeProps({ text })
      );
    }
  }

  render() {
    return (<TextInput
      {...this.props}
      value={undefined}
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
