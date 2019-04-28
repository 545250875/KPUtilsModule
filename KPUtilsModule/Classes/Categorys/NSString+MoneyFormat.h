//
//  NSString+MoneyFormat.h
//  MMJF
//
//  Created by admin on 2018/2/1.
//  Copyright © 2018年 MG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MoneyFormat)

/**
 *  formatterNumber .00 小数点后两位
 *  @param number number description
 *  @return return value description
 */
+ (NSString *)mamiFormatterNumber:(NSNumber *)number;


/**
 *  formatterNumber .00 小数点后两位 : 没加千分号
 *  @param number number description
 *  @return return value description
 */
+ (NSString *)mamiFormatterForCommaNumber:(NSNumber *)number;
    
@end
