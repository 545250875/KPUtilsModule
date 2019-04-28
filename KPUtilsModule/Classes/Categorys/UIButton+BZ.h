//
//  UIButton+BZ.h
//  317hu
//
//  Created by mac on 2017/6/28.
//  Copyright © 2017年 伯仲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BZ)

@property (nonatomic, strong) NSIndexPath *indexPath;

@end



/**
 防止按钮重复暴力点击
 */
@interface UIButton (HuSwizzling)
//点击间隔
@property (nonatomic, assign) NSTimeInterval timeInterval;
//用于设置单个按钮不需要被hook (设为yes说明可以重复点击)
@property (nonatomic, assign) BOOL isIgnore;
@end

