//
//  FindPageViewController.m
//  HealthyGood
//
//  Created by zhoushuyang on 16/2/24.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "FindPageViewController.h"
#import "FindPageTableViewCell.h"
#import <AFNetworking.h>
#import "ChannalTypeModel.h"
#import "JHRefresh.h"
#import "CacheManger.h"
#import "ChannalContaintViewController.h"
#import "Define.h"
#import "FindModel.h"
#import "HttpEngine.h"

@interface FindPageViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSString *urlStr ;
}
@property (nonatomic,strong)NSMutableArray *dataSouce;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,assign)NSInteger numCell;

@end

@implementation FindPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self customNavagationBar];
    [self loadDataSouce];
    [self creatTableView];
    [self createPullHeaderRefresh];
    [self.tableView headerStartRefresh];
    [self creatTypeButn];
    self.view.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x343434);

}
//添加下拉刷新控件
- (void)createPullHeaderRefresh {
    
    __weak FindPageViewController *weakSelf = self;
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        //延时隐藏refreshView;
        double delayInSeconds = 2.0;
        //创建延期的时间 2S
        dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        //延期执行
        dispatch_after(delayInNanoSeconds, dispatch_get_main_queue(), ^{
            
            [weakSelf.tableView reloadData];
            
            //事情做完了别忘了结束刷新动画~~~
            [weakSelf.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        });
       
    }];
}


//- (void)creatHeadView {
////    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(15,15,3, 25)];
////    view1.backgroundColor = [UIColor colorWithRed:66.0/255.0 green:190.0/255.0 blue:127.0/255.0 alpha:1];
////    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 100, 25)];
////    lable.text = @"频道广场";
////    lable.font = [UIFont systemFontOfSize:15];
////    [self.view addSubview:lable];
////    [self.view addSubview:view1];
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, VIEW_W, 20)];
//    imageView.image =  [UIImage imageNamed:@"guide_more_title"];
//    [self.view addSubview:imageView];
//    
//    
//    
//}


- (void)creatTypeButn {
    NSArray *items = @[@"疾病防治",@"健康保健"];
    UISegmentedControl *sc = [[UISegmentedControl alloc]initWithItems:items];
    sc.frame = CGRectMake(self.view.frame.size.width/2-100, 10, 200, 40);
    //设置颜色
//    sc.backgroundColor = [UIColor yellowColor];
    sc.dk_tintColorPicker = DKColorWithColors([UIColor colorWithRed:66.0/255.0 green:190.0/255.0 blue:127.0/255.0 alpha:1], [UIColor grayColor]);
    //设置字体属性
    //创建属性字典
    NSDictionary *dict = [NSDictionary  dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20],NSFontAttributeName,nil];
    [sc setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    NSDictionary *dict1 = [NSDictionary  dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName,nil];
    [sc setTitleTextAttributes:dict1 forState:UIControlStateNormal];
    
    //添加事件
    [sc addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:sc];
}
- (void)changeValue:(UISegmentedControl *)sender {
    //在这里做事件分发
    
    if (sender.selectedSegmentIndex ==0) {
       
        HttpEngine *manager = [HttpEngine shareEngine];
        
        [manager GET:FindPageUrl parameters:nil success:^(id response) {

             _dataSouce = [NSMutableArray array];
            NSArray *arr= [NSArray arrayWithArray:response[@"channelslist"]];
            
            NSLog( @"channelslist %ld",arr.count);
            
            NSArray *arr1 =   [NSArray arrayWithArray:arr[0][@"channels"]];

            self.dataSouce = [ChannelsModel arrayOfModelsFromDictionaries:arr1 error:nil];
          
            [self.tableView reloadData];
            

            
        } failed:^(NSError *error) {
            
        }];


    }else {
        HttpEngine *manager = [HttpEngine shareEngine];
        
        [manager GET:FindPageUrl parameters:nil success:^(id response) {
            
            _dataSouce = [NSMutableArray array];
            NSArray *arr= [NSArray arrayWithArray:response[@"channelslist"]];
            NSArray *arr1 =   [NSArray arrayWithArray:arr[1][@"channels"]];

            self.dataSouce = [ChannelsModel arrayOfModelsFromDictionaries:arr1 error:nil];
            
            [self.tableView reloadData];
          
            
            
        } failed:^(NSError *error) {
            
        }];
        

    }
    
    
    
}





- (void)creatTableView {
    
    //创建TableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width-15, VIEW_H-64-50-44) style:UITableViewStylePlain];
    _tableView.delegate   = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x343434);
//    _tableView.dk_separatorColorPicker = DKColorWithRGB(0xaaaaaa, 0x313131);
    //注册
    UINib *nib = [UINib nibWithNibName:@"FindPageTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cellID"];
    
    
    [self.view addSubview:_tableView];
}

//加载数据源

- (void)loadDataSouce {
    
    _dataSouce = [NSMutableArray array];
    HttpEngine *manager = [HttpEngine shareEngine];
    
    [manager GET:FindPageUrl parameters:nil success:^(id response) {
        
        
        NSArray *arr= [NSArray arrayWithArray:response[@"channelslist"]];
        NSArray *arr1 =   [NSArray arrayWithArray:arr[0][@"channels"]];
        NSArray *arr2 =    [NSArray arrayWithArray:arr[1][@"channels"]];
        NSMutableArray *marr = [NSMutableArray array];
        [marr addObjectsFromArray:arr1];
        [marr addObjectsFromArray:arr2];
        self.dataSouce = [ChannelsModel arrayOfModelsFromDictionaries:marr error:nil];
        

        
        [self.tableView reloadData];
        

    } failed:^(NSError *error) {
        
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSouce.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FindPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    cell.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x343434);
    
    ChannelsModel *model = self.dataSouce[indexPath.row];
    [cell configeData:model];
    return cell;
}
- (void)customNavagationBar {
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorWithColors([UIColor colorWithRed:66.0/255.0 green:190.0/255.0 blue:127.0/255.0 alpha:1], [UIColor grayColor]);
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    lable.text = @"频道广场";
    lable.font = [UIFont systemFontOfSize:20 weight:5];
    lable.dk_textColorPicker= DKColorWithColors([UIColor whiteColor],[UIColor colorWithRed:52/255.0 green:52/255.0 blue:52/255.0 alpha:1]);

    lable.textAlignment = NSTextAlignmentLeft  ;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:lable];
    
//    UIButton *butn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
//    [butn setTitle:@"频道搜索" forState:UIControlStateNormal];
//    butn.tintColor = [UIColor whiteColor];
//    butn.titleLabel.font = [UIFont systemFontOfSize:20 weight:5];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:butn];
//    
//    UIButton *butn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    butn1.frame = CGRectMake(0, 0, 230, 26);
//    butn1.backgroundColor = [UIColor whiteColor];
//    butn1.layer.cornerRadius = 11;
//    butn1.clipsToBounds = YES;
//    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:butn1];
    self.navigationItem.leftBarButtonItems = @[item];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ChannalContaintViewController *ChannalVC = [[ChannalContaintViewController alloc]init];
    ChannalTypeModel *model = self.dataSouce[indexPath.row];
    ChannalVC.urlstring = model.id;
//    NSLog(@"%@",model.id);
    ChannalVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ChannalVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 59;
}



@end
