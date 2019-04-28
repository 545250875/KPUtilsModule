//
//  AESUtils.h
//  AES
//
//  Created by admin on 2018/8/6.
//  Copyright © 2018年 张义. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESUtils : NSObject

+(NSData *)AES256ParmEncryptWithKey:(NSString *)key Encrypttext:(NSData *)text;   //加密

+(NSData *)AES256ParmDecryptWithKey:(NSString *)key Decrypttext:(NSData *)text;   //解密

//2进制字符串输出
+(NSString *) aes256_encrypt:(NSString *)key Encrypttext:(NSString *)text;
//2进制字符串输出
+(NSString *) aes256_decrypt:(NSString *)key Decrypttext:(NSString *)text;

+ (NSString *)convertDataToHexStr:(NSData *)data;

//转16进制输出
+(NSString *) aesencr16byteWithKey:(NSString *)key Encrypttext:(NSString *)text;




@end
