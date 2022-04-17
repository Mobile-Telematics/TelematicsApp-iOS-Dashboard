source 'https://github.com/CocoaPods/Specs.git'


platform :ios, '12.0'
inhibit_all_warnings!
use_frameworks!

def available_pods
  pod 'RaxelPulse', '5.16' #PRODUCTION
  pod 'AFNetworking'
  pod 'JSONModel'
  pod 'HEREMaps'
  pod 'GKImagePicker@robseward'
  pod 'TTTLocalizedPluralString'
  pod 'SAMKeychain'
  pod 'SystemServices'
  pod 'UICountingLabel'
  pod 'UIActionSheet+Blocks'
  pod 'UIAlertView+Blocks'
  pod 'CMTabbarView'
  pod 'DLRadioButton'
  pod 'YYWebImage'
  pod 'SHSPhoneComponent'
  pod "IQDropDownTextField"
  pod "IQMediaPickerController"
  pod 'libPhoneNumber-iOS', '~> 0.8'
  pod 'KDLoadingView'
  pod "RMessage", '~> 2.3.0'
  pod 'CircleTimer', '0.2.0'
  pod 'MagicalRecord', :git => 'https://github.com/magicalpanda/MagicalRecord'
end


target 'DashboardModule' do
    available_pods
end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
        end
        target.build_configurations.each do |config|
            config.build_settings['CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF'] = 'NO'
        end
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        end
    end
end
