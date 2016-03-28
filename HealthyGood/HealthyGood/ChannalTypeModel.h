//
//  ChannalTypeModel.h
//  HealthyGood
//
//  Created by Qianfeng on 16/2/26.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ChannalTypeModel : JSONModel

//bookcount = "52.1\U4e07\U4eba\U8ba2\U9605";
//id = u475;
//image = "http://s.go2yd.com/b/icsw8d2j_6w00d1d1.jpg";
//name = "\U76ae\U80a4\U75c5";
//qid = 331;
//rate = 5;
//score = 1;
//"top_words" =                     (
//                                   "\U76ae\U80a4\U75c5"
//                                   );
//type = "user_channel";


//"channel_id" = 2314500145;
//checksum = "\U611f\U5192";
//fromId = u7496;
//image = "http://s.go2yd.com/b/idazqi75_0q00d1d1.jpg";
//name = "\U611f\U5192";
//"share_id" = cid129zrqpt0;
//type = "user_channel";
//

@property (nonatomic,copy)NSString *bookcount;
@property (nonatomic,copy)NSString *id;
@property (nonatomic,copy)NSString *image;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *qid;
@property (nonatomic,copy)NSString *rate;
@property (nonatomic,copy)NSString *score;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,strong)NSArray *top_words;
@property (nonatomic,copy)NSString *channel_id;
+ (NSMutableArray *)arrayAppModelWithResponse:(NSDictionary *)response;
@end
