//
//  ProgressHUDManager.m
//  MMJF
//
//  Created by admin on 2017/12/21.
//  Copyright © 2017年 MG. All rights reserved.
//

#import "ProgressHUDManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <FFToast/FFToast.h>

static id _instance = nil;


@implementation ProgressHUDManager

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_instance){
            _instance = [[self alloc] init];
        }
    });
    return _instance;
}


-(void)initProgressHUDStyle{
    
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:0.7]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
}




+(void)show{
    [SVProgressHUD show];
}

+(void)dismiss{
    [SVProgressHUD dismiss];
}

+(void)showImageSuccess:(NSString *)statusInfo{
    [SVProgressHUD showImage:[UIImage imageNamed:@"success_toast_iocn"] status:statusInfo];
}

+(void)showImageError:(NSString *)errInfo{
    [SVProgressHUD showImage:[UIImage imageNamed:@"erro_toast_iocn"] status:errInfo];
}


+(void)showInfo:(NSString *)infoStatus{
    [SVProgressHUD showInfoWithStatus:infoStatus];
}

+(void)showSuccessToast:(NSString *)message{
    [SVProgressHUD dismiss];
    [FFToast showToastWithTitle:@"温馨提示" message:message iconImage:nil duration:1.5 toastType:FFToastTypeSuccess];
}

+(void)showErrorToast:(NSString *)message{
    [SVProgressHUD dismiss];
    [FFToast showToastWithTitle:@"温馨提示" message:message iconImage:nil duration:1.5 toastType:FFToastTypeError];
}


+(void)showWarningToast:(NSString *)message{
    [SVProgressHUD dismiss];
    [FFToast showToastWithTitle:@"温馨提示" message:message iconImage:nil duration:1.5 toastType:FFToastTypeWarning];
}


@end
