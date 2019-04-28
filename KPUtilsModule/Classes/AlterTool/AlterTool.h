//
//  AlterTool.h
//  XinMaLiu
//
//  Created by admin on 2018/5/18.
//  Copyright © 2018年 MG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^AlterBlock)(void);

@interface AlterTool : NSObject

+ (void) showAlert:(NSString *)content actionTitle:(NSString *)actionTitle;

    
+(void)showAlterWithContentString:(NSString *)content actionTitle:(NSString *)actionTitle block:(AlterBlock)alterBlock;


+(void)showAlterVCWithContentString:(NSString *)contentText cancelActionText:(NSString *)cancelActionText  sureActionText:(NSString *)sureActionText vc:(UIViewController *)vc  cancelBlock:(void (^)(void))cancelBlock sureBlock:(void (^)(void))sureBlock;



@end
