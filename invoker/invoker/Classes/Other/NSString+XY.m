//
//  NSString+XY.m
//  invoker
//
//  Created by 韩元旭 on 2017/5/16.
//  Copyright © 2017年 韩元旭. All rights reserved.
//

#import "NSString+XY.h"

@implementation NSString (XY)

- (NSString *)xy_PinYin {
    
    NSMutableString *pinyin = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return pinyin;
}

@end
