Pod::Spec.new do |s|
s.name             = "SwViewCapture"
s.version          = "1.0.6"
s.summary          = "A nice iOS View Capture Library which can capture all content."

s.description      = <<-DESC
					A nice iOS View Capture Library. SwViewCapture could capture all content of UIWebView & UIScrollView.
                     DESC

s.homepage         = "https://github.com/startry/SwViewCapture"
s.license          = 'MIT'
s.author           = { "chenxing.cx" => "chenxingfl@gmail.com" }
s.source           = { :git => "https://github.com/startry/SwViewCapture.git", :tag => "1.0.5" }
s.social_media_url = 'https://twitter.com/xStartry'

s.platform     = :ios, '8.0'
s.requires_arc = true

s.source_files  = ["SwViewCapture/*.swift", "SwViewCapture/SwViewCapture.h"]
s.public_header_files = ["SwViewCapture/SwViewCapture.h"]

end
