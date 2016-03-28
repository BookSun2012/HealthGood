//
//  MyPageViewController.m
//  HealthyGood
//
//  Created by Qianfeng on 16/2/24.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "MyPageViewController.h"
#import "SetTableViewCell.h"
#import "LoginViewController.h"
#import "NightTableViewCell.h"
#import <DKNightVersion.h>
#import "MyFavoriteViewController.h"
#import "MystationViewController.h"
@interface MyPageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *dataSouce;
@property (nonatomic,strong)NSMutableArray *imageNameArr;
@property (nonatomic,strong)NSMutableArray *titleNameArr;
@end

@implementation MyPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatImageView];
    [self creatDataSouce];
    [self creatTableView];
    
}

- (void)creatImageView {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,VIEW_W, 0.3*VIEW_H)];
    imageView.image = [UIImage imageNamed:@"personal_cover_bg.jpg"];
    imageView.contentMode =  UIViewContentModeScaleToFill;
    imageView.userInteractionEnabled = YES;
    imageView.tag = 100;
    
    //渐变色
    UIImageView *imageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide_channel_name_mask"]];
    imageView1.frame = CGRectMake(0, 0.3*VIEW_H-100, VIEW_W, 100);
    imageView1.userInteractionEnabled = YES;
    [imageView addSubview:imageView1];
    
    
    [self.view addSubview:imageView];
    [self creatLoginButn];

}

#pragma -mark Cell
- (void)creatDataSouce {
    _dataSouce = [NSArray array];
    _imageNameArr = [NSMutableArray array];
    _titleNameArr = [NSMutableArray array];
    NSString *plistpath = [[NSBundle mainBundle]pathForResource:@"Set" ofType:@"plist"];
    _dataSouce = [NSArray arrayWithContentsOfFile:plistpath];
    NSLog(@"%ld",self.dataSouce.count);
    for (NSDictionary *dic in _dataSouce) {
        NSString *icon = dic[@"icon"];
        NSString *title = dic[@"title"];
        [_imageNameArr addObject:icon];
        [_titleNameArr addObject:title];
    }
    
}
- (void)creatTableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0.3*VIEW_H,VIEW_W,VIEW_H) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled =  NO;
    _tableView.tableFooterView = nil;
    _tableView.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x343434);
    _tableView.dk_separatorColorPicker = DKColorWithRGB(0xaaaaaa, 0x313131);
    [_tableView registerNib:[UINib nibWithNibName:@"SetTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    [_tableView registerNib:[UINib nibWithNibName:@"NightTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID1"];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSouce.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if ([_titleNameArr[indexPath.row] isEqualToString:@"夜间模式"]) {
       NightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID1"];
        cell.headImageView.image = [UIImage imageNamed:_imageNameArr[indexPath.row]];
        cell.titleLable.text = _titleNameArr[indexPath.row];
        cell.titleLable.dk_textColorPicker =DKColorWithColors([UIColor blackColor], [UIColor grayColor]);
        cell.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x343434);
        return cell;
    }else {
        SetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        cell.headImageView.image = [UIImage imageNamed:_imageNameArr[indexPath.row]];
        cell.titleLable.text = _titleNameArr[indexPath.row];
        cell.titleLable.dk_textColorPicker =DKColorWithColors([UIColor blackColor], [UIColor grayColor]);
        cell.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x343434);
        //cell 的附加视图为系统类型
        //cell.accessoryView = 定制附加视图
        //cell.accessoryType 系统类型
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            MyFavoriteViewController *MFVC = [[MyFavoriteViewController alloc]init];
            [self.navigationController pushViewController:MFVC animated:YES];
            MFVC.hidesBottomBarWhenPushed = YES;
        }
            break;
        case 1:{
            MystationViewController *SVC = [[MystationViewController alloc]init];
            [self.navigationController pushViewController:SVC animated:YES];
            SVC.hidesBottomBarWhenPushed = YES;
        }
            break;
        default:
            break;
    }
}


//附加视图按钮被点击后触发此方法
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"附加视图按钮被点击");
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
    
}


#pragma -mark 登录
- (void)creatLoginButn {
    UIImageView *View = (UIImageView *)[self.view viewWithTag:100];
    UIButton *loginButn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButn.frame = CGRectMake(0, 0, 60, 60);
    loginButn.center = View.center;
    loginButn.layer.cornerRadius = 30;
    loginButn.clipsToBounds = YES;
    loginButn.layer.borderWidth = 3;
    loginButn.layer.dk_borderColorPicker = DKColorWithColors([UIColor whiteColor], [UIColor grayColor]);
    loginButn.layer.borderColor = [[UIColor whiteColor] CGColor];
    [loginButn addTarget: self action:@selector(loginPress:) forControlEvents:UIControlEventTouchUpInside];
    [loginButn setBackgroundImage:[UIImage imageNamed:@"profile_default"] forState:UIControlStateNormal];
    loginButn.tag = 201;

    
    UIButton *textbutn = [UIButton buttonWithType:UIButtonTypeCustom];
    textbutn.frame = CGRectMake(VIEW_W/2-40, 0.3*VIEW_H/2+35, 80, 30);
    [textbutn setTitle:@"点击登录" forState:UIControlStateNormal];
    [textbutn dk_setTitleColorPicker:DKColorWithColors([UIColor whiteColor],[UIColor grayColor]) forState:UIControlStateNormal];
    textbutn.titleLabel.font = [UIFont systemFontOfSize:20];
    [View addSubview:textbutn];
//    UILabel *lable = [[UILabel alloc]init];
//    lable.frame = CGRectMake(VIEW_W/2-40, 0.3*VIEW_H/2+35, 80, 30);
//    lable.text = @"点击登录";
//    lable.textColor = [UIColor whiteColor];
//    lable.font = [UIFont systemFontOfSize:20];
//    [View addSubview:lable];
    [View addSubview:loginButn];
}
- (void)loginPress:(UIButton *)sender{
    NSLog(@"login按钮被点击");
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    loginVC.hidesBottomBarWhenPushed = YES;
    loginVC.view.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x343434);
    [self.navigationController pushViewController:loginVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
