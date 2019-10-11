Pod::Spec.new do |spec|
  spec.name             = "RNInputMask"
  spec.version          = "4.1.0"
  spec.summary          = "InputMask"
  spec.description      = "User input masking library."
  spec.homepage         = "https://github.com/RedMadRobot/input-mask-ios"
  spec.license          = "MIT"
  spec.author           = { "Egor Taflanidi" => "et@redmadrobot.com" }
  spec.source           = { :git => "https://github.com/RedMadRobot/input-mask-ios.git", :tag => spec.version.to_s }
  spec.platform         = :ios, "8.0"
  spec.requires_arc     = true
  spec.source_files     = "InputMask/Classes/**/*"
  spec.swift_version    = "5.0"
end
