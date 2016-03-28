//
//  NightTableViewCell.m
//  HealthyGood
//
//  Created by Qianfeng on 16/3/10.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "NightTableViewCell.h"
#import <DKNightVersion.h>
@implementation NightTableViewCell

- (void)awakeFromNib {
    self.mySwitch.dk_thumbTintColorPicker = DKColorWithColors([UIColor whiteColor], [UIColor grayColor]);
}
- (IBAction)SwitchChanged:(UISwitch *)sender {
    if (sender.on&&[DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
        [DKNightVersionManager dawnComing];
        NSLog(@"夜间模式开启");
    }else {
        NSLog(@"日间模式开启");
        [DKNightVersionManager nightFalling];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
