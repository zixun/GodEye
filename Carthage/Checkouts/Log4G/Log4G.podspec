#
# Be sure to run `pod lib lint Log4G.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Log4G'
  s.version          = '0.2.2'
  s.summary          = 'Simple, lightweight logging framework written in Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Simple, lightweight logging framework written in Swift.4G means for GodEye, it was development for GodEye at the beginning of the time.
                       DESC

  s.homepage         = 'https://github.com/zixun/Log4G'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zixun' => 'chenyl.exe@gmail.com' }
  s.source           = { :git => 'https://github.com/zixun/Log4G.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/zixun_'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Log4G/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Log4G' => ['Log4G/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
