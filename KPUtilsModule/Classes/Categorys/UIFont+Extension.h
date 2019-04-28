//
//  UIFont+Extension.h
//  317hu
//
//  Created by huanghaipo on 2016/10/10.
//  Copyright © 2016年 伯仲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Extension)

/**
  不同屏幕适配字体

 @param fontSize 根据不同的屏幕尺寸的来决定字体的大小

 @return 字体适配
 */
+ (UIFont *)customFontSize:(CGFloat)fontSize;


/**
 带字体样式的字体适配


 @param fontStyle 字体样式
 @param fontSize  字体大小

 @return  带字体样式的字体适配

 */
+ (UIFont *)customFontWithName:(NSString *)fontStyle size:(CGFloat)fontSize;

@end
