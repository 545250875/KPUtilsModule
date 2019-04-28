//
//  GetDeviceInfoTool.m
//  MMJF
//
//  Created by admin on 2018/1/8.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "GetDeviceInfoTool.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreLocation/CoreLocation.h>
#import <AdSupport/AdSupport.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <sys/utsname.h>
#import <ifaddrs.h>
#import <arpa/inet.h>


@interface GetDeviceInfoTool()


@end



@implementation GetDeviceInfoTool


+(NSDictionary *)getDeviceInfoAction{
   
    NSMutableDictionary *deviceInfoDict = [[NSMutableDictionary alloc]init];
    
    //32位随机数
    NSString *token_no =  [self randomSmallCaseString:32];
    [deviceInfoDict setObject:token_no forKey:@"appRandom"];
    
    //IMSI(国际移动用户识别码)
    [deviceInfoDict setObject:[self getIMSI] forKey:@"appRandom"];

    //本地mac api私有化 从iOS7及更高版本往后，如果你向ios设备请求获取mac地址，系统将返回一个固定值“02:00:00:00:00:00”
    [deviceInfoDict setObject:@"02:00:00:00:00:00" forKey:@"mac"];
    //IMEI（国际移动设备标识）
    [deviceInfoDict setObject:@" " forKey:@"imei"];
    
    //国家
    NSString *locale = [[NSLocale currentLocale] localeIdentifier];
    [deviceInfoDict setObject:locale forKey:@"country"];

    //获取当前设备语言
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    [deviceInfoDict setObject:languageName forKey:@"language"];
    
    // 获取系统时区
    NSTimeZone *systemZone = [NSTimeZone systemTimeZone];
    [deviceInfoDict setObject:systemZone.name forKey:@"timeZone"];

    //定位方式
    [deviceInfoDict setObject:@"" forKey:@"locationType"];
    
    //操作系统
    NSString *systemName = [[UIDevice currentDevice]systemName];
    [deviceInfoDict setObject:systemName forKey:@"osName"];

    //当前系统版本号
    NSString *systemVersion = [[UIDevice currentDevice]systemVersion];
    [deviceInfoDict setObject:systemVersion forKey:@"osVersion"];

    //设备是否越狱
    [deviceInfoDict setObject:[self isJailBreak] forKey:@"isRoot"];

    //系统当前时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH-mm-ss"];
    NSDate *datenow = [NSDate date];
    NSString *nowtimeStr = [formatter stringFromDate:datenow];
    [deviceInfoDict setObject:nowtimeStr forKey:@"gmtTime"];

    //屏幕尺寸
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    NSString *scurenWidth = [NSString stringWithFormat:@"%.0f X %.0f",size.width,size.height];
    [deviceInfoDict setObject:scurenWidth forKey:@"size"];

    
    //屏幕分辨率
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenRect.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat screenX = screenSize.width * scale;
    CGFloat screenY = screenSize.height * scale;
    [deviceInfoDict setObject:[NSString stringWithFormat:@"%.0f * %.0f",screenX,screenY] forKey:@"resolution"];

    //手机品牌
    [deviceInfoDict setObject:@"apple" forKey:@"brand"];

    //手机型号
    [deviceInfoDict setObject:[self iphoneType] forKey:@"phoneModel"];

    //wifi名称
//    [deviceInfoDict setObject:[self getWifiName] forKey:@"wifi"];
    [deviceInfoDict setObject:@"" forKey:@"wifi"];
    
    //wifi mac地址
    [deviceInfoDict setObject:[self getWiFiMac] forKey:@"wifiMac"];
    
    //基站信息
    [deviceInfoDict setObject:@"" forKey:@"baseStnInfo"];
    //基站地理位置
    [deviceInfoDict setObject:@"" forKey:@"baseStnLocation"];

    //设备号
//    [deviceInfoDict setObject:DEVICE_NUM forKey:@"serialNumber"];
//    [deviceInfoDict setObject:DEVICE_NUM forKey:@"deviceNum"];
    
    //是否触屏
    [deviceInfoDict setObject:@"Y" forKey:@"supportTouchscreen"];

    //移动国家网码
    CTCarrier *carrier = [[CTTelephonyNetworkInfo alloc]subscriberCellularProvider];
    NSString *carrierStr = [carrier mobileCountryCode];
    [deviceInfoDict setObject:[NSString stringWithFormat:@"%@",carrierStr.length<1?@"":carrierStr] forKey:@"mobileCountryCode"];
    [deviceInfoDict setObject:[NSString stringWithFormat:@"%@",carrierStr.length<1?@"":carrierStr]  forKey:@"mobileNetworkCode"];

    //电池电量
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    NSString *battery_level = [NSString stringWithFormat:@"%.0f",[UIDevice currentDevice].batteryLevel];
    [deviceInfoDict setObject:battery_level forKey:@"batteryLevel"];
    
    // 获取App的版本号
    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [deviceInfoDict setObject:app_Version forKey:@"appVersion"];

    //bundleId
    [deviceInfoDict setObject:[[NSBundle mainBundle] bundleIdentifier] forKey:@"bundleId"];
    //屏幕颜色位数
    [deviceInfoDict setObject:@"" forKey:@"colorBits"];
    //手机内照片个数
    [deviceInfoDict setObject:@"" forKey:@"photosNumber"];
    //手机内应用个数
    [deviceInfoDict setObject:@"" forKey:@"applicationsNumber"];
    
    
    return deviceInfoDict;
    
}

