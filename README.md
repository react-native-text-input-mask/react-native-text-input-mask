# react-native-text-input-mask
Text input mask for React Native on iOS and Android.

## Examples

![React Native Text Input Mask iOS](https://s3.amazonaws.com/react-native-text-input-mask/react-native-text-input-mask-ios.gif)
![React Native Text Input Mask Android](https://s3.amazonaws.com/react-native-text-input-mask/react-native-text-input-mask-android-updated.gif)

## Setup

```bash
npm install --save react-native-text-input-mask
react-native link react-native-text-input-mask
```

For RN 0.47 use 0.3.2 version – `npm install --save react-native-text-input-mask@0.3.2`

## Usage

```javascript
import TextInputMask from 'react-native-text-input-mask';
...
<TextInputMask
  refInput={ref => { this.input = ref }}
  onChangeText={(formatted, extracted) => {
    console.log(formatted) // +1 (123) 456-78-90
    console.log(extracted) // 1234567890
  }}
  mask={"+1 ([000]) [000] [00] [00]"}
/>
...
```

## More info

[RedMadRobot Input Mask Android](https://github.com/RedMadRobot/input-mask-android)

[RedMadRobot Input Mask IOS](https://github.com/RedMadRobot/input-mask-ios)

## Versioning

This project uses semantic versioning: MAJOR.MINOR.PATCH.
This means that releases within the same MAJOR version are always backwards compatible. For more info see [semver.org](http://semver.org/).
