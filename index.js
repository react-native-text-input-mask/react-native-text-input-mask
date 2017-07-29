import React, { Component } from 'react'

import {
  TextInput,
  findNodeHandle,
  NativeModules
} from 'react-native'

export default class TextInputMask extends Component {
  masked = false

  onChange = () => {
    const { mask } = this.props

    if (mask && !this.masked) {
      this.masked = true
      NativeModules.RNTextInputMask.setMask(findNodeHandle(this.input), mask)
    }
  }

  render() {
    return (<TextInput
      ref={ref => (this.input = ref)}
      onChange={this.onChange}
      {...this.props}
    />);
  }
}