//生成指定位数的随机数
+(NSString *)randomSmallCaseString:(NSUInteger)length{
    
    NSString *output = @"";
    
    for (int i = 0; i<length; i++) {
        NSString *token_no = [NSString stringWithFormat:@"%u", arc4random() %10];
        [output stringByAppendingString:token_no];
    }
    return output;
}


+(NSString *)getIMSI{
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *mcc = [carrier mobileCountryCode];
    NSString *mnc = [carrier mobileNetworkCode];
    NSString *imsi = [NSString stringWithFormat:@"%@%@", mcc, mnc];
    
    return imsi;
}



/**
 根据是否能打开cydia判断 是否越狱
 @return return value description
 */
+(NSString *)isJailBreak {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        NSLog(@"The device is jail broken!");
        return @"Y";
    }
    NSLog(@"The device is NOT jail broken!");
    return @"N";
}




+(NSString*)iphoneType {
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"]) return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"]) return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"]) return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"]) return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"]) return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"]) return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"]) return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"]) return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"]) return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"]) return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"]) return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"]) return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"]) return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"]) return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"]) return@"iPhone 6";

    if([platform isEqualToString:@"iPhone8,1"]) return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"]) return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"]) return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"]) return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"]) return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"]) return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"]) return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"]) return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"]) return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"]) return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"]) return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"]) return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"]) return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"]) return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"]) return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"]) return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"]) return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"]) return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"]) return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"]) return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"]) return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"]) return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"]) return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"]) return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"]) return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"]) return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"]) return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"]) return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"]) return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"]) return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"]) return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"]) return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"]) return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"]) return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"]) return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"]) return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"]) return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"]) return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"]) return@"iPhone Simulator";
    
    return platform;
    
}


//获取WiFiName
+ (NSString *)getWifiName{
    
    NSString *wifiName = @"Not Found";
    
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            wifiName = [dict valueForKey:@"SSID"];
        }
         CFRelease(myArray);
    }
    return wifiName;

}

+ (NSString *)getWiFiMac{
//    NSString *ssid = @"Not Found";
    NSString *macIp = @"Not Found";
    CFArrayRef myArray =CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray,0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
//            ssid = [dict valueForKey:@"SSID"];           //WiFi名称
            macIp = [dict valueForKey:@"BSSID"];     //Mac地址
        }
        CFRelease(myArray);
    }
    return macIp;
}





//获取ip地址
+ (NSString *)getIpAddresses{
    NSString *address = @"0.0.0.0";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}


+(NSString *)getUserAgent{
    NSString *systemName = [[UIDevice currentDevice]systemName];
    return [NSString stringWithFormat:@"IOS_%@_%@",systemName,[self iphoneType]];
}


+(NSString *)getResolution{
    //屏幕尺寸
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    return [NSString stringWithFormat:@"%.0f X %.0f",size.width,size.height];
}



    
@end
