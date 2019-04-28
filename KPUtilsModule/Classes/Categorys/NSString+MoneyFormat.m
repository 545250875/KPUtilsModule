//
//  NSString+MoneyFormat.m
//  MMJF
//
//  Created by admin on 2018/2/1.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "NSString+MoneyFormat.h"

@implementation NSString (MoneyFormat)



/**
 *  formatterNumber .00 小数点后两位
 *  @param number number description
 *  @return return value description
 */
+ (NSString *)mamiFormatterNumber:(NSNumber *)number{
    
    return [self y_formatterNumber:number fractionDigits:2];
}

+ (NSString *)y_formatterNumber:(NSNumber *)number fractionDigits:(NSUInteger)fractionDigits{
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,###,##0.00;"];//保留两位小数
    [numberFormatter setMaximumFractionDigits:fractionDigits];
    [numberFormatter setMinimumFractionDigits:fractionDigits];
    
    NSString *formatStr = [numberFormatter stringFromNumber:number];
    
    if (formatStr == nil || [formatStr isKindOfClass:[NSNull class]]) {
        formatStr = @"0.00";
    }
    return formatStr;
}





/**
 *  formatterNumber .00 小数点后两位 : 没加千分号
 *  @param number number description
 *  @return return value description
 */
+ (NSString *)mamiFormatterForCommaNumber:(NSNumber *)number{
    
    return [self formatterNumber:number fractionDigits:2];
}

+ (NSString *)formatterNumber:(NSNumber *)number fractionDigits:(NSUInteger)fractionDigits{
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setMaximumFractionDigits:fractionDigits];
    [numberFormatter setMinimumFractionDigits:fractionDigits];
    NSString *formatStr = [numberFormatter stringFromNumber:number];
    if (formatStr == nil || [formatStr isKindOfClass:[NSNull class]]) {
        formatStr = @"";
    }
    return formatStr;
}






@end
