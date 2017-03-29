#
# Be sure to run `pod lib lint AppBaseKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AppBaseKit'
  s.version          = '0.2.1'
  s.summary          = 'A handy kit of Swift extensions and wrapped class to boost your productivity.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A handy kit of Swift extensions and wrapped class to boost your productivity.
                       DESC

  s.homepage         = 'https://github.com/zixun/AppBaseKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '陈奕龙' => 'chenyl.exe@gmail.com' }
  s.source           = { :git => 'https://github.com/zixun/AppBaseKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/zixun_'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AppBaseKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AppBaseKit' => ['AppBaseKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
