#
# Be sure to run `pod lib lint ANREye.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ANREye'
  s.version          = '1.1.2'
s.summary          = 'Class for monitor excessive blocking on the main thread.'

  s.description      = <<-DESC
Class for monitor excessive blocking on the main thread and return the stacetrace of all threads.
                       DESC

  s.homepage         = 'https://github.com/zixun/ANREye'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zixun' => 'chenyl.exe@gmail.com' }
  s.source           = { :git => 'https://github.com/zixun/ANREye.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/zixun_'

  s.ios.deployment_target = '8.0'
  s.source_files = 'ANREye/Classes/**/*'
end
