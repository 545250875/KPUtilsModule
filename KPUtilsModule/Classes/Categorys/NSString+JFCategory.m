//
//  NSString+JFCategory.m
//  JFun
//
//  Created by WilsonLee on 15/6/9.
//  Copyright (c) 2015年 miqu. All rights reserved.
//

#import "NSString+JFCategory.h"
#import "NSDate+Extension.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (JFCategory)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:attrs context:nil].size;
}

@end

@implementation NSString (Align)

- (void)drawInRect:(CGRect)rect withAttributes:(NSDictionary *)attributes alignment:(NSStringAlignment)alignment
{
    UIFont *font = [attributes objectForKey:NSFontAttributeName];
    switch (alignment) {
            
        case NSStringAlignmentTop:
            break;
            
        case NSStringAlignmentMiddle:
            rect.origin.y = rect.origin.y + ((rect.size.height - font.pointSize) / 2);
            break;
            
        case NSStringAlignmentBottom:
            rect.origin.y = rect.origin.y + rect.size.height - font.pointSize;
            break;
    }
    [self drawInRect:rect withAttributes:attributes];
}

@end

@implementation NSString (File)

- (NSString*)GetNameAtPath
{
    NSArray *PathArray = [self componentsSeparatedByString:@"/"];
    if (PathArray && PathArray.count > 0)
        return [PathArray objectAtIndex:PathArray.count - 1];
    return self;
}

- (NSString*)GetNameAtPathMD5
{
    const char *STR = [self UTF8String];
    unsigned char R[CC_MD5_DIGEST_LENGTH];
    CC_MD5  (STR, (CC_LONG)strlen(STR), R);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             R[0], R[1], R[2], R[3], R[4], R[5], R[6], R[7], R[8], R[9], R[10], R[11], R[12], R[13], R[14], R[15]]uppercaseString];
}

- (NSString*)GetPathAtCaches:(NSString*)Path
{
    if (Path == NULL)
        Path =  @"";
        
        return [[NSString stringWithFormat:@"%@/Library/Caches/%@",NSHomeDirectory(),Path] stringByAppendingPathComponent:self];
}

- (NSString*)GetPathAtLibrary:(NSString*)Path
{
    if (Path == NULL)
        Path =  @"";
        
        return [[NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),Path] stringByAppendingPathComponent:self];
}

- (NSString*)GetPathAtFolderCaches:(NSString*)Path
{
    if (Path == NULL)
        Path =  @"";
        
        return [NSString stringWithFormat:@"%@/Library/Caches/%@/%@/",NSHomeDirectory(),Path,self];
}

- (NSString*)GetPathAtFolderLibrary:(NSString*)Path
{
    if (Path == NULL)
        Path =  @"";
        
        return [NSString stringWithFormat:@"%@/Library/%@/%@/",NSHomeDirectory(),Path,self];
}

- (BOOL)ExistsFile
{
    return [[NSFileManager defaultManager] fileExistsAtPath:self];
}

- (void)CreateFile
{
    if(![[NSFileManager defaultManager] fileExistsAtPath:self])
        [[NSFileManager defaultManager] createFileAtPath:self contents:nil attributes:nil];
}

- (void)CreateDirectory
{
    if(![[NSFileManager defaultManager] fileExistsAtPath:self isDirectory:nil])
        [[NSFileManager defaultManager] createDirectoryAtPath:self withIntermediateDirectories:YES attributes:nil error:nil];
}

- (double)CountFile
{
    NSFileManager *Manager = [NSFileManager defaultManager];
    if ([Manager fileExistsAtPath:self])
        return [[Manager attributesOfItemAtPath:self error:nil] fileSize];
    
    return 0;
}

- (double)CountDirectory
{
    NSFileManager *Manager = [NSFileManager defaultManager];
    if (![Manager fileExistsAtPath:self]) return 0;
    
    NSEnumerator *Enumerator = [[Manager subpathsAtPath:self] objectEnumerator];
    NSString     *File;
    long long     Count = 0;
    while ((File = [Enumerator nextObject]) != nil)
    {
        NSString *Path = [self stringByAppendingPathComponent:File];
        Count += [Path CountFile];
    }
    return Count;
}

