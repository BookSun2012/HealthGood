//
//  ChannalContaintModel.m
//  HealthyGood
//
//  Created by Qianfeng on 16/2/27.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "ChannalContaintModel.h"

@implementation ChannalContaintModel



+ (NSDictionary *)objectClassInArray{
    return @{@"result" : [Result class]};
}

+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end


@implementation Result
+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end


