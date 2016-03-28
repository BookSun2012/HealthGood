//
//  SecondCell.m
//  HealthyGood
//
//  Created by Qianfeng on 16/3/8.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "SecondCell.h"
#import <UIImage+WebP.h>
#import "NSString+AttributeStyle.h"
#import <AFNetworking.h>
@implementation SecondCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)configerData:(Result *)model and:(ChannalContaintModel *)model2{
    
    UIColor *color = [UIColor colorWithRed:66.0/255.0 green:190.0/255.0 blue:127.0/255.0 alpha:1];
    NSRange redRange = NSMakeRange([model.title rangeOfString:model2.channel_name].location, [model.title rangeOfString:model2.channel_name].length);
    self.secondLable.attributedText = [model.title creatAttributeStringWithStyle:@[[AttributedStyle attributeName:NSForegroundColorAttributeName value:color range:redRange] ]];
    
    
    //图片加载
    NSString *str = @"http://i3.go2yd.com/image.php?type=webp_180x120&url=%@&net=wifi";
    NSString *strurl = [NSString stringWithFormat:str,model.image_urls[0]];
    
    strurl = [strurl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [ AFHTTPResponseSerializer serializer];
    
    [manager GET:strurl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.secondimageView setImage:[UIImage imageWithWebPData:responseObject]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
