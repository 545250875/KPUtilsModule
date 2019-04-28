//
//  DESUtils.h
//  MMJF
//
//  Created by admin on 2018/8/24.
//  Copyright © 2018年 MG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface DESUtils : NSObject


/**
 3DES加密

 @param plainText 加密字符串
 @param encryptOrDecrypt   kCCEncrypt：加密, kCCDecrypt:解密,
 */
-(NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt;


@end
