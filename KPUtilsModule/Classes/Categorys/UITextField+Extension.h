//
//  UITextField+Extension.h
//  Sumi
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 MG. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UITextField (Extension)

- (NSRange)selectedRange;


//电话号码格输入框式化
- (BOOL)mamiTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;



- (void)setSelectedRange:(NSRange)range;

/**
 *  设置空格插入的位置 使用方式
 *  - textField:shouldChangeCharactersInRange:replacementString:
 *  执行如下代码
 *  NSArray *insertPosition = @[@(6), @(10), @(14), @(18)];
 *  [textField insertWhitSpaceInsertPosition:insertPosition replacementString:string textlength:20];
 *  return NO;
 *
 *  @param insertPosition 插入的位置
 *  @param string         插入的字符串
 *  @param length         文本长度
 */
- (void)insertWhitSpaceInsertPosition:(NSArray *)insertPosition replacementString:(NSString *)string textlength:(NSInteger)length;




/**
 金额数据框限制
 @param string string description
 @param textField textField description
 @param range range description
 @return return value description
 */
-(BOOL)limitTextFiledInput:(NSString *)string textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range;


@end
