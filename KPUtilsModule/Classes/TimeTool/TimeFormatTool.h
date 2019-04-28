//
//  TimeFormatTool.h
//  MMJF
//
//  Created by admin on 2018/3/8.
//  Copyright © 2018年 MG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeFormatTool : NSObject

//获取当前时间字符串
+(NSString *)getNowDateStr;


//以当前时间的偏移秒数来初始化
+(NSString *)getNowTimeTimestampSinceNow;


//服务器头部时间转为GMT时间
//Mon, 28 Aug 2017 06:09:40 GMT
//本地日期格式:2013-08-03 12:53:51
//可自行指定输入输出格式
+(NSString *)getUTCFormateLocalDate:(NSString *)currentDateStr;



/**
 时间戳转化成日期
 */
+(NSString *)timeWithTimeIntervalString:(NSString *)timeString formatStr:(NSString *)formatStr;


/**
 获取当前日期的前N天日期（n为负数表示往前）
 */
+(NSString *)getNowdayforeDayWithDis:(double)disDay;


@end
