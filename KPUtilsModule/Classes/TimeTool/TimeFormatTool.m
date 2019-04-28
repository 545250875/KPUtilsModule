//
//  TimeFormatTool.m
//  MMJF
//
//  Created by admin on 2018/3/8.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "TimeFormatTool.h"

@implementation TimeFormatTool


//获取当前时间戳  （以毫秒为单位）
+(NSString *)getNowTimeTimestampSinceNow{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970] *1000;
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
    
}




//获取当前时间戳  （以毫秒为单位）
+(NSString *)getNowDateStr{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    return DateTime;
}




/**
 时间戳字符串装换称日期
 */
+(NSString *)timeWithTimeIntervalString:(NSString *)timeString formatStr:(NSString *)formatStr{
    if (timeString == nil) {
        return @"";
    }
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatStr];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

//服务器头部时间转为GMT时间
//Mon, 28 Aug 2017 06:09:40 GMT
//本地日期格式:2013-08-03 12:53:51
//可自行指定输入输出格式
+(NSString *)getUTCFormateLocalDate:(NSString *)currentDateStr
{
    NSLog(@"------>>>这是什么鬼哇：  %@",[self getUTCFormateLocalDate:@"Mon, 28 Aug 2017 06:09:40 GMT"]);
    
    // ---------------------------本地时间转为GMT时间-------------------------------------------------
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter  setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter  setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en"]];
    [dateFormatter  setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss 'GMT'"];
    //    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"GMT : %@",currentDateStr);
    
    //-------------------------------GMT时间转为本地时间------------------------------------------------
    
    //NSDate *localeDate = [dateFormatter dateFromString:currentDateStr];
    NSDate *datenow =[NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];
    [dateFormatter  setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * localeTimeStr =[dateFormatter stringFromDate:localeDate];
    NSLog(@"Locale : %@", localeTimeStr);
    
    
    
    return currentDateStr;
}


/**
 获取当前日期的前N天日期（n为负数表示往前）
 */
+(NSString *)getNowdayforeDayWithDis:(double)disDay{
    NSDate*nowDate = [NSDate date];
    NSDate* theDate;
    if(disDay!=0){
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        theDate = [nowDate initWithTimeIntervalSinceNow: oneDay*disDay ];//initWithTimeIntervalSinceNow是从现在往前后推的秒数
    }else{
        theDate = nowDate;
    }
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *the_date_str = [date_formatter stringFromDate:theDate];
    return the_date_str;
    
}




@end
