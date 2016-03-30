//
//  SecondCell.h
//  HealthyGood
//
//  Created by zhoushuyang on 16/3/8.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannalContaintModel.h"
@interface SecondCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *secondLable;
@property (weak, nonatomic) IBOutlet UIImageView *secondimageView;
- (void)configerData:(Result *)model and:(ChannalContaintModel *)model2;
@end
