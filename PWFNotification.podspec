#
# Be sure to run `pod lib lint PWFNotification.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PWFNotification'
  s.version          = '0.1.0'
  s.summary          = "You no need to remove observer for using PWFNotification."

  s.description      = <<-DESC
    Because of the crash in using of Apple's NSNotification without removing the observer in dealloc,I develop the PWFNotification.You no need to remove observer for using PWFNotification.You can decide whether to post a notification in the main thread or in current thread,default in current thread.When received memory warning, the invalid observers and the notifications that saved in the notification center will be elimated.
                       DESC

  s.homepage         = 'https://github.com/pwf2006/PWFNotification'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'pwf2006' => '674423263@qq.com' }
  s.source           = { :git => 'https://github.com/pwf2006/PWFNotification.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PWFNotification/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PWFNotification' => ['PWFNotification/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
