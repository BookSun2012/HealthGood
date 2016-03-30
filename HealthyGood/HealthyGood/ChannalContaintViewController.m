//
//  ChannalContaintViewController.m
//  HealthyGood
//
//  Created by zhoushuyang on 16/2/26.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "ChannalContaintViewController.h"

#import "FirstCell.h"
#import "SecondCell.h"
#import "ThirdCell.h"

#import <AFNetworking.h>
#import "ChannalContaintModel.h"
#import "Define.h"
#import <UIImageView+WebCache.h>
#import "ChannalCellDetailViewController.h"
#import "HttpEngine.h"
#import <UMSocial.h>
#import "ZSYDataBaseManager.h"
@interface ChannalContaintViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSouce;
@property (nonatomic,strong)ChannalContaintModel *model;
@property (nonatomic,strong)Result *resultModel;
@end

@implementation ChannalContaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self loadDataSocue];
   }

- (void)loadDataSocue {
    
#if 0
    NSString *url = FindContaintUrl;
    url = [url stringByAppendingFormat:url,self.urlstring];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url1 = [NSURL URLWithString:url];
    // 构造Session 初始化单利
    NSURLSession *session = [NSURLSession sharedSession];
    //创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url1];
    //设置请求头内容
    [request setValue:JSONID forHTTPHeaderField:COKIE];
    
    
    NSURLSessionTask *sessionDatatask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //数据下载完成
        if (error == nil) {
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@",responseObject);
            ChannalContaintModel *containtsModel = [[ChannalContaintModel alloc]init];
            self.model = containtsModel;
            containtsModel.fresh_count = (long)responseObject[@"fresh_count"];
            containtsModel.channel_image = responseObject[@"channel_image"];
            containtsModel.channel_name = responseObject[@"channel_name"];
            containtsModel.channel_type = responseObject[@"channel_type"];
            
            self.dataSouce = [Result arrayOfModelsFromDictionaries:responseObject[@"result"] error:&error];
            NSLog(@"%ld",self.dataSouce.count);
            [self creatTableView ];
            [self creatImageView];
            
            [self.tableView reloadData];
            
            
        }
        NSLog(@"%@",error);

    }];
       //启动下载
    [sessionDatatask resume];
#else

    NSString *url = FindContaintUrl;
    url = [NSString stringWithFormat:url,self.urlstring];
    NSLog(@"%@",url);
    //url  = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    HttpEngine *manager = [HttpEngine shareEngine];
    [manager GET:url parameters:nil success:^(id response) {
        ChannalContaintModel *containtsModel = [[ChannalContaintModel alloc]init];
        self.model = containtsModel;
        containtsModel.fresh_count = (long)response[@"fresh_count"];
        containtsModel.channel_image = response[@"channel_image"];
        containtsModel.channel_name = response[@"channel_name"];
        containtsModel.channel_type = response[@"channel_type"];
         NSError *error = nil;
        self.dataSouce = [Result arrayOfModelsFromDictionaries:response[@"result"] error:&error];
        [self creatTableView ];
        [self creatImageView];
        
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];
#endif
}

