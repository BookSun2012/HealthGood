//
//  FindModel.m
//  HealthyGood
//
//  Created by zhoushuyang on 16/3/5.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "FindModel.h"

@implementation FindModel


+ (NSDictionary *)objectClassInArray{
    return @{@"channelslist" : [ChannelslistModel class]};
}
@end


@implementation ChannelslistModel

+ (NSDictionary *)objectClassInArray{
    return @{@"channels" : [ChannelsModel class]};
}

@end


@implementation ChannelsModel

@end


