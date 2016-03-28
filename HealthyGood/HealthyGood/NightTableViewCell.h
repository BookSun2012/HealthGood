//
//  NightTableViewCell.h
//  HealthyGood
//
//  Created by Qianfeng on 16/3/10.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NightTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;

@end
