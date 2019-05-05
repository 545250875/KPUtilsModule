//
//  ProgressHUDManager.h
//  MMJF
//
//  Created by admin on 2017/12/21.
//  Copyright © 2017年 MG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgressHUDManager : NSObject

+ (instancetype)sharedInstance;

-(void)initProgressHUDStyle;
    
+(void)show;

+(void)dismiss;

+(void)showImageSuccess:(NSString *)statusInfo;

+(void)showImageError:(NSString *)errInfo;

+(void)showInfo:(NSString *)infoStatus;

+(void)showSuccessToast:(NSString *)message;

+(void)showErrorToast:(NSString *)message;

+(void)showWarningToast:(NSString *)message;




@end
