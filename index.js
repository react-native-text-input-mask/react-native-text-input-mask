import React, { Component } from 'react'

import {
  TextInput,
  findNodeHandle,
  NativeModules
} from 'react-native'

const mask = NativeModules.RNTextInputMask.mask
export { mask }

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
      ref={ref => (this.input = ref)}
      {...this.props}
    />);
  }
}
