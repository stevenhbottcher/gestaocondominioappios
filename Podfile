platform :ios, '13.0'
use_modular_headers!

target 'playcondominio' do
  # Comment the next line if you don't want to use dynamic frameworks
  # use_frameworks!
  # Pods for playcondominio
  pod 'Firebase/Core', '~> 10.0'
  pod 'Firebase/Messaging', '~> 10.0'
  target 'playcondominioTests' do
    inherit! :search_paths
    # Pods for testing
  end
  target 'playcondominioUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['GCC_WARN_ABOUT_MISSING_PROTOTYPES'] = 'NO'
      config.build_settings['CLANG_WARN_STRICT_PROTOTYPES'] = 'NO'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end