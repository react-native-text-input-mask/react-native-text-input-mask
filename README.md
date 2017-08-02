# react-native-text-input-mask
Text input mask for React Native on iOS and Android.

![React Native Text Input Mask Android](https://s3.amazonaws.com/react-native-text-input-mask/react-native-text-input-mask-android.gif)

![React Native Text Input Mask iOS](https://s3.amazonaws.com/react-native-text-input-mask/input-mask-ios.gif)

## Setup

```bash
npm install --save react-native-text-input-mask
react-native link react-native-text-input-mask
```

## Usage

```javascript
import TextInputMask from 'react-native-text-input-mask';
...
<TextInputMask mask={"+1 ([000]) [000] [00] [00]"} />
...
```

## Versioning

This project uses semantic versioning: MAJOR.MINOR.PATCH.
This means that releases within the same MAJOR version are always backwards compatible. For more info see [semver.org](http://semver.org/).