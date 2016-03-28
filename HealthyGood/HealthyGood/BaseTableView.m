//
//  BaseTableView.m
//  HealthyGood
//
//  Created by Qianfeng on 16/3/8.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "BaseTableView.h"

#import "HttpEngine.h"
#import "Define.h"
#import "HeadModel.h"

#import "FirstContaintCell.h"
#import "SecondContaintCell.h"
#import "ThirdContaintCell.h"

#import "HeadPageViewController.h"


@interface BaseTableView ()
@property (nonatomic,strong)NSMutableArray *dataSouce;
@property (nonatomic,strong)Result *resultModel;
@end

@implementation BaseTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 44;
        self.dk_backgroundColorPicker = DKColorWithRGB(0xaaaaaa, 0x313131);
        self.dk_separatorColorPicker = DKColorWithRGB(0xaaaaaa, 0x313131);
        
        [self loadDataSouce];
        
        [self registerNib:[UINib nibWithNibName:@"FirstContaintCell" bundle:nil] forCellReuseIdentifier:@"cellID1"];
        [self registerNib: [UINib nibWithNibName:@"SecondContaintCell" bundle:nil] forCellReuseIdentifier:@"cellID2"];
        [self registerNib:[UINib nibWithNibName:@"ThirdContaintCell" bundle:nil] forCellReuseIdentifier:@"cellID3"];
    }
    return self;
}

- (void)loadDataSouce {
    HttpEngine
    *enger = [HttpEngine shareEngine];
    [enger GET:HeadViewURL parameters:nil success:^(id response) {
        NSError *error = nil;
        _dataSouce = [Result1 arrayOfModelsFromDictionaries:response[@"result"] error:&error];
       
        [self reloadData];

    } failed:^(NSError *error) {
        
    }];
    
}


#pragma mark- tableView 代理
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSouce.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Result1 *model = self.dataSouce[indexPath.row];
    if (model.image_urls.count == 0) {
        FirstContaintCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID1"];
        cell.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x343434);
        [cell configerData:model];
        return cell;
    }else if(model.image_urls.count == 1){
        SecondContaintCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID2" ];
        cell.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x343434);
        [cell configerData:model];
        return cell;
    }else {
        ThirdContaintCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID3"];
        cell.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x343434);
        [cell configerData:model];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.resultModel = self.dataSouce[indexPath.row];
    //block
    //  _page(self.resultModel.docid);
    
    //代理
    if ([_mydelegate respondsToSelector:@selector(nextPage:)]) {
        [self.mydelegate nextPage:self.resultModel.docid ];
    }
   
    //属性
  // [self.controller.navigationController pushViewController:detailVC animated:YES];

    
}

@end
