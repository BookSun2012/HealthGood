//
//  ChannalTypeModel.m
//  HealthyGood
//
//  Created by zhoushuayng on 16/2/26.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "ChannalTypeModel.h"

@implementation ChannalTypeModel


+ (NSMutableArray *)arrayAppModelWithResponse:(NSDictionary *)response{
    NSMutableArray *applications = response[@"user_channels"];
    NSError *error = nil;
    NSMutableArray *resultArray = [ChannalTypeModel arrayOfModelsFromDictionaries:applications error:&error];
    if (error) {
        NSLog(@"解析失败");
    }
    return resultArray;
}
+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
