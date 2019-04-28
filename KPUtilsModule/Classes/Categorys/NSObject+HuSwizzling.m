//
//  NSObject+HuSwizzling.m
//  317hu
//
//  Created by mac on 2018/4/18.
//  Copyright © 2018年 伯仲. All rights reserved.
//

#import "NSObject+HuSwizzling.h"
#import <objc/runtime.h>
@implementation NSObject (HuSwizzling)

/*
 问：为什么要添加didAddMethod判断？
 答：先尝试添加原SEL其实是为了做一层保护，因为如果这个类没有实现originalSelector，但其父类实现了，那class_getInstanceMethod会返回父类的方法。这样method_exchangeImplementations替换的是父类的那个方法，这当然不是我们想要的。所以我们先尝试添加 orginalSelector，如果已经存在，再用 method_exchangeImplementations 把原方法的实现跟新的方法实现给交换掉
 */

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector {
    Class class = [self class];
    //原有方法
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    //替换原有方法的新方法
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    //先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
    BOOL didAddMethod = class_addMethod(class, originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) { //添加成功：说明源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP
        class_replaceMethod(class, swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else { //添加失败：说明源SEL已经有IMP，直接将两个SEL的IMP交换即可
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end

