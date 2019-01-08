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
      // mask(this.props.mask, '' + nextProps.value, this.precision, text => {
        let text = this._formatNumber(nextProps.value, this.precision);
        this.input && this.input.setNativeProps({ text })
        this.setState({ value: text });
      // });
    }
  }

  _formatNumber(value, precision) {
    if (!value) {
      return value;
    }

    if (value.charAt(value.length - 1) === ',') {
      value = value.substring(0, value.length -1) + '.';
    }

    let [natualPart, decimalPart = ''] = value.split('.');

    if (decimalPart.length && precision > 0) {
      decimalPart = decimalPart.substring(0, precision);
    }

    let formated = '';
    while (true) {
      if (natualPart.length > 3) {
        let digits = natualPart.substring(natualPart.length - 3);
        if (formated) {
          formated = digits + ',' + formated;
        } else {
          formated = digits;
        }
        natualPart = natualPart.substring(0, natualPart.length - 3);
      } else {
        if (formated) {
          formated = natualPart + ',' + formated;
        } else {
          formated = natualPart;
        }
        break;
      }
    }

    if (precision > 0 && value.includes('.')) {
      formated += '.';
      formated += decimalPart;
    }

    console.log(value, formated);
    return formated;
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
          if (masked.length && masked.charAt(masked.length - 1) === ',') {
            masked = masked.substring(0, masked.length -1) + '.';
          }
          let unmasked = masked.replace(/,/g, '');
          unmasked = this._formatNumber(unmasked, this.precision);
          unmasked = unmasked.replace(/,/g, '');
          this.props.onChangeText && this.props.onChangeText(masked, unmasked)
        } else {
          this.props.onChangeText && this.props.onChangeText(masked)
        }
      }}
    />);
  }
}