@end


@implementation NSString (Value)

- (BOOL)isPhone
{
    if (self.length == 11)
    {
//        NSScanner *Scanner = [NSScanner scannerWithString:self];
//        int Value;
//        return [Scanner scanInt:&Value] && [Scanner isAtEnd];
        NSString * pattern = @"^1\\d{10}$";
        return [NSString matchString:self pattern:pattern];
    }
    return NO;
}
+ (BOOL)matchString:(NSString *)string pattern:(NSString *) pattern {
    if (!string) {
        return NO;
    }
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (regex == nil) {
        NSLog(@"pattern is invalid; error:%@", error);
        return NO;
    }
    
    NSUInteger number = [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, [string length])];
    return number == 1;
}
- (BOOL)isEmail
{
    if (self.length >= 5)
    {
        if (([self rangeOfString:@"@"].location != NSNotFound) &&
            ([self rangeOfString:@"."].location != NSNotFound))
            return YES;
    }
    return NO;
}

- (int) GetLength
{
    int Length = 0;
    char * P = (char *)  [self cStringUsingEncoding:      NSUnicodeStringEncoding];
    for (int i = 0 ; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++)
    {
        if (*P)
        {
            P++;
            Length++;
        }
        else
            P++;
    }
    return Length;
}

- (CGFloat)GetWidth:(CGFloat)Height Font:(UIFont *)Font
{
    CGSize  Size = [self boundingRectWithSize: CGSizeMake(MAXFLOAT, Height)
                                      options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                   attributes:[NSDictionary dictionaryWithObjectsAndKeys:Font, NSFontAttributeName,nil]
                                      context: nil].size;
    return  Size.width;
}

- (CGFloat)GetHeight:(CGFloat)Width Font:(UIFont *)Font
{
    CGSize  Size = [self boundingRectWithSize: CGSizeMake(Width, MAXFLOAT)
                                      options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                   attributes:[NSDictionary dictionaryWithObjectsAndKeys:Font, NSFontAttributeName,nil]
                                      context: nil].size;
    return  Size.height;
}

- (CGSize)getBoundWithSize:(CGSize)size font:(UIFont *)font{
    CGSize s = [self boundingRectWithSize:CGSizeMake(ceilf(size.width), ceilf(size.height))
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil]
                                  context:nil].size;
    return CGSizeMake(ceilf(s.width), ceilf(s.height));
}

- (BOOL) GetFigure:(BOOL)Point
{
    BOOL OK = YES;
    NSCharacterSet *Set;
    if (Point)
        Set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    else
        Set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < self.length)
    {
        NSString *String = [self substringWithRange:NSMakeRange(i, 1)];
        NSRange Range = [String rangeOfCharacterFromSet:Set];
        if (Range.length == 0)
        {
            OK = NO;
            break;
        }
        i++;
    }
    return OK;
}

- (BOOL) GetJudgeChat:(BOOL)Capital
{
    BOOL OK = YES;
    NSCharacterSet *Set;
    if (Capital)
        Set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-"];
    else
        Set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz0123456789_-"];
    int i = 0;
    while (i < self.length)
    {
        NSString *String = [self substringWithRange:NSMakeRange(i, 1)];
        NSRange Range = [String rangeOfCharacterFromSet:Set];
        if (Range.length == 0)
        {
            OK = NO;
            break;
        }
        i++;
    }
    return OK;
}

