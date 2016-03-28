//
//  ChannalContaintModel.h
//  HealthyGood
//
//  Created by Qianfeng on 16/2/27.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class Result;
@interface ChannalContaintModel : JSONModel


@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) NSArray<Result *> *result;
@property (nonatomic, copy) NSString *channel_type;
@property (nonatomic, copy) NSString *channel_name;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *channel_image;
@property (nonatomic, assign) NSInteger fresh_count;


@end

@interface Result : JSONModel
@property (nonatomic, copy) NSString *pageid;
@property (nonatomic, assign) NSInteger like;
@property (nonatomic, assign) NSInteger up;
@property (nonatomic, copy) NSString *ctype;
@property (nonatomic, assign) NSInteger comment_count;
@property (nonatomic, strong) NSArray<NSString *> *tags;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray<NSString *> *image_urls;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *docid;
@property (nonatomic, copy) NSString *meta;
@property (nonatomic, copy) NSString *itemid;
@property (nonatomic, assign) NSInteger down;
@property (nonatomic, assign) BOOL auth;
@property (nonatomic, assign) NSInteger dtype;
@property (nonatomic, copy) NSString *impid;

@end

