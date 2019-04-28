//
//  GetDeviceInfoTool.h
//  MMJF
//
//  Created by admin on 2018/1/8.
//  Copyright © 2018年 MG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetDeviceInfoTool : UIViewController
//获取设备信息
+(NSDictionary *)getDeviceInfoAction;
//获取IP地址
+ (NSString *)getIpAddresses;

+(NSString *)getUserAgent;

+(NSString *)getResolution;


@end