- (NSData *)GetDataImage
{
    NSString *STR = self;
    STR = [STR stringByReplacingOccurrencesOfString:@"<" withString:@""];
    STR = [STR stringByReplacingOccurrencesOfString:@">" withString:@""];
    STR = [STR stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    Byte Bytes[STR.length];
    int J = 0;
    for(int i = 0; i < STR.length; i++)
    {
        int int_CH;
        
        unichar Hex_Char1 = [STR characterAtIndex:i];
        int int_CH1;
        if (Hex_Char1 >= '0' && Hex_Char1 <= '9')
            int_CH1 = (Hex_Char1 - 48) * 16;
        else if (Hex_Char1 >= 'A' && Hex_Char1 <= 'F')
            int_CH1 = (Hex_Char1 - 55) * 16;
        else
            int_CH1 = (Hex_Char1 - 87) * 16;
        i++;
        
        unichar Hex_Char2 = [STR characterAtIndex:i];
        int int_CH2;
        if (Hex_Char2 >= '0' && Hex_Char2 <= '9')
            int_CH2 = (Hex_Char2 - 48);
        else if (Hex_Char1 >= 'A' && Hex_Char1 <= 'F')
            int_CH2 = (Hex_Char2 - 55);
        else
            int_CH2 = (Hex_Char2 - 87);
        
        int_CH = int_CH1 + int_CH2;
        Bytes[J] = int_CH;
        J++;
    }
    return  [[NSData alloc]initWithBytes:Bytes length:STR.length];
}

- (NSTimeInterval) GetTimeValue
{
    NSInteger H = 0, M = 0, S = 0;
    NSArray *Time = [self componentsSeparatedByString:@":"];
    S = [[Time objectAtIndex:Time.count - 1] integerValue];
    M = [[Time objectAtIndex:Time.count - 2] integerValue];
    if   (Time.count > 2)
        H = [[Time objectAtIndex:0]              integerValue];
    return H * 3600 + M * 60 + S;
}

- (NSDate *)getTimeDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:self];
    return date;
}

- (NSString *)getTimeDateStringShort
{
    NSDate *date = [self getTimeDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    return [dateFormatter stringFromDate:date];
}

- (NSString *)getTimeDateStringLong
{
    NSDate *date = [self getTimeDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

- (NSMutableAttributedString *)getStrMaxNumber:(NSInteger)maxNum Linespace:(NSInteger)lineSpace
{
    NSString *str = self;
    if (self.length > maxNum) {
        str = [NSString stringWithFormat:@"%@...",[self substringToIndex:maxNum]];
    }
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    return  attributedString;
}

- (NSMutableAttributedString *)getStrWithLinespace:(NSInteger)lineSpace{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    return  attributedString;
}
- (NSString *)getStrMaxNumber:(NSInteger)maxNum
{
    NSString *str = nil;
    if (self.length > maxNum) {
        str = [NSString stringWithFormat:@"%@...",[self substringToIndex:maxNum-1]];
    }else
    {
        str = self;
    }
    return str;
}

- (NSString *)stringValue{
    return self;
}

//浮点数处理并去掉多余的0
+ (NSString *)stringDisposeWithFloat:(float)floatValue {
    
    NSString *str = [NSString stringWithFormat:@"%.2f",floatValue];
    
    long len = str.length;
    for (int i = 0; i < len; i++)
    {
        if (![str  hasSuffix:@"0"])
            break;
        else
            str = [str substringToIndex:[str length]-1];
    }
    if ([str hasSuffix:@"."])//避免像2.0000这样的被解析成2.
    {
        return [str substringToIndex:[str length]-1];//s.substring(0, len - i - 1);
    }
    else
    {
        return str;
    }
}

- (NSString *)changeToShowPrice
{
    NSString *showPrice = nil;
    if ([self floatValue] > 0) {
        if ([self floatValue] > 1)
        {
            NSString *price = [NSString stringDisposeWithFloat:[self floatValue]];
            showPrice =  [NSString stringWithFormat:@"¥%@",price];
        }else{
            showPrice = [NSString stringWithFormat:@"¥%@",self];
        }
        
        if ([showPrice rangeOfString:@"元"].length > 0) {
            showPrice = [showPrice stringByReplacingOccurrencesOfString:@"元" withString:@""];
        }
        if ([self rangeOfString:@"起"].length > 0 && [showPrice rangeOfString:@"起"].length == 0) {
            showPrice = [showPrice stringByAppendingString:@"起"];
        }
    }else{
        if ([self rangeOfString:@"起"].length > 0) {
            showPrice = [NSString stringWithFormat:@"¥%@",self];
        }else{
            showPrice = @"免费";
        }
    }
    return showPrice;
}


- (NSString *)toNSDateStrWithTimeSpStr{
    NSString * timeStampString = self;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [objDateformat stringFromDate: date];
}
@end
