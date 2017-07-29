import React, { Component } from 'react'

import {
  TextInput,
  findNodeHandle,
  NativeModules
} from 'react-native'

export default class TextInputMask extends Component {
  masked = false

  onLayout = () => {
    if (this.props.mask && !this.masked) {
      this.masked = true
      NativeModules.RNTextInputMask.setMask(findNodeHandle(this.input), this.props.mask)
    }

    this.props.onLayout && this.props.onLayout()
  }

  render() {
    return (<TextInput
      ref={ref => (this.input = ref)}
      onLayout={this.onLayout}
      {...this.props}
    />);
  }
}
