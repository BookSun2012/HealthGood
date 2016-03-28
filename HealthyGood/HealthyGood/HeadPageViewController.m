//
//  HeadPageViewController.m
//  HealthyGood
//
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "HeadPageViewController.h"
#import <AFNetworking.h>
#import "SearchViewController.h"
#import "HeadPageTableViewCell.h"
#import "HeadBaseViewController.h"
#import "HttpEngine.h"
#import "Define.h"
#import "ChannalTypeModel.h"
#import "AddChannalTypeController.h"
#import "ChannalCellDetailViewController.h"
#import <JSONModel.h>
#import "BaseTableView.h"

@interface HeadPageViewController ()<UIScrollViewDelegate,nextPage>

@property (nonatomic ,strong)UIButton *currentBtn;
@property (nonatomic,strong)NSMutableArray *dataSouce;
@property (nonatomic,assign)NSInteger numButnItem ;
@property (nonatomic,strong)UIScrollView *scrollerView1;
@property (nonatomic,strong)UIScrollView *scrollerView2;
@property (nonatomic,strong)NSMutableArray *channleTypeArray;
@property (nonatomic,strong)NSMutableArray *butnArr;
@property (nonatomic,strong)UIColor *cellTextColor;
@property (nonatomic,strong)NSMutableArray *butnArr1;
@property (nonatomic ,assign) NSInteger flag;
@property (nonatomic,assign) NSInteger scrollView1Flag;

@property (nonatomic,strong)NSMutableArray *channleIDArr;
@property (nonatomic,copy)NSString *channleID;

@end

@implementation HeadPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flag = 100;
    self.scrollView1Flag = 100;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.dk_backgroundColorPicker =  DKColorWithRGB(0xffffff, 0x343434);
    [self customNavagationBar];
    [self creatView];
    [self loadDataSouce1];
    [self creatScroller1];
    
   
}

-(void)creatScroller1{
    _scrollerView1 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,VIEW_W, 42)];
    _scrollerView1.showsHorizontalScrollIndicator = NO;
    _scrollerView1.showsVerticalScrollIndicator   = NO;
    _scrollerView1.bounces                        = NO;
    _scrollerView1.tag = 99;
    _scrollerView1.bounces = NO;
    _scrollerView1.delegate = self;
    _scrollerView1.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], [UIColor grayColor]);
    [self.view addSubview:_scrollerView1];
}
-(void)creatScroller2{
    _scrollerView2 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height)];
    _scrollerView2.showsHorizontalScrollIndicator = NO;
    _scrollerView2.showsVerticalScrollIndicator   = NO;
    _scrollerView2.bounces                        = NO;
    _scrollerView2.pagingEnabled                  = YES;
    _scrollerView2.contentSize = CGSizeMake(20*self.view.frame.size.width, self.view.frame.size.height);
    _scrollerView2.delegate =self;
    _scrollerView2.bounces = NO;
    _scrollerView2.tag = 98;
    _scrollerView1.dk_backgroundColorPicker= DKColorWithRGB(0xffffff, 0x343434);
    [self.view addSubview:_scrollerView2];
    
    static CGFloat x = 0.0;
    for (int i=0; i<_butnArr.count; i++) {

        BaseTableView *tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(x,0,self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStylePlain];
        tableView.mydelegate = self;
//        //block 代理回调
//        ChannalCellDetailViewController *detailVC = [[ChannalCellDetailViewController alloc]init];
//        tableView.page = ^(NSString* doceID){
//            detailVC.doceID = doceID;
//            [self.navigationController pushViewController:detailVC animated:YES];
//        };
        //属性
//        tableView.controller = self;
        tableView.dk_separatorColorPicker = DKColorWithRGB(0xffffff, 0x343434);
        x += self.view.frame.size.width;
        [_scrollerView2 addSubview:tableView];
        tableView.tag = 100+i;
   
    }

}
//代理
- (void)nextPage:(NSString *)doID {
    
    ChannalCellDetailViewController *detailVC = [[ChannalCellDetailViewController alloc]init];
    detailVC.doceID = doID;
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)scrollView:(UIButton *)butn {
    
    NSInteger channleID = butn.tag;
    
    _channleID = _channleIDArr[channleID-100];
    
    NSDictionary *dicUrl = [[NSDictionary alloc]init];
    dicUrl = @{@"url":_channleID};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeUrl" object:nil userInfo:dicUrl];
    //    [[NSNotificationCenter defaultCenter]postNotificationName:@"changerUrl" object:_channleID];
       
    UIButton *oldButn = (UIButton *)[self.scrollerView1 viewWithTag:self.flag];
    oldButn.selected = NO;
    butn.selected = YES;
    self.flag = butn.tag;
    [self.scrollerView2 setContentOffset:CGPointMake(VIEW_W*(butn.tag-100), 0) animated:YES];
}



