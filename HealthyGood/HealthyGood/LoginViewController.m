//
//  LoginViewController.m
//  HealthyGood
//
//  Created by Qianfengzhoushuyang on 16/3/5.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "LoginViewController.h"
#import "Define.h"
@interface LoginViewController ()
@property (nonatomic,strong)UIImageView *imageView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatImageView];
    [self creatBackButn];
    [self loginButn];
//    self.edgesForExtendedLayout = YES;
   
    
}
- (void)creatBackButn {
    UIButton *butn = [UIButton buttonWithType:UIButtonTypeCustom];
    butn.frame = CGRectMake(15, 30, 8, 15);
    [butn setBackgroundImage:[UIImage imageNamed:@"btn_back_white_nt"] forState:UIControlStateNormal];
    [butn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:butn];
}
- (void)back:(UIButton *)butn {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)creatImageView {
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,VIEW_W, 350)];
    _imageView.userInteractionEnabled = YES;
    _imageView.contentMode =  UIViewContentModeScaleAspectFill;
    _imageView.image = [UIImage imageNamed:@"register_welcome_banner"];
    [self.view addSubview:_imageView];
    
}

- (void)loginButn{
    UIButton *butn = [UIButton buttonWithType:UIButtonTypeSystem];
    butn.frame = CGRectMake(50, 400, VIEW_W-100, 40);
    butn.backgroundColor = [UIColor blueColor];
    [butn setTitle:@"手机号注册" forState:UIControlStateNormal];
    [butn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:butn];
    
    UIButton *butn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    butn1.frame = CGRectMake(50, 450, VIEW_W-100, 40);
    [butn1 setTitle:@"手机号登录" forState:UIControlStateNormal];
    butn1.layer.borderWidth = 1;
    [butn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    butn1.layer.borderColor = [[UIColor blueColor] CGColor];
    [self.view addSubview:butn1];
    
    
    UILabel *lable = [[UILabel alloc]init];
    lable.text = @"其他方式";
    lable.frame = CGRectMake(30, 560, 80, 30);
    [self.view addSubview:lable];
    
    
    
    UIButton *butn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    butn2.frame = CGRectMake(160, 550, 40, 40);
    [butn2 setBackgroundImage:[UIImage imageNamed:@"register_weibo_big_icon"] forState:UIControlStateNormal];
    [self.view addSubview:butn2];
    
    UIButton *butn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    butn3.frame = CGRectMake(260, 550, 40, 40);
    [butn3 setBackgroundImage:[UIImage imageNamed:@"register_yidian_big_icon"] forState:UIControlStateNormal];
    [self.view addSubview:butn3];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
