//
//  TabBarViewController.m
//  HealthyGood
//
//  Created by Qianfeng on 16/2/24.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "TabBarViewController.h"
#import "HeadPageViewController.h"
#import "FindPageViewController.h"
#import "MyPageViewController.h"

#import <DKNightVersion.h>
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.dk_barTintColorPicker = DKColorWithRGB(0xffffff, 0x444444);
////    self.tabBar.dk_tintColorPicker = DKColorWithColors([UIColor colorWithRed:0 green:188/255.0 blue:29.0 alpha:1.0], [UIColor whiteColor]);
    [self creatViewController];
}

- (void)creatViewController {
    
    HeadPageViewController *hvc = [[HeadPageViewController alloc]init];
    hvc.tabBarItem.title = @"首页";
    hvc.tabBarItem.image = [UIImage imageNamed:@"tabbar_contacts"];
    hvc.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_contactsHL"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UINavigationController *hnava = [[UINavigationController alloc]initWithRootViewController:hvc];

   
    
    FindPageViewController *fvc = [[FindPageViewController alloc]init];
    fvc.tabBarItem.title = @"发现";
    fvc.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
    fvc.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_discoverHL"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *fnava = [[UINavigationController alloc]initWithRootViewController:fvc];
    
    
    

    
    
    MyPageViewController *mvc = [[MyPageViewController alloc]init];
    mvc.tabBarItem.title = @"我";
    mvc.tabBarItem.image = [UIImage imageNamed:@"tabbar_me"];
    mvc.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_meHL"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *mnava = [[UINavigationController alloc]initWithRootViewController:mvc];
    mnava.navigationBar.hidden = YES;
    
    
    
    self.viewControllers = @[hnava,fnava,mnava];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
