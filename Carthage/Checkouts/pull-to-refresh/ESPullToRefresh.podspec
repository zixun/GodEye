
Pod::Spec.new do |s|
    s.name              = 'ESPullToRefresh'
    s.version           = '2.6'
    s.summary           = 'An easy way to use pull-to-refresh and loading-more'
    s.description       = 'An easiest way to give pull-to-refresh and loading-more to any UIScrollView. Using swift!'
    s.homepage          = 'https://github.com/eggswift/pull-to-refresh'

    s.license           = { :type => 'MIT', :file => 'LICENSE' }
    s.authors           = { 'lihao' => 'lihao_ios@hotmail.com'}
    s.social_media_url  = 'https://github.com/eggswift'
    s.platform          = :ios, '8.0'
    s.source            = {:git => 'https://github.com/eggswift/pull-to-refresh.git', :tag => s.version}
    s.source_files      = ['Sources/**/*.{swift}']
    s.resource_bundles  = { 'ESPullToRefresh' => 'Sources/Animator/*.png' }
    s.requires_arc      = true
end