- (void)creatButn {
    //创建滑动按钮
    CGFloat padding= 10;
    _butnArr =[NSMutableArray array];
    _butnArr1 = [[NSMutableArray alloc]init];
    _channleIDArr = [[NSMutableArray alloc]init];
    ChannalTypeModel *model = [[ChannalTypeModel alloc]init];
    for (int i=0; i<self.dataSouce.count; i++) {
        model = self.dataSouce[i];
       
        [_butnArr1 addObject:model.name];
        [_channleIDArr addObject:model.channel_id];
    }
    
    [_butnArr1 insertObject:@"推荐" atIndex:0];
    
    NSLog(@"%@",_butnArr1);
    
    for (int i=0; i<_butnArr1.count; i++) {
        //创建Butn
        UIButton *butn = [UIButton buttonWithType:UIButtonTypeCustom];
        [butn setTitle:_butnArr1[i] forState:UIControlStateNormal];
        butn.titleLabel.font = [UIFont systemFontOfSize:15];
        [butn dk_setTitleColorPicker:DKColorWithColors([UIColor colorWithRed:66.0/255.0 green:190.0/255.0 blue:127.0/255.0 alpha:1],[UIColor grayColor]) forState:UIControlStateNormal];
        
        //设置Butn的Frame
        static CGFloat originX = 0;
        CGRect frame = CGRectMake(originX+padding, 0, butn.intrinsicContentSize.width, 42);
        butn.frame  = frame;
        originX    = CGRectGetMaxX(frame) + padding;
        
        //添加事件
        [butn addTarget:self action:@selector(scrollView:) forControlEvents:UIControlEventTouchUpInside];
        //添加tag 值
        if (0 == i) {
            butn.selected = YES;
        }
        butn.tag = 100+i;
        
        [_scrollerView1 addSubview:butn];
        [_butnArr addObject:butn];
    }
    _scrollerView1.contentSize = CGSizeMake(CGRectGetMaxX([self.butnArr.lastObject frame]) + padding, 42);
}


//  请求数据
- (void)loadDataSouce1 {
    _dataSouce  = [NSMutableArray array];
    HttpEngine *manager = [HttpEngine shareEngine];
    [manager GET:HeadChannalURL parameters:nil success:^(id response) {
        self.dataSouce = [ChannalTypeModel arrayAppModelWithResponse:response];
        NSLog(@"%@",response[@"user_channels"]);
        NSLog(@"%ld",self.dataSouce.count);
        //创建Butn
        [self creatButn];
        [self creatScroller2];
        
    } failed:^(NSError *error) {
        
    }];
 
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ( scrollView.tag == 99 ) {
        UIButton *oldBtn = (UIButton *)[self.scrollerView1 viewWithTag:self.flag];
        oldBtn.selected = NO;
        //        UIButton *newBtn = oldBtn.tag+1
        UIButton *newBtn = (UIButton *)[self.scrollerView1 viewWithTag:(scrollView.contentOffset.x - scrollView.frame.size.width)/scrollView.frame.size.width+1+100];
        newBtn.selected = YES;
        self.flag = newBtn.tag;
        NSInteger sub = newBtn.tag - self.scrollView1Flag;
        if (sub >= 7) {
            [self.scrollerView1 setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width/7*(newBtn.tag-100-7+1), 0) animated:YES];
            self.scrollView1Flag += sub-7+1;
        }
        if (sub <= -1) {
            [self.scrollerView1  setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width/7*(newBtn.tag-100), 0) animated:YES];
            self.scrollView1Flag += sub;
        }
    }
}


- (void)searchButn:(UIButton *)butn {
//    UIButton *searchButn = (UIButton *)[self.view viewWithTag:100];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"group_search"]];
    imageView.frame = CGRectMake(15, 6.5, 15,15);
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(35, 6.5,150, 15)];
    lable.text = @" 大家都在搜 : 夏季饮食";
    lable.font = [UIFont systemFontOfSize:12];
    lable.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], [UIColor colorWithRed:52/255.0 green:52/255.0 blue:52/255.0 alpha:1]);
    lable.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor grayColor]);

    [butn addSubview:lable];
    [butn addSubview:imageView];
    
    
    
}



- (void)supportButnClick:(UIButton *)supportClick{
    NSLog(@"%@",supportClick.titleLabel.text);
}
- (void)creatView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 42, self.view.frame.size.width, 2)];
    view.dk_backgroundColorPicker = DKColorWithColors([UIColor colorWithRed:66.0/255.0 green:190.0/255.0 blue:127.0/255.0 alpha:1], [UIColor grayColor]);

    [self.view addSubview:view];
}
- (void)customNavagationBar {
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorWithColors([UIColor colorWithRed:66.0/255.0 green:190.0/255.0 blue:127.0/255.0 alpha:1], [UIColor grayColor]);
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    lable.text = @"健康养生";
    lable.font = [UIFont systemFontOfSize:20 weight:5];
    lable.dk_textColorPicker= DKColorWithColors([UIColor whiteColor],[UIColor colorWithRed:52/255.0 green:52/255.0 blue:52/255.0 alpha:1]);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:lable];
    
    UIButton *butn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    butn1.frame = CGRectMake(0, 0, 230, 26);
    butn1.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor],[UIColor colorWithRed:52/255.0 green:52/255.0 blue:52/255.0 alpha:1]);
    butn1.layer.cornerRadius = 11;
    butn1.tag = 100;
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:butn1];
    self.navigationItem.leftBarButtonItems = @[item,item1];
    [butn1 addTarget:self action:@selector(tapSearch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self searchButn:butn1];
}
- (void)tapSearch:(UIButton *)butn {
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    UIBarButtonItem *item = [[ UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"article_pic_back_h" ] style:UIBarButtonItemStylePlain target:self action:nil];
    searchVC.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:searchVC animated:NO];
    searchVC.view.backgroundColor = [UIColor whiteColor];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
