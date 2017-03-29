#
# Be sure to run `pod lib lint ASLEye.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ASLEye'
  s.version          = '1.1.1'
  s.summary          = 'ASLEye is an ASL monitor, automatic catch the log from NSLog by asl module.'

  s.description      = <<-DESC
ASLEye is an ASL(Apple System Log) monitor, automatic catch the log from NSLog by asl module.
                       DESC

  s.homepage         = 'https://github.com/zixun/ASLEye'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zixun' => 'chenyl.exe@gmail.com' }
  s.source           = { :git => 'https://github.com/zixun/ASLEye.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/zixun_'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ASLEye/Classes/**/*'

end
