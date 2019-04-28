//
//  UserDefaultsTools.h
//  MMJF
//
//  Created by admin on 2017/12/13.
//  Copyright © 2017年 MG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsTools : NSObject


+(id)objectForKey:(NSString *)anAttribute;

+(void)setObject:(id)value forKey:(NSString *)defaultName;

+(void)removeObjectForKey:(NSString *)anAttribute;


@end
