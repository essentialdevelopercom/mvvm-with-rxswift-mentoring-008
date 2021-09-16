
platform :ios, '12.0'
use_frameworks!

target 'MVVMWithRxSwift' do
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'RxDataSources', '~> 4'

    target 'MVVMWithRxSwiftTests' do
    	inherit! :search_paths
  	end
end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
		end
	end
end
