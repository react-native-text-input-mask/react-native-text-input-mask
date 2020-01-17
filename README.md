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
  <summary><b>For RN >= 0.61</b></summary>

#### iOS

1. Add following lines to your target in `Podfile`
```
use_frameworks!
pod 'RNInputMask', :path => '../node_modules/react-native-text-input-mask/ios/InputMask'
```
2. Run following command
```bash
cd ios && pod install
```

#### Android

No need to do anything.

</details>

<details>
  <summary><b>For RN = 0.60.*</b></summary>

#### iOS

1. In XCode, in the project navigator, right click your `[your project's name]` folder, choose ➜ `Add Files to [your project's name]`

![Create Swift File](https://i.imgur.com/00K5UZ1.png)

2. Select `Swift File` ➜ `Next`

![Create Swift File](https://i.imgur.com/Mdc9MLk.png)

3. Specify name for example `Dummy.swift` ➜ `Create`

![Create Swift File](https://i.imgur.com/2HSk7Jp.png)

4. Now a pop up is shown select `Create Bridging Header`

![Create Swift File](https://i.imgur.com/f2zA0n9.png)

5. Add following line to your target in `Podfile`
```
pod 'RNInputMask', :path => '../node_modules/react-native-text-input-mask/ios/InputMask'
```
6. Run following command
```bash
cd ios && pod install
```

#### Android

No need to do anything.

</details>

<details><summary><b>For RN < 0.60</b></summary>

### Auto Linking
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
