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
export { mask, unmask, setMask }

export default class TextInputMask extends Component {
  static defaultProps = {
    maskDefaultValue: true,
  }

  masked = false
  precision = 0

  constructor(props) {
    super(props);
    this.state = {
      value: this.props.value
    };
  }

  componentDidMount() {
    this.precision = this.props.precision;
    if (this.props.maskDefaultValue &&
        this.props.mask &&
        this.props.value) {
      mask(this.props.mask, '' + this.props.value, this.precision, text => {
        this.input && this.input.setNativeProps({ text }),
        this.setState({ value: text });
      })
    }

    if (this.props.mask && !this.masked) {
      this.masked = true
      setMask(findNodeHandle(this.input), this.props.mask, this.precision)
    }
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.precision !== undefined && this.precision !== nextProps.precision ) {
      this.precision = nextProps.precision;
      setMask(findNodeHandle(this.input), nextProps.mask, this.precision)
    }

    if (nextProps.mask && (this.props.value !== nextProps.value)) {
      mask(this.props.mask, '' + nextProps.value, this.precision, text => {
        this.input && this.input.setNativeProps({ text })
        this.setState({ value: text });
      });
    }
  }

  render() {
    const props = Object.assign({}, this.props, { value: this.state.value });
    return (<TextInput
      {...props}
      ref={ref => {
        this.input = ref
        if (typeof this.props.refInput === 'function') {
          this.props.refInput(ref)
        }
      }}
      multiline={this.props.mask && Platform.OS === 'ios' ? false : this.props.multiline}
      onChangeText={masked => {
        if (this.props.mask) {
          const unmasked = masked.replace(/,/g, '');
          this.props.onChangeText && this.props.onChangeText(masked, unmasked)
        } else {
          this.props.onChangeText && this.props.onChangeText(masked)
        }
      }}
    />);
  }
}
