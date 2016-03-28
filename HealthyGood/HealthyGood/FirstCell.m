//
//  FirstCell.m
//  HealthyGood
//
//  Created by Qianfeng on 16/3/8.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "FirstCell.h"
#import "NSString+AttributeStyle.h"
@implementation FirstCell

- (void)awakeFromNib {
    [self initUI];
}
- (void)initUI{

}
- (void)layoutSubviews {

}
- (void)configerData:(Result *)model and:(ChannalContaintModel *)model2 {
    
    UIColor *color = [UIColor colorWithRed:66.0/255.0 green:190.0/255.0 blue:127.0/255.0 alpha:1];
    
    NSRange redRange = NSMakeRange([model.title rangeOfString:model2.channel_name].location, [model.title rangeOfString:model2.channel_name].length);
    
    self.firstLable.attributedText = [model.title creatAttributeStringWithStyle:@[[AttributedStyle attributeName:NSForegroundColorAttributeName value:color range:redRange] ]];
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
