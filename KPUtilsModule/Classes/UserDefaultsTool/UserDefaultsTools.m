//
//  UserDefaultsTools.m
//  MMJF
//
//  Created by admin on 2017/12/13.
//  Copyright © 2017年 MG. All rights reserved.
//

#import "UserDefaultsTools.h"

@implementation UserDefaultsTools




+(id)objectForKey:(NSString *)anAttribute{
    //获取key-value
    return [[NSUserDefaults standardUserDefaults] objectForKey:anAttribute];
}

+(void)setObject:(id)value forKey:(NSString *)defaultName{
    //保存key-value
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    //强制保存
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+(void)removeObjectForKey:(NSString *)anAttribute{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:anAttribute];
    [[NSUserDefaults standardUserDefaults] synchronize];
}





@end
