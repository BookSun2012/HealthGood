//
//  HeadBaseViewController.m
//  HealthyGood
//
//  Created by Qianfeng on 16/2/26.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "HeadBaseViewController.h"
#import "HeadPageTableViewCell.h"
#import <AFNetworking.h>
#import "HttpEngine.h"
#import "Define.h"
#import "HeadModel.h"
#import "FirstContaintCell.h"
#import "SecondContaintCell.h"
#import "ThirdContaintCell.h"
#import "ChannalCellDetailViewController.h"
#import "ChannalContaintModel.h"



@interface HeadBaseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSouce;
@property (nonatomic,strong)Result1 *resoutModel;

@end

@implementation HeadBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeUrl:) name:@"changeUrl" object:nil];
    
    [self creatDataSouce];
}

- (void)changeUrl:(NSNotification *)sender {
    NSLog(@"%@",sender.userInfo);
    self.nextUrl = [sender.userInfo objectForKey:@"url"];
    
    NSString *url = self.nextUrl;
    
    
    
}

- (void)creattableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"FirstContaintCell" bundle:nil] forCellReuseIdentifier:@"cellID1"];
    [_tableView registerNib:[UINib nibWithNibName:@"SecondContaintCell" bundle:nil] forCellReuseIdentifier:@"cellID2"];
    [_tableView registerNib:[UINib nibWithNibName:@"ThirdContaintCell" bundle:nil] forCellReuseIdentifier:@"cellID3"];
    _tableView.estimatedRowHeight = 44;
    
    [self.view addSubview:_tableView];
}
- (void)creatDataSouce {
    

    
    _dataSouce = [[NSMutableArray alloc]init];
    HttpEngine *enger = [HttpEngine shareEngine];
    NSString *troueurl = [NSString stringWithFormat:HeadNextUrl,_nextUrl];
    
    [enger GET:HeadViewURL parameters:nil success:^(id response) {
        NSError *error = nil;
        _dataSouce = [Result1 arrayOfModelsFromDictionaries:response[@"result"] error:&error];
        NSLog(@"HeadView 转换失败 :%@",error);
        [self creattableView];
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSouce.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Result1 *model1 = self.dataSouce[indexPath.row];
    if ([model1.image_urls count]==0) {
        
        FirstContaintCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID1" ];
        [cell configerData:model1];
        return cell;
        
    }else if ([model1.image_urls count]==1){
        FirstContaintCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID2"];
        [cell configerData:model1 ] ;
        return cell;
        
    }else{
        
        FirstContaintCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID3"];
        [cell configerData:model1 ];
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChannalCellDetailViewController *detailVC = [[ChannalCellDetailViewController alloc]init];
    self.resoutModel = self.dataSouce[indexPath.row];
    detailVC.doceID =self.resoutModel.docid;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
