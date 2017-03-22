#
# Be sure to run `pod lib lint AppSwizzle.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AppSwizzle'
  s.version          = '1.1.1'
  s.summary          = 'lightweight and flexible method swizzling wrapped by swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Lightweight and flexible method swizzling wrapped by swift. enjoy it!
                       DESC

  s.homepage         = 'https://github.com/zixun/AppSwizzle'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '陈奕龙' => 'chenyl.exe@gmail.com' }
  s.source           = { :git => 'https://github.com/zixun/AppSwizzle.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/zixun_'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AppSwizzle/Classes/**/*'
end
