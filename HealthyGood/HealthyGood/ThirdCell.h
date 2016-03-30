//
//  ThirdCell.h
//  HealthyGood
//
//  Created by zhoushuyang on 16/3/8.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannalContaintModel.h"
@interface ThirdCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ThirdLable;

@property (weak, nonatomic) IBOutlet UIImageView *thirdimageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdimageView1;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView2;
- (void)configerData:(Result *)model and:(ChannalContaintModel *)model2;
@end
