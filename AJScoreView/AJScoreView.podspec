#
# Be sure to run `pod lib lint AJScoreView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AJScoreView'
  s.version          = '1.0.0'
  s.summary          = 'AJScoreView is a custoum view for use score, it can change sharpe with star, heart and other custom path.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    AJScoreView is a custoum view for display evaluation score, it can change sharpe with star, heart and other custom path. It also support many arguments, like color, border, number etc. It support storyboard and edit event.
                       DESC

  s.homepage         = 'https://github.com/aijun198600/AJScoreView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aijunx' => 'aijun198600@126.com' }
  s.source           = { :git => 'https://github.com/aijun198600/AJScoreView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'AJScoreView/AJScoreView/Classes/*.{h,m}'
  
  # s.resource_bundles = {
  #   'AJScoreView' => ['AJScoreView/Assets/*.png']
  # }

  s.public_header_files = 'AJScoreView/AJScoreView/Classes/*.h'
  s.frameworks = 'UIKit'
  s.requires_arc = true
  # s.dependency 'AFNetworking', '~> 2.3'
end
