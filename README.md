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

### Manual link
#### Android
```gradle
// file: android/settings.gradle
...

include ':react-native-text-input-mask'
project(':react-native-text-input-mask').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-text-input-mask/android')
```

```gradle
// file: android/app/build.gradle
...

dependencies {
    ...
    implementation project(':react-native-text-input-mask')
}
```

```java
// file: MainApplication.java
...

import com.RNTextInputMask.RNTextInputMaskPackage; // Import package

public class MainApplication extends Application implements ReactApplication {

   /**
   * A list of packages used by the app. If the app uses additional views
   * or modules besides the default ones, add more packages here.
   */
    @Override
    protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
          new MainReactPackage(),
            new RNTextInputMaskPackage() // Add package
      );
    }
...
}
```


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
