//
//  AddChannalTypeController.m
//  HealthyGood
//
//  Created by Qianfeng on 16/2/28.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "AddChannalTypeController.h"
#import "Define.h"
@interface AddChannalTypeController ()
@property (nonatomic,strong)UIView *selfview;
@property (nonatomic,strong)UIView *supportview;
@end

@implementation AddChannalTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self customNagivationItem];
    [self creatSelfView];
    NSLog(@"%@",self.selfChannleSouce);
    
}

- (void)creatSelfView {
    UIView *selfview = [[UIView alloc]initWithFrame:CGRectMake(10, 30,VIEW_W-20 , 200)];
    self.selfview = selfview;
    selfview.backgroundColor = [UIColor purpleColor];
    selfview.layer.cornerRadius = 10;
    selfview.clipsToBounds = YES;
    [self.view addSubview:selfview];
    
    UIView *supportview = [[UIView alloc]initWithFrame:CGRectMake(10,250,VIEW_W-20 , 200)];
    self.supportview = supportview;
    supportview.backgroundColor = [UIColor purpleColor];
    supportview.layer.cornerRadius = 10;
    supportview.clipsToBounds = YES;
    [self.view addSubview:supportview];
    
    [self creatButn];
}
- (void)creatButn {
    UIButton *butn = [UIButton buttonWithType:UIButtonTypeSystem];
    butn.frame = CGRectMake(10, 10, 60, 30);
    butn.layer.cornerRadius = 3;
    butn.clipsToBounds = YES;
    butn.layer.borderWidth = 2;
    butn.layer.borderColor = [[UIColor orangeColor] CGColor];
    [butn setTitle:self.selfChannleSouce[1] forState:UIControlStateNormal];
    butn.backgroundColor =[UIColor whiteColor];
    [butn setTintColor:[UIColor redColor]];
    [self.selfview addSubview:butn];
    
    
//    for (int i=0; i<self.selfChannleSouce.count; i++) {
//        UIButton *butn = [UIButton buttonWithType:UIButtonTypeSystem];
//        
////        butn.frame = CGRectMake(5+25*i,5, 20, 5);
//    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)customNagivationItem {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"频道管理";
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20],NSFontAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attribute];
}

@end
