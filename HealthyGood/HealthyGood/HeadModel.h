//
//  HeadModel.h
//  HealthyGood
//
//  Created by Qianfeng on 16/3/3.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class Result1;
@interface HeadModel : JSONModel

@property (nonatomic, copy) NSString *status;

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSArray<Result1 *> *result;

@property (nonatomic, assign) NSInteger fresh_count;

@property (nonatomic, copy) NSString *search_hint;

@end
@interface Result1 : JSONModel

@property (nonatomic, assign) NSInteger comment_count;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *itemid;

@property (nonatomic, assign) NSInteger dtype;

@property (nonatomic, assign) NSInteger mtype;

@property (nonatomic, strong) NSArray<NSString *> *image_urls;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, assign) NSInteger up;

@property (nonatomic, copy) NSString *docid;

@property (nonatomic, assign) NSInteger down;

@property (nonatomic, strong) NSArray<NSString *> *dislike_reasons;

@property (nonatomic, copy) NSString *meta;

@property (nonatomic, copy) NSString *pageid;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, assign) BOOL auth;

@property (nonatomic, copy) NSString *impid;

@property (nonatomic, copy) NSString *ctype;

@property (nonatomic, assign) NSInteger like;


@end

