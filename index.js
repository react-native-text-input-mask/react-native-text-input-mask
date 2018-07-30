import React, { Component } from 'react'

import {
  TextInput,
  findNodeHandle,
  NativeModules,
  Platform
} from 'react-native'

const mask = NativeModules.RNTextInputMask.mask
const unmask = NativeModules.RNTextInputMask.unmask
const setMask = NativeModules.RNTextInputMask.setMask
const setText = NativeModules.RNTextInputMask.setText
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
        this.updateText(text)
      )
    }
    if (this.props.mask && !this.masked) {
      this.masked = true
      setMask(findNodeHandle(this.input), this.props.mask)
    }
  }

  componentWillReceiveProps(nextProps) {
    if (this.props.value !== nextProps.value) {
      mask(this.props.mask, '' + nextProps.value, masked => {
        const result = nextProps.value === '' ? '' : masked
        this.updateText(result)
        this.onChangeText(result)
      })
    }
    if (this.props.mask !== nextProps.mask) {
      unmask(this.props.mask, this.props.value, unmasked => {
        mask(nextProps.mask, unmasked, result => {
          setMask(findNodeHandle(this.input), nextProps.mask)
          this.updateText(result)
          this.onChangeText(result)
        })
      })
    }
  }

  updateText(text) {
    if (this.input === null) {
      return
    }
    if (Platform.OS === 'ios') {
      setText(findNodeHandle(this.input), text)
    }
    else {
      this.input.setNativeProps({ text })
    }
  }

  onChangeText = (text) => {
    unmask(this.props.mask, text, unmasked => {
      this.props.onChangeText && this.props.onChangeText(text, unmasked)
    })
  };

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
      onChangeText={text => this.onChangeText(text)}
    />);
  }
}