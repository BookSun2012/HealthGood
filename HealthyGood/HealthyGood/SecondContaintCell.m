//
//  SecondContaintCell.m
//  HealthyGood
//
//  Created by Qianfeng on 16/2/27.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "SecondContaintCell.h"
#import <UIImageView+WebCache.h>
#import <UIImage+WebP.h>
#import "NSString+AttributeStyle.h"
#import <AFNetworking.h>
#import <DKNightVersion.h>
@implementation SecondContaintCell

- (void)awakeFromNib {
    
}

- (void)configerData:(Result *)model and:(ChannalContaintModel *)model2{
    
    UIColor *color = [UIColor colorWithRed:66.0/255.0 green:190.0/255.0 blue:127.0/255.0 alpha:1];
    
    NSRange redRange = NSMakeRange([model.title rangeOfString:model2.channel_name].location, [model.title rangeOfString:model2.channel_name].length);
    
    self.titleLable.attributedText = [model.title creatAttributeStringWithStyle:@[[AttributedStyle attributeName:NSForegroundColorAttributeName value:color range:redRange] ]];
    self.titleLable.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor grayColor]);
    
    
    //图片加载
    NSString *str = @"http://i3.go2yd.com/image.php?type=webp_180x120&url=%@&net=wifi";
    NSString *strurl = [NSString stringWithFormat:str,model.image_urls[0]];

//    NSString *str1 = strurl;
//    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:str1] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    NSLog(@"home:%@",NSHomeDirectory());

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     manager.responseSerializer = [ AFHTTPResponseSerializer serializer];
    
    [manager GET:strurl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    [self.myImageView setImage:[UIImage imageWithWebPData:responseObject]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}

- (void)configerData:(Result1 *)model {
    self.titleLable.text = model.title;
    self.titleLable.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor grayColor]);
    NSString *str = @"http://i3.go2yd.com/image.php?type=webp_180x120&url=%@&net=wifi";
    
    NSString *strurl = [NSString stringWithFormat:str,model.image_urls[0]];
    strurl = [strurl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [ AFHTTPResponseSerializer serializer];
    
    [manager GET:strurl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    [self.myImageView setImage:[UIImage imageWithWebPData:responseObject]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
