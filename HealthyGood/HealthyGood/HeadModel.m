//
//  HeadModel.m
//  HealthyGood
//
//  Created by Qianfeng on 16/3/3.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "HeadModel.h"

@implementation HeadModel


+ (NSDictionary *)objectClassInArray{
    return @{@"result1" : [Result1 class]};
}
+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation Result1
+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end


