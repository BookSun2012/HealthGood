//
//  FindPageTableViewCell.m
//  HealthyGood
//
//  Created by zhoushuyang on 16/2/26.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "FindPageTableViewCell.h"
#import <DKNightVersion.h>
#import "ZSYDataBaseManager.h"
@implementation FindPageTableViewCell

- (void)awakeFromNib {
    [self customSelectButn];
}
- (IBAction)selectButn:(id)sender {
        ZSYDataBaseManager *dataManager = [ZSYDataBaseManager defaultManager];
        [dataManager insetrDataWithModel:_model];
}



- (void)customSelectButn {
    self.SelectButn.clipsToBounds = YES;
    self.SelectButn.layer.cornerRadius = 10;
    self.SelectButn.layer.borderWidth = 1;
    self.SelectButn.layer.borderColor = [[UIColor colorWithRed:66.0/255.0 green:190.0/255.0 blue:127.0/255.0 alpha:1] CGColor];
}

- (void)configeData:(ChannelsModel *)model{
    _model = model;
    self.Type.text = model.name;
    self.bookCount.text = model.bookcount;
    
    
    self.Type.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor grayColor]);
    self.bookCount.dk_textColorPicker = DKColorWithColors([UIColor colorWithRed:24/255.0 green:24/255.0 blue:24/255.0 alpha:1], [UIColor grayColor]);

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
