//
//  NSString+AttributeStyle.m
//  AttributeString
//
//  Created by zhouhsuyang on 16/2/27.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "NSString+AttributeStyle.h"

@implementation NSString (AttributeStyle)
-(NSAttributedString*)creatAttributeStringWithStyle:(NSArray *)styles{

    if (self.length <= 0) {
        return nil;
    }
    NSMutableAttributedString *attirbutedString = [[NSMutableAttributedString alloc]initWithString:self];
    
    for (int count = 0; count < styles.count; count++) {
        AttributedStyle *style = styles[count];
        [attirbutedString addAttribute:style.attributeName value:style.value range:style.range];
    }
    return attirbutedString;
    
    
}
@end
