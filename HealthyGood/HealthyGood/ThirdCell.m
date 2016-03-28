//
//  ThirdCell.m
//  HealthyGood
//
//  Created by Qianfeng on 16/3/8.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "ThirdCell.h"
#import <UIImage+WebP.h>
#import "NSString+AttributeStyle.h"
#import <AFNetworking.h>
@implementation ThirdCell

- (void)awakeFromNib {
   
}
- (void)configerData:(Result *)model and:(ChannalContaintModel *)model2{
    
    UIColor *color = [UIColor colorWithRed:66.0/255.0 green:190.0/255.0 blue:127.0/255.0 alpha:1];
    
    NSRange redRange = NSMakeRange([model.title rangeOfString:model2.channel_name].location, [model.title rangeOfString:model2.channel_name].length);
    
    self.ThirdLable.attributedText = [model.title creatAttributeStringWithStyle:@[[AttributedStyle attributeName:NSForegroundColorAttributeName value:color range:redRange] ]];
 
    
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
        [self.thirdimageView setImage:[UIImage imageWithWebPData:responseObject]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    [manager GET:urlstr2 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.thirdimageView1 setImage:[UIImage imageWithWebPData:responseObject]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    [manager GET:urlstr3 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.thirdImageView2 setImage:[UIImage imageWithWebPData:responseObject]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
