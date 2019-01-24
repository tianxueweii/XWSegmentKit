#
# Be sure to run `pod lib lint XWSegmentKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XWSegmentKit'
  s.version          = '0.0.1'
  s.summary          = '分段导航控制器'

  s.description      = <<-DESC
    分段导航组件库：XWSegmentKit.
    最低兼容iOS8版本
                       DESC

  s.homepage         = 'https://github.com/tianxueweii/XWSegmentKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tianxueweii' => '382447269@qq.com' }
  s.source           = { :git => 'https://github.com/tianxueweii/XWSegmentKit.git', :tag => s.version }
  
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'XWSegmentKit/Classes/**/*'
 
end
