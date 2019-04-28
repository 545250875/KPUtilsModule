//
//  NSString+JFCategory.h
//  JFun
//
//  Created by WilsonLee on 15/6/9.
//  Copyright (c) 2015年 miqu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JFCategory)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end

typedef enum {
    NSStringAlignmentTop,
    NSStringAlignmentMiddle,
    NSStringAlignmentBottom
} NSStringAlignment;

@interface NSString (Align)

- (void)drawInRect:(CGRect)rect withAttributes:(NSDictionary *)attributes alignment:(NSStringAlignment)alignment;

@end

@interface NSString (File)

//获取文件名
- (NSString*)GetNameAtPath;
//获取文件名
- (NSString*)GetNameAtPathMD5;
//获取文档下的文件路径
- (NSString*)GetPathAtCaches: (NSString*)Path;
- (NSString*)GetPathAtLibrary:(NSString*)Path;
//获取文档下的文件夹路径
- (NSString*)GetPathAtFolderCaches: (NSString*)Path;
- (NSString*)GetPathAtFolderLibrary:(NSString*)Path;

//判断文件是否存在
- (BOOL)ExistsFile;
//创建文件
- (void)CreateFile;
//创建文件路径
- (void)CreateDirectory;

//创建文件大小
- (double)CountFile;
- (double)CountDirectory;

@end

@interface NSString (Value)

- (BOOL)isPhone;
- (BOOL)isEmail;

//统计混编字符
- (int)      GetLength;
//计算字符宽度
- (CGFloat)  GetWidth:(CGFloat)Height Font:(UIFont *)Font;
//计算字符高度
- (CGFloat)  GetHeight:(CGFloat)Width Font:(UIFont *)Font;
//判断是否数字
- (BOOL)     GetFigure:(BOOL)Point;
//判断字符合法
- (BOOL)     GetJudgeChat:(BOOL)Capital;

//计算边界大小
-(CGSize)getBoundWithSize:(CGSize)size font:(UIFont *)font;


//字符转换图片
- (NSData *) GetDataImage;
//字符计算时差
- (NSTimeInterval)GetTimeValue;
//字符转换时间
- (NSDate *)getTimeDate;
- (NSString *)getTimeDateStringShort;
- (NSString *)getTimeDateStringLong;
- (NSMutableAttributedString *)getStrMaxNumber:(NSInteger )maxNum Linespace:(NSInteger)lineSpace;
- (NSMutableAttributedString *)getStrWithLinespace:(NSInteger)lineSpace;
- (NSString *)getStrMaxNumber:(NSInteger )maxNum;

- (NSString *)stringValue;

//浮点数处理并去掉多余的0
+ (NSString *)stringDisposeWithFloat:(float)floatValue;
//根据需求转化成展示的价格
- (NSString *)changeToShowPrice;

/**
 *  把时间戳转化标准的字符串格式
 */
- (NSString *)toNSDateStrWithTimeSpStr;
@end


