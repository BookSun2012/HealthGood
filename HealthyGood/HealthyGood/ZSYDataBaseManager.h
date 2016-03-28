//
//  ZSYDataBaseManager.h
//  HealthyGood
//
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import <CoreData/CoreData.h>
#import "FindModel.h"
@interface ZSYDataBaseManager : NSObject



@property (nonatomic,strong)FMDatabase *dataBase;
@property (nonatomic,strong)NSManagedObjectContext *context;
+(instancetype)defaultManager;
- (void)insetrDataWithModel:(ChannelsModel*)model;
- (void)saveDataWithType:(NSString *)type;
- (void)deledateDataWithType:(NSString *)type;
- (NSArray *)fetchDataWithType:(NSString *)type;
- (void)updataWithType:(NSString *)type model:(ChannelsModel*)model;
@end
