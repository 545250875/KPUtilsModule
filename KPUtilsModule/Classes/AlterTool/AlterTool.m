//
//  AlterTool.m
//  XinMaLiu
//
//  Created by admin on 2018/5/18.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "AlterTool.h"


@implementation AlterTool


+(void)showAlterWithContentString:(NSString *)content actionTitle:(NSString *)actionTitle block:(AlterBlock)alterBlock{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (alterBlock) {
            alterBlock();
        }
    }];
    [alertController addAction:okAction];
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertController animated:YES completion:nil];
    
}




+ (void) showAlert:(NSString *)content actionTitle:(NSString *)actionTitle{
    
    // 保证在主线程上执行
    if ([NSThread isMainThread]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:content delegate:self cancelButtonTitle:actionTitle otherButtonTitles:nil, nil];
        [alertView show];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:content delegate:self cancelButtonTitle:actionTitle otherButtonTitles:nil, nil];
            [alertView show];
        });
    }
}




+(void)showAlterVCWithContentString:(NSString *)contentText cancelActionText:(NSString *)cancelActionText  sureActionText:(NSString *)sureActionText vc:(UIViewController *)vc  cancelBlock:(void (^)(void))cancelBlock sureBlock:(void (^)(void))sureBlock{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:contentText preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:cancelActionText style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock) {
          cancelBlock();
        }
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureActionText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (sureBlock) {
            sureBlock();
        }
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:sureAction];
    [vc presentViewController:alertVC animated:YES completion:nil];
    
}


@end
