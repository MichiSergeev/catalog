# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'focusStart' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for focusStart
  pod 'RealmSwift'

  
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.0' or '5.0'
      end
    end
  end
  
  
end
