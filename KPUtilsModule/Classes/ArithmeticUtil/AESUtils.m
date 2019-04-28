//
//  AESUtils.m
//  AES
//
//  Created by admin on 2018/8/6.
//  Copyright © 2018年 张义. All rights reserved.
//

#import "AESUtils.h"
#import <CommonCrypto/CommonCryptor.h>


@implementation AESUtils


+(NSData *)AES256ParmEncryptWithKey:(NSString *)key Encrypttext:(NSData *)text  //加密

{
    
    char keyPtr[kCCKeySizeAES256+1];
    
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [text length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          
                                          keyPtr, kCCBlockSizeAES128,
                                          
                                          NULL,
                                          
                                          [text bytes], dataLength,
                                          
                                          buffer, bufferSize,
                                          
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
    }
    
    free(buffer);
    
    return nil;
    
}



+ (NSData *)AES256ParmDecryptWithKey:(NSString *)key Decrypttext:(NSData *)text  //解密

{
    
    char keyPtr[kCCKeySizeAES256+1];
    
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [text length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          
                                          keyPtr, kCCBlockSizeAES128,
                                          
                                          NULL,
                                          
                                          [text bytes], dataLength,
                                          
                                          buffer, bufferSize,
                                          
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        
    }
    
    free(buffer);
    
    return nil;
    
}



+(NSString *) aes256_encrypt:(NSString *)key Encrypttext:(NSString *)text

{
    
    const char *cstr = [text cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:text.length];
    
    //对数据进行加密
    
    NSData *result = [AESUtils AES256ParmEncryptWithKey:key Encrypttext:data];
    
    
    
    //转换为2进制字符串
    
    if (result && result.length > 0) {
        
        
        
        Byte *datas = (Byte*)[result bytes];
        
        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
        
        for(int i = 0; i < result.length; i++){
            
            [output appendFormat:@"%02x", datas[i]];
            
        }
        
        return output;
        
    }
    
    return nil;
    
}



+(NSString *) aes256_decrypt:(NSString *)key Decrypttext:(NSString *)text

{
    
    //转换为2进制Data
    
    NSMutableData *data = [NSMutableData dataWithCapacity:text.length / 2];
    
    unsigned char whole_byte;
    
    char byte_chars[3] = {'\0','\0','\0'};
    
    int i;
    
    for (i=0; i < [text length] / 2; i++) {
        
        byte_chars[0] = [text characterAtIndex:i*2];
        
        byte_chars[1] = [text characterAtIndex:i*2+1];
        
        whole_byte = strtol(byte_chars, NULL, 16);
        
        [data appendBytes:&whole_byte length:1];
        
    }
    
    
    
    //对数据进行解密
    
    NSData* result = [AESUtils  AES256ParmDecryptWithKey:key Decrypttext:data];
    
    if (result && result.length > 0) {
        
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        
    }
    
    return nil;
    
}





//转16进制输出
+(NSString *) aesencr16byteWithKey:(NSString *)key Encrypttext:(NSString *)text

{
 
    NSData *data =[text dataUsingEncoding:NSUTF8StringEncoding];
    NSData *dats =  [self AES256ParmEncryptWithKey:key Encrypttext:data];
    NSString * result  =[self convertDataToHexStr:dats];
    return result;
    
}




//传16进制字符串 得NSData
+ (NSData *)convertHexStrToData:(NSString *)str
{
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:20];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}



//传NSData 得16进制字符串
+ (NSString *)convertDataToHexStr:(NSData *)data
{
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}



@end
