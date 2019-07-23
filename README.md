# KPUtilsModule

[![CI Status](https://img.shields.io/travis/wuchengmiao/KPUtilsModule.svg?style=flat)](https://travis-ci.org/wuchengmiao/KPUtilsModule)
[![Version](https://img.shields.io/cocoapods/v/KPUtilsModule.svg?style=flat)](https://cocoapods.org/pods/KPUtilsModule)
[![License](https://img.shields.io/cocoapods/l/KPUtilsModule.svg?style=flat)](https://cocoapods.org/pods/KPUtilsModule)
[![Platform](https://img.shields.io/cocoapods/p/KPUtilsModule.svg?style=flat)](https://cocoapods.org/pods/KPUtilsModule)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

KPUtilsModule is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KPUtilsModule'
```

## 工具拓展组件目录：

```
|-KPUtilsModule
  |-AlterTool                           -弹框工具类
  |  |-AlterTool.h
  |  |-AlterTool.m
  |-Categorys                        -拓展分类
  |  |-NSArray+JsonSting.h              - 数组转json字符串类
  |  |-NSArray+JsonSting.m
  |  |-NSDate+Extension.h               -时间拓展处理类
  |  |-NSDate+Extension.m
  |  |-NSObject+HuSwizzling.h           -运行时替换类
  |  |-NSObject+HuSwizzling.m
  |  |-NSString+GetUrlParams.h          -捕获URL中参数类
  |  |-NSString+GetUrlParams.m
  |  |-NSString+JFCategory.h            -获取文件信息类
  |  |-NSString+JFCategory.m
  |  |-NSString+MoneyFormat.h           -金额格式化类
  |  |-NSString+MoneyFormat.m
  |  |-NSString+ParEmoji.h              -字符串表情过滤类
  |  |-NSString+ParEmoji.m
  |  |-NSString+STRegex.h               -各种信息验证类
  |  |-NSString+STRegex.m
  |  |-NSString+Size.h                  -获取字符串各种信息类
  |  |-NSString+Size.m
  |  |-NSString+URL.h                   -URL编码处理类
  |  |-NSString+URL.m
  |  |-UIButton+BZ.h                    -UIButton防重点击类
  |  |-UIButton+BZ.m
  |  |-UIColor+Extensions.h             -颜色处理类
  |  |-UIColor+Extensions.m
  |  |-UIFont+Extension.h               -字体适配类
  |  |-UIFont+Extension.m
  |  |-UIImage+Color.h                  -颜色转图片类
  |  |-UIImage+Color.m
  |  |-UIImage+Image.h                  -图片处理类
  |  |-UIImage+Image.m
  |  |-UITextField+Extension.h          -UITextField处理类
  |  |-UITextField+Extension.m
  |-Deviceinfo                          - 设备信息获取
  |  |-GetDeviceInfoTool.h
  |  |-GetDeviceInfoTool.m
  |-GetCurrentVC                        -获取当前控制器
  |  |-GetCurrentViewController.h
  |  |-GetCurrentViewController.m
  |-KeychainIDeviceNum                  -keychain存储设备唯一标识
  |  |-KeychainHelper.h
  |  |-KeychainHelper.m
  |  |-KeychainIDFA.h
  |  |-KeychainIDFA.m
  |-ProgressHUDManagerTool              -HUD类处理管理
  |  |-ProgressHUDManager.h
  |  |-ProgressHUDManager.m
  |-ReplaceMe.m
  |-TextLimitTool                       - text处理类
  |  |-SDTextLimitTool.h
  |  |-SDTextLimitTool.m
  |-TimeTool                            - 时间工具类
  |  |-TimeFormatTool.h
  |  |-TimeFormatTool.m
  |-UserDefaultsTool                    - 简单存储工具类
  |  |-UserDefaultsTools.h
  |  |-UserDefaultsTools.m
  
  
```



## Author

wuchengmiao, 545250875@qq.com

## License

KPUtilsModule is available under the MIT license. See the LICENSE file for more info.
