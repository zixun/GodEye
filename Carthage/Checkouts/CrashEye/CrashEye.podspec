#
# Be sure to run `pod lib lint CrashEye.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CrashEye'
  s.version          = '1.1.2'
  s.summary          = 'CrashEye is an ios crash monitor，automatic catch exception crash & signal crash and return the stacktrace.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
CrashEye is an ios crash monitor，automatic catch exception crash & signal crash and return the crash stacktrace.
                       DESC

  s.homepage         = 'https://github.com/zixun/CrashEye'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zixun' => 'chenyl.exe@gmail.com' }
  s.source           = { :git => 'https://github.com/zixun/CrashEye.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/zixun_'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CrashEye/Classes/**/*'
end
