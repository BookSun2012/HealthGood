//
//  FirstCell.h
//  HealthyGood
//
//  Created by zhoushuyang on 16/3/8.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannalContaintModel.h"
@interface FirstCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *firstLable;
- (void)configerData:(Result*)model  and:(ChannalContaintModel *)model2;
@end
