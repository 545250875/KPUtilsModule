//
//  NSObject+HuSwizzling.h
//  317hu
//
//  Created by mac on 2018/4/18.
//  Copyright © 2018年 伯仲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HuSwizzling)

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector
                         bySwizzledSelector:(SEL)swizzledSelector;
@end

