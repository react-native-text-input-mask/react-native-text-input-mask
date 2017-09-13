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
<TextInputMask mask={"+1 ([000]) [000] [00] [00]"} />
...
```

In the following example, the masked value will be returned when `onChangeText` is fired:

```
<TextInputMask
    mask={"+1 ([000]) [000] [00] [00]"}
    onChangeText={(value) => { console.log(value); }
/>
// will log `+1 (000) 000 00 00` to the console
```

If you would like the un-masked value to be returned, you should set the `returnUnmasked`
prop to `true` as in the following example:

 ```
<TextInputMask
    returnUnmasked
    mask={"+1 ([000]) [000] [00] [00]"}
    onChangeText={(value) => { console.log(value); }
/>
// will log `0000000000` to the console
```

## More info

[RedMadRobot Input Mask Android](https://github.com/RedMadRobot/input-mask-android)

[RedMadRobot Input Mask IOS](https://github.com/RedMadRobot/input-mask-ios)

## Versioning

This project uses semantic versioning: MAJOR.MINOR.PATCH.
This means that releases within the same MAJOR version are always backwards compatible. For more info see [semver.org](http://semver.org/).
