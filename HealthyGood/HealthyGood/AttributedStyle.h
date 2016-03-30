//
//  AttributedStyle.h
//  AttributeString
//
//  Created by zhoushuyang on 16/2/27.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AttributedStyle : NSObject

@property (nonatomic,copy)NSString *attributeName;
@property (nonatomic,strong)id value;
@property (nonatomic)NSRange range;



+(AttributedStyle*)attributeName:(NSString *)attributeName value:(id)value range:(NSRange)range;

@end
