# react-native-text-input-mask
Text input mask for React Native on iOS and Android.

<a href="https://www.npmjs.org/package/react-native-text-input-mask">
  <img src="https://badge.fury.io/js/react-native-text-input-mask.svg" alt="NPM package version." />
</a>
<a href="https://github.com/react-native-community/react-native-text-input-mask/blob/master/LICENSE">
  <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT license." />
</a>

## Examples

![React Native Text Input Mask iOS](https://s3.amazonaws.com/react-native-text-input-mask/react-native-text-input-mask-ios.gif)
![React Native Text Input Mask Android](https://s3.amazonaws.com/react-native-text-input-mask/react-native-text-input-mask-android-updated.gif)

## Setup

```bash
npm install --save react-native-text-input-mask

# --- or ---

yarn add react-native-text-input-mask
```

# Installation

<details>
  <summary><b>For RN >= 0.60</b></summary>

#### iOS
1. Configure pods (static or dynamic linking)
<details>
  <summary>Static Library ( Podfile has no use_frameworks! ) </summary>
Add following lines to your target in `Podfile`. Linking is not required in React Native 0.60 and above.

```ruby
pod 'React-RCTText', :path => '../node_modules/react-native/Libraries/Text', :modular_headers => true
```
</details>
<details>
  <summary>Dynamic Framework ( Podfile has use_frameworks! ) </summary>
Add following lines to your target in `Podfile` if it doesnt exist. Linking is not required in React Native 0.60 and above.

```
use_frameworks!
```
</details>

2. Run `pod install` in the `ios` directory.

#### Android

No need to do anything.

</details>

<details><summary><b>For RN < 0.60</b></summary>

### WARNING! This is no longer officially supported, these instructions are out of date and may no longer work, we recommend upgrading to a newer version of React Native.

### Link
```bash
react-native link react-native-text-input-mask
```

**iOS only:** you have to drag and drop `InputMask.framework` to `Embedded Binaries` in General tab of Target

![](https://cdn-images-1.medium.com/max/2000/1*J0TPrRhkAKspVvv-JaZHjA.png)

### Manual installation

#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-text-input-mask` and add `RNTextInputMask.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNTextInputMask.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.RNTextInputMask.RNTextInputMaskPackage;` to the imports at the top of the file
  - Add `new RNTextInputMaskPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-text-input-mask'
  	project(':react-native-text-input-mask').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-text-input-mask/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-text-input-mask')
  	```
</details>

## Usage

```javascript
import TextInputMask from 'react-native-text-input-mask';
...
<TextInputMask
  onChangeText={(formatted, extracted) => {
    console.log(formatted) // +1 (123) 456-78-90
    console.log(extracted) // 1234567890
  }}
  mask={"+1 ([000]) [000] [00] [00]"}
/>
...
```

## Testing

### Jest

Make sure to [mock](https://jestjs.io/docs/en/manual-mocks#mocking-node-modules) the following to `jest.setup.js`:
```javascript
jest.mock('react-native-text-input-mask', () => ({
    default: jest.fn(),
}))
```

## More info

[RedMadRobot Input Mask Android](https://github.com/RedMadRobot/input-mask-android)

[RedMadRobot Input Mask IOS](https://github.com/RedMadRobot/input-mask-ios)

## Versioning

This project uses semantic versioning: MAJOR.MINOR.PATCH.
This means that releases within the same MAJOR version are always backwards compatible. For more info see [semver.org](http://semver.org/).

## Local Development and testing
To use a local copy with your project, it's highly recommended to use https://github.com/wix/wml
