# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'OnenexCodeTest' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for OnenexCodeTest

 pod 'IQKeyboardManagerSwift'
 pod 'Alamofire'
 pod 'ObjectMapper'
 pod 'RxSwift', '~> 6.6.0'
 pod 'RxCocoa'
 pod 'SwiftyJSON'
 pod 'JGProgressHUD'
 pod 'SwiftKeychainWrapper'
 
 post_install do |installer|
     installer.generated_projects.each do |project|
         project.targets.each do |target|
             target.build_configurations.each do |config|
                 config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
             end
         end
     end
 end

end
