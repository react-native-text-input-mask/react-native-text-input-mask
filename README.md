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
For Android it just works.

For iOS you have to drag and drop InputMask framework to Embedded Binaries in General tab of Target and check ‘Yes’ in ‘Always Embed Swift Standard Libraries’ of Build Settings.

![](https://cdn-images-1.medium.com/max/2000/1*J0TPrRhkAKspVvv-JaZHjA.png)
![](https://cdn-images-1.medium.com/max/1600/1*j7VdY3g9_Vz6YTki3T17CQ.png)

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

## Testflight upload error

You might encounter the following error when trying to upload a build to Testflight (see https://github.com/react-native-community/react-native-text-input-mask/issues/22):

```
ERROR ITMS-90206: "Invalid Bundle. The bundle at 'myapp.app/Frameworks/InputMask.framework' contains disallowed file 'Frameworks'."
```

To solve this, two steps are necessary:
  * Disable the "Always Embed Swift Standard Libraries" on bothe the `RNTextInputMask` and its `InputMask` dependecy by:
    * clicking on them in `Libraries > RNTextInputMask` and `Libraries > RNTextInputMask > Libraries > InputMask` xcodeproj
    * Choose the `Build settings` tab
    * `Always Embed Swift Standard Libraries` to `No`

    OR
    * running `sed -i '' -E 's/ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;/ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = NO;/g' ./node_modules/react-native-text-input-mask/ios/RNTextInputMask/RNTextInputMask.xcodeproj/project.pbxproj && sed -i '' -E 's/ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;/ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = NO;/' ./node_modules/react-native-text-input-mask/ios/RNTextInputMask/InputMask/InputMask.xcodeproj/project.pbxproj`

    Everytime you reinstall your `node_modules`. (Or just add the above script to your `postinstall` command)

  * Add a script phase to delete an extra `Frameworks/` folder

```
EXTRA_DIR="${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/Frameworks/InputMask.framework/Frameworks"

if [[ -d "${EXTRA_DIR}" ]]; then
  rm -rf "${EXTRA_DIR}"
fi
```

Make sure that **This script happens at the end of your build flow (after the *Embed Frameworks* script)**

## More info

[RedMadRobot Input Mask Android](https://github.com/RedMadRobot/input-mask-android)

[RedMadRobot Input Mask IOS](https://github.com/RedMadRobot/input-mask-ios)

## Versioning

This project uses semantic versioning: MAJOR.MINOR.PATCH.
This means that releases within the same MAJOR version are always backwards compatible. For more info see [semver.org](http://semver.org/).
