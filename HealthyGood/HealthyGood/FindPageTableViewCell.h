//
//  FindPageTableViewCell.h
//  HealthyGood
//
//  Created by Qianfeng on 16/2/26.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"
@interface FindPageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Type;
@property (weak, nonatomic) IBOutlet UILabel *bookCount;
@property (weak, nonatomic) IBOutlet UIButton *SelectButn;
@property (nonatomic,strong)ChannelsModel *model;
- (void)configeData:(ChannelsModel *)model;
@end
