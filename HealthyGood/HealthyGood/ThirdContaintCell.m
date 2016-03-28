//
//  ThirdContaintCell.m
//  HealthyGood
//
//  Created by Qianfeng on 16/2/27.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "ThirdContaintCell.h"
#import <UIImageView+WebCache.h>
#import "NSString+AttributeStyle.h"
#import <UIImage+WebP.h>
#import <AFNetworking.h>
#import <DKNightVersion.h>

@implementation ThirdContaintCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)configerData:(Result *)model and:(ChannalContaintModel *)model2{
    
    UIColor *color = [UIColor colorWithRed:66.0/255.0 green:190.0/255.0 blue:127.0/255.0 alpha:1];
    
    NSRange redRange = NSMakeRange([model.title rangeOfString:model2.channel_name].location, [model.title rangeOfString:model2.channel_name].length);
    
    self.titleLable.attributedText = [model.title creatAttributeStringWithStyle:@[[AttributedStyle attributeName:NSForegroundColorAttributeName value:color range:redRange] ]];
    self.titleLable.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor grayColor]);
    
    NSString *str = @" http://i3.go2yd.com/image.php?type=webp_180x120&url=%@&net=wifi";
    NSString *urlstr1 = [NSString stringWithFormat:str,model.image_urls[0]];
    NSString *urlstr2 = [NSString stringWithFormat:str,model.image_urls[1]];
    NSString *urlstr3 = [NSString stringWithFormat:str,model.image_urls[2]];
    
    
//    [self.myImageVIew1 sd_setImageWithURL:[NSURL URLWithString:urlstr1] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    [self.myImageVIew2 sd_setImageWithURL:[NSURL URLWithString:urlstr2] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    [self.myImageView3 sd_setImageWithURL:[NSURL URLWithString:urlstr3] placeholderImage:[UIImage imageNamed:@"placeholder"]];

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [ AFHTTPResponseSerializer serializer];
    
    
    [manager GET:urlstr1 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.myImageVIew1 setImage:[UIImage imageWithWebPData:responseObject]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
    [manager GET:urlstr2 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.myImageVIew2 setImage:[UIImage imageWithWebPData:responseObject]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
    [manager GET:urlstr3 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.myImageView3 setImage:[UIImage imageWithWebPData:responseObject]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];


    
    
    
    
}

- (void)configerData:(Result1 *)model {
    
    self.titleLable.text = model.title;
    self.titleLable.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor grayColor]);
    
    
    NSString *str = @"http://i3.go2yd.com/image.php?type=webp_180x120&url=%@&net=wifi";
    NSString *urlstr1 = [NSString stringWithFormat:str,model.image_urls[0]];
    NSString *urlstr2 = [NSString stringWithFormat:str,model.image_urls[1]];
    NSString *urlstr3 = [NSString stringWithFormat:str,model.image_urls[2]];
     urlstr1 = [urlstr1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    urlstr2 = [urlstr2 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    urlstr3 = [urlstr3 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [ AFHTTPResponseSerializer serializer];
    [manager GET:urlstr1 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.myImageVIew1 setImage:[UIImage imageWithWebPData:responseObject]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    [manager GET:urlstr2 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.myImageVIew2 setImage:[UIImage imageWithWebPData:responseObject]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    [manager GET:urlstr3 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.myImageView3 setImage:[UIImage imageWithWebPData:responseObject]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