- (void)creatTableView {
//创建
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
//代理
    _tableView.delegate = self;
    _tableView.dataSource = self;
//注册
    
    [_tableView registerNib:[UINib nibWithNibName:@"FirstCell" bundle:nil] forCellReuseIdentifier:@"cellID1"];
    [_tableView registerNib:[UINib nibWithNibName:@"SecondCell" bundle:nil] forCellReuseIdentifier:@"cellID2"];
    [_tableView registerNib:[UINib nibWithNibName:@"ThirdCell" bundle:nil] forCellReuseIdentifier:@"cellID3"];
  
    _tableView.showsVerticalScrollIndicator = NO;
    
    
//添加头视图
//    _tableView.tableHeaderView.tag = 100;
//    _tableView.tableHeaderView = [self creatImageView];
     _tableView.tableHeaderView = [self creatHeadView];
// 设定预估高度
    _tableView.estimatedRowHeight = 44;
    _tableView.bounces = NO;
    
//添加
    [self.view addSubview:_tableView];
}
//内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (UIView *)creatHeadView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_W, 170)];
    view.tag = 100;

    return view;
}
//在头视图上面添加按钮
- (void)creatImageView {
    //头视图
    UIImageView  *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, VIEW_W, 170)];
    imageView.userInteractionEnabled = YES;
    imageView.contentMode =  UIViewContentModeScaleToFill;
    NSURL *url = [NSURL URLWithString:self.model.channel_image];
    [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
    UIView *view = [self.view viewWithTag:100];
    


    //渐变色
    UIImageView *imageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide_channel_name_mask"]];
    imageView1.frame = CGRectMake(0, 100, VIEW_W, 70);
    imageView1.userInteractionEnabled = YES;
    //频道
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 100, 30)];
    lable.text = self.model.channel_name;
    NSLog(@"%@",lable);
    lable.textColor = [UIColor whiteColor];
    lable.font = [UIFont systemFontOfSize:20 weight:0.5];
    
    
    UIButton *subscribeButn = [UIButton buttonWithType:UIButtonTypeCustom];
    subscribeButn.frame  = CGRectMake(220, 29, 70, 25);
    subscribeButn.layer.cornerRadius = 12.5;
    subscribeButn.clipsToBounds = YES;
    subscribeButn.layer.borderWidth = 1;
    subscribeButn.layer.borderColor = [[UIColor whiteColor] CGColor];
    [subscribeButn addTarget:self action:@selector(subscribeButnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *sharButn = [UIButton buttonWithType:UIButtonTypeCustom];
    sharButn.frame  = CGRectMake(300, 29, 65, 25);
    sharButn.layer.cornerRadius = 12.5;
    sharButn.clipsToBounds = YES;
    sharButn.layer.borderWidth = 1;
    sharButn.layer.borderColor = [[UIColor whiteColor] CGColor];
    [sharButn addTarget:self action:@selector(sharButnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *subimageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"explore_ch_icon_add"]];
    subimageView.frame = CGRectMake(10, 2.5, 20, 20);
    [subscribeButn addSubview:subimageView];
    
    UILabel *subLable = [[UILabel alloc]initWithFrame:CGRectMake(33,1, 40, 25)];
    subLable.text = @"订阅";
    subLable.textColor = [UIColor whiteColor];
    subLable.font = [UIFont systemFontOfSize:15];
    [subscribeButn addSubview:subLable];
    
    UIImageView *sharimageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"explore_ch_icon_share"]];
    sharimageView.frame = CGRectMake(8, 2.5, 20, 20);
    [sharButn addSubview:sharimageView];

    
    UILabel *sharLable = [[UILabel alloc]initWithFrame:CGRectMake(30,1, 40, 25)];
    sharLable.text = @"分享";
    sharLable.textColor = [UIColor whiteColor];
    sharLable.font = [UIFont systemFontOfSize:15];
    [sharButn addSubview:sharLable];
    
    
    [imageView1 addSubview:subscribeButn];
    [imageView1 addSubview:sharButn];
    [view addSubview:imageView];
    [imageView1 addSubview:lable];
    [imageView addSubview:imageView1];
    
    
    
    
    
}
- (void)subscribeButnClick:(UIButton*)butn {
    NSLog(@"订阅按钮被点击");
//    ZSYDataBaseManager *dataManager = [ZSYDataBaseManager defaultManager];
////    dataManager insetrDataWithModel:
}

#pragma mark 分享按钮被点击
- (void)sharButnClick:(UIButton*)butn {
//    [UMSocialConfig  hiddenNotInstallPlatforms:@[]];
    /*
     由于苹果审核政策需求，建议大家对未安装客户端平台进行隐藏，在设置QQ、微信AppID之后调用下面的方法，[UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]]; 这个接口只对默认分享面板平台有隐藏功能，自定义分享面板或登录按钮需要自己处理
     */
    //
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"561cb9cfe0f55ab327002433" shareText:@"我的第一次项目添加分享按钮 http://www.baidu.com" shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatTimeline,UMShareToQQ,UMShareToWechatSession,UMShareToQzone,UMShareToSina,UMShareToAlipaySession,UMShareToEmail,UMShareToSms,UMShareToFacebook,UMShareToWechatFavorite,UMShareToTwitter,UMShareToWhatsapp,nil] delegate:self];
    
    NSLog(@"分享按钮被点击");
    
    
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

#pragma mark - tableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Result *model1 = self.dataSouce[indexPath.row];
    if ([model1.image_urls count]==0) {
        
        FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID1"];
        [cell configerData:model1 and:self.model];
        return cell;
        
    }else if ([model1.image_urls count]==1){
        SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID2"];
        [cell configerData:model1 and:self.model] ;
        return cell;

    }else{
        
        ThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID3"];
        [cell configerData:model1 and:self.model];
        return cell;
        
    }

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ChannalCellDetailViewController *detailVC = [[ChannalCellDetailViewController alloc]init];
    self.resultModel = self.dataSouce[indexPath.row];
    detailVC.doceID =self.resultModel.docid;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSouce.count;
}
#pragma mark - FindPageVIewCointroller Delegate



//视图将要显示的时候
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    [self.tabBarController.tabBar setHidden:YES];
//    
//}

@end
