//
//  UITextField+Extension.m
//  Sumi
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 MG. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

- (NSRange)selectedRange {
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

- (void)setSelectedRange:(NSRange)range {
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    
    [self setSelectedTextRange:selectionRange];
}

/**
 *  设置空格插入的位置
 *
 *  @param insertPosition <#insertPosition description#>
 */
- (void)insertWhitSpaceInsertPosition:(NSArray *)insertPosition replacementString:(NSString *)string textlength:(NSInteger)length {
    if ([string isEqualToString:@""]) {
        [self deleteBackward];
    }
    if (self.text.length > length) {
        return;
    }
    if (![string isEqualToString:@""]) {
        [self insertText:string];
    }
    
    // 判断光标位置
    NSRange range = [self selectedRange];
    NSUInteger targetCursorPosition = range.location;
    // 移除空格
    NSString *removeNonDigits = [self removeWhitespaceCharacter:self.text andPreserveCursorPosition:&targetCursorPosition];
    // 插入空格
    NSString *phoneNumberWithSpaces = [self insertWhitespaceCharacter:removeNonDigits andPreserveCursorPosition:&targetCursorPosition insertPosition:insertPosition];
    // 重新赋值
    self.text = phoneNumberWithSpaces;
    // 设置光标位置
    NSRange sRange = NSMakeRange(targetCursorPosition, range.length);
    [self setSelectedRange:sRange];
}

/**
 *  插入空格
 *
 *  @param string         <#string description#>
 *  @param cursorPosition <#cursorPosition description#>
 *  @param insertPosition 分隔位置，数组全部传递数字
 *
 *  @return <#return value description#>
 */
- (NSString *)insertWhitespaceCharacter:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition insertPosition:(NSArray *)insertPosition {
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    for (NSUInteger i = 0; i < string.length; i++) {
        [insertPosition enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (i == [obj integerValue]) {
                [stringWithAddedSpaces appendString:@" "];
                if(i<cursorPositionInSpacelessString) {
                    (*cursorPosition)++;
                }
            }
        }];
        
        unichar characterToAdd = [string characterAtIndex:i];
        NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    return stringWithAddedSpaces;
}

/**
 *  移除空格
 *
 *  @param string         <#string description#>
 *  @param cursorPosition <#cursorPosition description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)removeWhitespaceCharacter:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSUInteger originalCursorPosition =*cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    for (NSUInteger i = 0; i < string.length; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        if(![[NSCharacterSet whitespaceCharacterSet] characterIsMember:characterToAdd]) {
            NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
            [digitsOnlyString appendString:stringToAdd];
        }
        else {
            if(i < originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    return digitsOnlyString;
}









/**
 金额textfile 数据限制

 @param string string description
 @param textField textField description
 @param range range description
 @return return value description
 */
-(BOOL)limitTextFiledInput:(NSString *)string textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range{
    
    
    UITextField *countTextField = textField;
    NSString *NumbersWithDot = @".1234567890";
    NSString *NumbersWithoutDot = @"1234567890";
    // 判断是否输入内容，或者用户点击的是键盘的删除按钮
    if (![string isEqualToString:@""]) {
        NSCharacterSet *cs;
        if ([textField isEqual:countTextField]) {
            // 小数点在字符串中的位置 第一个数字从0位置开始
            NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
            // range.location 表示的是当前输入的内容在整个字符串中的位置，位置编号从0开始
            if (dotLocation == NSNotFound ) {
                cs = [[NSCharacterSet characterSetWithCharactersInString:NumbersWithDot] invertedSet];
                if (range.location >= 9) {
                    NSLog(@"单笔金额不能超过亿位");
                    if ([string isEqualToString:@"."] && range.location == 9) {
                        return YES;
                    }
                    return NO;
                }
            }else {
                cs = [[NSCharacterSet characterSetWithCharactersInString:NumbersWithoutDot] invertedSet];
            }
            // 按cs分离出数组,数组按@""分离出字符串
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            BOOL basicTest = [string isEqualToString:filtered];
            if (!basicTest) {
                NSLog(@"只能输入数字和小数点");
                return NO;
            }
            if (dotLocation != NSNotFound && range.location > dotLocation + 2) {
                NSLog(@"小数点后最多两位");
                return NO;
            }
            if (textField.text.length > 11) {
                return NO;
            }
            
        }
        
    }
    return YES;
    
}




- (BOOL)mamiTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSLog(@"%@",NSStringFromRange(range));
    if (textField) {
        NSString* text = textField.text;
        //删除
        if([string isEqualToString:@""]){
            
            //删除一位
            if(range.length == 1){
                //最后一位,遇到空格则多删除一次
                if (range.location == text.length-1 ) {
                    if ([text characterAtIndex:text.length-1] == ' ') {
                        [textField deleteBackward];
                    }
                    return YES;
                }
                //从中间删除
                else{
                    NSInteger offset = range.location;
                    
                    if (range.location < text.length && [text characterAtIndex:range.location] == ' ' && [textField.selectedTextRange isEmpty]) {
                        [textField deleteBackward];
                        offset --;
                    }
                    [textField deleteBackward];
                    textField.text = [self parseString:textField.text];
                    UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                    textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
                    return NO;
                }
            }
            else if (range.length > 1) {
                BOOL isLast = NO;
                //如果是从最后一位开始
                if(range.location + range.length == textField.text.length ){
                    isLast = YES;
                }
                [textField deleteBackward];
                textField.text = [self parseString:textField.text];
                
                NSInteger offset = range.location;
                if (range.location == 3 || range.location  == 8) {
                    offset ++;
                }
                if (isLast) {
                    //光标直接在最后一位了
                }else{
                    UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                    textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
                }
                
                return NO;
            }
            
            else{
                return YES;
            }
        }
        
        else if(string.length >0){
            
            //限制输入字符个数
            if (([self noneSpaseString:textField.text].length + string.length - range.length > 11) ) {
                return NO;
            }
            //判断是否是纯数字(千杀的搜狗，百度输入法，数字键盘居然可以输入其他字符)
            //            if(![string isNum]){
            //                return NO;
            //            }
            [textField insertText:string];
            textField.text = [self parseString:textField.text];
            
            NSInteger offset = range.location + string.length;
            if (range.location == 3 || range.location  == 8) {
                offset ++;
            }
            UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
            textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
            return NO;
        }else{
            return YES;
        }
        
    }
    
    return YES;
}


-(NSString*)noneSpaseString:(NSString*)string
{
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString*)parseString:(NSString*)string
{
    if (!string) {
        return nil;
    }
    NSMutableString* mStr = [NSMutableString stringWithString:[string stringByReplacingOccurrencesOfString:@" " withString:@""]];
    if (mStr.length >3) {
        [mStr insertString:@" " atIndex:3];
    }if (mStr.length > 8) {
        [mStr insertString:@" " atIndex:8];
        
    }
    
    return  mStr;
}




@end
