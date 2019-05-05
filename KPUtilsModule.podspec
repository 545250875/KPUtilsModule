#
# Be sure to run `pod lib lint KPUtilsModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KPUtilsModule'
  s.version          = '1.0.2'
  s.summary          = '项目常用的 工具类 + 分类'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/545250875/KPUtilsModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wuchengmiao' => '545250875@qq.com' }
  s.source           = { :git => 'https://github.com/545250875/KPUtilsModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'


    #s.source_files = 'KPUtilsModule/Classes/**/*'


    s.source_files = 'KPUtilsModule/Classes/*'


    #-----------------文件分级---------------------#

    s.subspec 'AlterTool' do |ss|
    ss.source_files = 'KPUtilsModule/Classes/AlterTool/*'
    end

    s.subspec 'Categorys' do |ss|
    ss.source_files = 'KPUtilsModule/Classes/Categorys/*'
    end

    s.subspec 'Deviceinfo' do |ss|
    ss.source_files = 'KPUtilsModule/Classes/Deviceinfo/*'
    end

    s.subspec 'GetCurrentVC' do |ss|
    ss.source_files = 'KPUtilsModule/Classes/GetCurrentVC/*'
    end

    s.subspec 'KeychainIDeviceNum' do |ss|
    ss.source_files = 'KPUtilsModule/Classes/KeychainIDeviceNum/*'
    end

    s.subspec 'TextLimitTool' do |ss|
    ss.source_files = 'KPUtilsModule/Classes/TextLimitTool/*'
    end

    s.subspec 'TimeTool' do |ss|
    ss.source_files = 'KPUtilsModule/Classes/TimeTool/*'
    end

    s.subspec 'UserDefaultsTool' do |ss|
    ss.source_files = 'KPUtilsModule/Classes/UserDefaultsTool/*'
    end

    s.subspec 'ProgressHUDManagerTool' do |ss|
    ss.source_files = 'KPUtilsModule/Classes/ProgressHUDManagerTool/*'
    end



   s.resource_bundles = {
     'KPUtilsModule' => ['KPUtilsModule/Assets/*.png']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

    s.dependency 'Toast', '~> 4.0.0'
    s.dependency 'SVProgressHUD', '2.0.3'
    s.dependency 'FFToast', '~> 1.2.0'



end
