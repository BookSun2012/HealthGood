//
//  SearchViewController.m
//  HealthyGood
//
//  Created by zhoushuyang on 16/2/25.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "SearchViewController.h"
#import "HttpEngine.h"
#import "Define.h"
#import "ChannalTypeModel.h"

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating>
@property (nonatomic,strong)NSMutableArray *dataSouce;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *arr;
@property (nonatomic,strong)NSMutableArray *saveSouce;
@property (nonatomic,strong) UISearchController *searchVC;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self loadDataSouce];
    
}


- (void)creattableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, VIEW_W, VIEW_H) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor purpleColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    
    self.saveSouce = [[NSMutableArray alloc] initWithArray:self.dataSouce];
    self.searchVC = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchVC.searchBar.placeholder= @"搜索你感兴趣的";
    
    //设置代理
    self.searchVC.delegate = self;
    //设置 更新结果的代理
    self.searchVC.searchResultsUpdater = self;
    
    //设置 是否显示半透明效果
    self.searchVC.dimsBackgroundDuringPresentation = NO;
    //self.searchVC
    //必须要让searchBar 自适应 才会显示
    [self.searchVC.searchBar sizeToFit];
    
    //先 适应 在 粘贴
    
    //把searchBar 作为 tableView的头视图
    self.tableView.tableHeaderView = self.searchVC.searchBar;
    

}


- (void)loadDataSouce {
    _dataSouce  = [NSMutableArray array];
    HttpEngine *manager = [HttpEngine shareEngine];
    [manager GET:HeadChannalURL parameters:nil success:^(id response) {
        self.dataSouce = [ChannalTypeModel arrayAppModelWithResponse:response];
       [self creattableView];
        [self.tableView reloadData];
        
    } failed:^(NSError *error) {
        
    }];
    
}

#pragma tableView的代理
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSouce.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    ChannalTypeModel *model = self.dataSouce[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}


#pragma mark 搜索框的代理

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"searchBar 内容 发生改变");
    //获取searchBar的内容
    NSString *text = searchController.searchBar.text;
    if (text.length == 0) {
        return;//内容空 返回
    }
    //先把以前的清空
    [self.dataSouce removeAllObjects];
    
    //下面 对  保存的数组 内容 进行搜索
    for (NSString *str in self.saveSouce) {
        NSRange range = [str rangeOfString:text options:NSCaseInsensitiveSearch];//不区分大小写 进行检索
        
        //NSRange range = [str rangeOfString:text];//区分大小写
        if (range.location != NSNotFound) {
            //表示 包含  搜索的内容
            [self.dataSouce addObject:str];//重新把结果放入数据源
        }
    }
    //刷新表格
    [self.tableView reloadData];
}
- (void)didDismissSearchController:(UISearchController *)searchController {
    NSLog(@"UISearchController 已经 消失");
    //已经消失的时候  应该把 数据源的数据 进行还原
    [self.dataSouce removeAllObjects];
    [self.dataSouce addObjectsFromArray:self.saveSouce];
    [self.tableView reloadData];
}
@end
