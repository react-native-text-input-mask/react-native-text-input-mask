#
# Be sure to run `pod lib lint rn-text-ios.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'react-native-text-input-mask'
  s.version          = '0.8.0'
  s.summary          = 'react community react-native-text-input-mask iOS库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/eaffy/react-native-text-input-mask'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'react-native-community' => 'yifei239@126.com' }
  s.source           = { :git => 'https://github.com/eaffy/react-native-text-input-mask.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ios/RNTextInputMask/RNTextInputMask/*{h, m}'
  
  # s.resource_bundles = {
  #   'rn-text-ios' => ['rn-text-ios/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'React'
  s.dependency 'InputMaskIOS'
end
