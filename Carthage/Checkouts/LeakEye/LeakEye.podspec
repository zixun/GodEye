#
# Be sure to run `pod lib lint LeakEye.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LeakEye'
  s.version          = '1.1.1'
  s.summary          = 'LeakEye is a memory leak monitor write by swift inspired by PLeakSniffer.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
LeakEye is a memory leak monitor write by swift inspired by PLeakSniffer..
                       DESC

  s.homepage         = 'https://github.com/zixun/LeakEye'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zixun' => 'chenyl.exe@gmail.com' }
  s.source           = { :git => 'https://github.com/zixun/LeakEye.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/zixun_'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LeakEye/Classes/**/*'
  s.dependency 'AppSwizzle', '~> 1.1.1'
end
