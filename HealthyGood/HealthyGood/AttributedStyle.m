//
//  AttributedStyle.m
//  AttributeString
//
//  Created by zhoushuyang on 16/2/27.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "AttributedStyle.h"

@implementation AttributedStyle

+(AttributedStyle *)attributeName:(NSString *)attributeName value:(id)value range:(NSRange)range{
    AttributedStyle *style = [[self class]new];
    style.attributeName = attributeName;
    style.value         = value;
    style.range         = range;
    
    return style;
    
    
}


@end
