//
//  FirstContaintCell.m
//  HealthyGood
//
//  Created by zhoushuyang on 16/2/27.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "FirstContaintCell.h"
#import <CoreText/CoreText.h>
#import "NSString+AttributeStyle.h"
#import <DKNightVersion.h>
@implementation FirstContaintCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)configerData:(Result *)model and:(ChannalContaintModel *)model2 {
    
    UIColor *color = [UIColor colorWithRed:66.0/255.0 green:190.0/255.0 blue:127.0/255.0 alpha:1];
    
    NSRange redRange = NSMakeRange([model.title rangeOfString:model2.channel_name].location, [model.title rangeOfString:model2.channel_name].length);

    self.titleLable.attributedText = [model.title creatAttributeStringWithStyle:@[[AttributedStyle attributeName:NSForegroundColorAttributeName value:color range:redRange] ]];
    
}

- (void)configerData:(Result1 *)model {
    self.titleLable.text = model.title;
    self.titleLable.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor grayColor]);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
