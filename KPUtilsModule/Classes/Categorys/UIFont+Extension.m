//
//  UIFont+Extension.m
//  317hu
//
//  Created by huanghaipo on 2016/10/10.
//  Copyright © 2016年 伯仲. All rights reserved.
//

#define HHBWIDTH [UIScreen mainScreen].bounds.size.width
#define HHBHEIGHT [UIScreen mainScreen].bounds.size.height

#import "UIFont+Extension.h"

@implementation UIFont (Extension)

+ (UIFont *)customFontSize:(CGFloat)fontSize{
    
    UIFont * font;
    
    if (HHBHEIGHT == 480) //4s 4
    {
        font=[UIFont systemFontOfSize:fontSize];
    }
    else if (HHBHEIGHT == 568)//5s  5
    {
        font=[UIFont systemFontOfSize:fontSize];
    }
    else if (HHBHEIGHT==667) //6
    {
        font=[UIFont systemFontOfSize:fontSize + 1];
    }
    else if (HHBHEIGHT==736) //6p
    {
        font=[UIFont systemFontOfSize:fontSize + 2];
    }
    else
    {
        font=[UIFont systemFontOfSize:fontSize];
    }
    
    return font;
}

+ (UIFont *)customFontWithName:(NSString *)fontStyle size:(CGFloat)fontSize{
    UIFont * font;
    int size = 0;
    if (HHBHEIGHT == 568){ //5s
        size = fontSize;
        font = [UIFont fontWithName:fontStyle size:fontSize];
    }
    else if(HHBHEIGHT == 480){ //4
        size = fontSize;
        font = [UIFont fontWithName:fontStyle size:size];
    }
    else if (HHBHEIGHT==667){ //6
        size = fontSize + 1;
        font = [UIFont fontWithName:fontStyle size:size];
    }
    else if (HHBHEIGHT==736){  //6p
        size = fontSize + 2;
        font =[UIFont fontWithName:fontStyle size:size];
    }
    else{//适配iphoneX
        size = fontSize +1;
        font =[UIFont fontWithName:fontStyle size:size];
    }
    if (font == nil) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

@end
