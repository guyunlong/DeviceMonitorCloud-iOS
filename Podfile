# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'FarmMonitor' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!
    pod 'MJRefresh'
    pod 'Masonry'
    pod 'MBProgressHUD'
    pod 'TPKeyboardAvoiding'
    pod 'ReactiveCocoa', '~> 2.3.1'
    pod 'PLPlayerKit'
end
post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
      config.build_settings['VALID_ARCHS'] = 'arm64 i386'
    end
  end
end
