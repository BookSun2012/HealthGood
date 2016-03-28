//
//  MyFavoriteViewController.m
//  HealthyGood
//
//  Created by Qianfeng on 16/3/13.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "MyFavoriteViewController.h"
#import "Masonry.h"
@interface MyFavoriteViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataSouce;
@end

@implementation MyFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self creatBackBUtn];
    [self creatCollection];
}
//返回按钮
- (void)creatBackBUtn {
    UIButton *loginButn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButn.frame = CGRectMake(10, 30, 80, 30);
    loginButn.backgroundColor = [UIColor cyanColor];
    [loginButn setTitle:@"返 回" forState:UIControlStateNormal];
    loginButn.layer.cornerRadius = 5;
    loginButn.clipsToBounds = YES;
    loginButn.titleLabel.font = [UIFont systemFontOfSize:20];
    [loginButn addTarget: self action:@selector(loginPress:) forControlEvents:UIControlEventTouchUpInside];
    loginButn.tag = 201;
    [self.view addSubview:loginButn];
}
- (void)loginPress:(UIButton *)butn {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)creatCollection {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //每个Item的大小
    layout.itemSize = CGSizeMake(80, 50);
    //行间距
    layout.minimumLineSpacing = 10;
    //每行内部cell item的间距
    layout.minimumInteritemSpacing = 5;
    //内边距
    layout.sectionInset = UIEdgeInsetsMake(50, 50, 20, 20);
    //水平滚动
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 100, self.view.frame.size.width-10, self.view.frame.size.height-164)collectionViewLayout:layout];
//    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).offset(100);
//        make.leading.equalTo(self.view.mas_leading).offset(20);
//        make.trailing.equalTo(self.view.mas_trailing).offset(20);
//        make.bottom.equalTo(self.view.mas_bottom).offset(0);
//    }];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    
    //注册头视图
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headID"];
    //注册未视图
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footID"];
    
    
    
    [self.view addSubview:_collectionView];
    
    
}

#pragma  mark- CollectionView delegate
//返回一组有多少个Item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}
//组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}
//设置头尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *supperView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        //说明我们要返回头视图
        supperView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headID" forIndexPath:indexPath];
        supperView.backgroundColor = [UIColor orangeColor];
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        //返回未视图
        supperView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footID" forIndexPath:indexPath];
        supperView.backgroundColor = [UIColor orangeColor];
    }
    return supperView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {//第一组 单元大小为 80*80
        return CGSizeMake(80, 80);
    }else {//第二组
        if (indexPath.row == 0) {//第一行 大小 100*100
            return CGSizeMake(100, 100);
        }
        
        if (indexPath.row==12) {
            return CGSizeMake(100, 150);
        }
        if (indexPath.row==13) {
            return CGSizeMake(150, 150);
        }
        
        return CGSizeMake(50, 50);//其他行 大小 50*50
    }
}
 //在这里设置头视图的大小 代理方法设置大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
   
    return CGSizeMake(self.view.frame.size.width, 50);
}
//在这里设置尾视图的大小 代理方法设置大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    
    return CGSizeMake(self.view.frame.size.width, 50);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
