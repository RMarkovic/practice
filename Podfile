# Uncomment this line to define a global platform for your project
platform :ios, '10.1'
# Uncomment this line if you're using Swift
use_frameworks!

target ‘practice’ do
    
    pod 'AFNetworking', '3.1.0'
    pod 'Gloss', '1.1.0'
    
end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
