//
//  FirstContaintCell.h
//  HealthyGood
//
//  Created by zhouhsuyang on 16/2/27.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannalContaintModel.h"
#import "HeadModel.h"
@interface FirstContaintCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
- (void)configerData:(Result*)model  and:(ChannalContaintModel *)model2;

- (void)configerData:(Result1 *)model;


@end
