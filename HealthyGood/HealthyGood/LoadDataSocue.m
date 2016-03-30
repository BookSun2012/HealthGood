//
//  LoadDataSocue.m
//  HealthyGood
//
//  Created by zhoushuayang on 16/3/8.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "LoadDataSocue.h"
#import "Define.h"
@interface LoadDataSocue ()
@property (nonatomic,strong)NSMutableArray *selfDataSouce;
@end


@implementation LoadDataSocue

//声明一个单例
+ (instancetype)loadDataSouce {
    static LoadDataSocue *load = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //        NSLog(@"只执行一次");
        load = [[LoadDataSocue alloc]init];
    });//block 代码块 只执行一次
    return  load;
}


- (NSMutableArray *)loadDataSocue {
//     __weak LoadDataSocue *weakSelf = self;
    
    HttpEngine *enegr = [HttpEngine shareEngine];
    [enegr GET:HeadViewURL parameters:nil success:^(id response) {
        NSMutableArray *dataSouce = [NSMutableArray array];
        dataSouce= [Result1 arrayOfModelsFromDictionaries:response[@"result"] error:nil];
        
    } failed:^(NSError *error) {
        
    }];
    
    return nil;
}
@end
