#
# Be sure to run `pod lib lint RNTextInputMask.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'RNTextInputMask'
    s.version          = '2.0.0'
    s.summary          = 'react community react-native-text-input-mask iOS库'
  
    s.description      = <<-DESC
    Text input mask for React Native, Android and iOS
                         DESC
  
    s.homepage         = 'https://github.com/react-native-community/react-native-text-input-mask'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'react-native-community' => 'react-native-text-input-mask' }
    s.source           = { :git => 'https://github.com/react-native-community/react-native-text-input-mask.git', :tag => s.version.to_s }
  
    s.ios.deployment_target = '8.0'
  
    s.source_files  = "ios/**/*.{h,m}"
    s.dependency 'React'
    s.dependency 'RNInputMask'
  end