#
# Be sure to run `pod lib lint GodEye.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GodEye'
  s.version          = '1.2.0'
  s.summary          = 'Automaticly display Log,Crash,Network,ANR,Leak,CPU,RAM,FPS,NetFlow,Folder and etc with one line of code based on Swift. Just like God opened his eyes.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Automaticly display Log,Crash,Network,ANR,Leak,CPU,RAM,FPS,NetFlow,Folder and etc with one line of code based on Swift. Just like God opened his eyes..
                       DESC

  s.homepage         = 'https://github.com/zixun/GodEye'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zixun' => 'chenyl.exe@gmail.com' }
  s.source           = { :git => 'https://github.com/zixun/GodEye.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/zixun_'

  s.ios.deployment_target = '8.0'

  s.source_files = 'GodEye/Classes/**/*'
  
  s.resource_bundles = {
    'GodEye' => ['GodEye/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

  s.subspec 'Log4G' do |subspec|
    subspec.source_files = 'Log4G/Classes/**/*'
    subspec.dependency 'ReactiveCocoa', '>= 1.8.0'
    subspec.dependency 'BrynKit/Main'
    subspec.dependency 'BrynKit/EDColor'
  end

    s.dependency 'AppBaseKit', '~> 1.0.1'
    s.dependency 'AppSwizzle', '~> 1.3.1'
    s.dependency 'AssistiveButton', '~> 1.2.0'

    s.dependency 'ASLEye', '~> 1.2.0'
    s.dependency 'CrashEye', '~> 1.2.0'
    s.dependency 'ANREye', '~> 1.2.0'
    s.dependency 'SystemEye', '~> 0.3.0'
    s.dependency 'NetworkEye.swift', '~> 1.2.0'
    s.dependency 'LeakEye', '~> 1.2.0'

    s.dependency 'FileBrowser', '~> 1.0.0'
    s.dependency 'SwViewCapture', '~> 1.0.6'
    s.dependency 'SQLite.swift', '0.11.4'
    #s.dependency 'MJRefresh', '~> 3.1.12'
    s.dependency 'ESPullToRefresh', '~> 2.7'
end
