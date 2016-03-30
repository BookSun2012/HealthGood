//
//  BaseTableView.h
//  HealthyGood
//
//  Created by zhoushuyang on 16/3/8.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol nextPage <NSObject>
//代理方式
- (void)nextPage:(NSString *)doID;

@end

//block 
typedef void(^Nextpage)(NSString *);


@interface BaseTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

//属性传值
@property (nonatomic,strong)UIViewController *controller;
//block
@property (nonatomic,copy)Nextpage page;
//代理
@property (nonatomic,weak)id<nextPage>mydelegate;

@end
