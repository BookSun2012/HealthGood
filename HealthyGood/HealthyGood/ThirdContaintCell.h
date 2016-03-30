//
//  ThirdContaintCell.h
//  HealthyGood
//
//  Created by zhoushuyang on 16/2/27.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannalContaintModel.h"
#import "HeadModel.h"
@interface ThirdContaintCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIImageView *myImageVIew1;
@property (weak, nonatomic) IBOutlet UIImageView *myImageVIew2;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView3;
- (void)configerData:(Result *)model and:(ChannalContaintModel *)model2;

- (void)configerData:(Result1 *)model;

@end
