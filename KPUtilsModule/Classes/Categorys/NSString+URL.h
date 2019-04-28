//
//  NSString+URL.h
//  MMJF
//
//  Created by admin on 2018/8/7.
//  Copyright © 2018年 MG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)

/**
 *  URLEncode
 */
- (NSString *)URLEncodedString;

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString;

@end
