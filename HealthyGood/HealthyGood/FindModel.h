//
//  FindModel.h
//  HealthyGood
//
//  Created by Qianfeng on 16/3/5.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@class ChannelslistModel,ChannelsModel;
@interface FindModel : JSONModel

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSArray<ChannelslistModel *> *channelslist;

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, assign) NSInteger depth;

@end

@interface ChannelslistModel : JSONModel

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, strong) NSArray<ChannelsModel *> *channels;

@end

@interface ChannelsModel : JSONModel

@property (nonatomic, strong) NSArray<NSString *> *top_words;

@property (nonatomic, assign) NSInteger rate;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) NSInteger qid;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *bookcount;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *name;

@end

