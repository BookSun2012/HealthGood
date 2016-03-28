//
//  MystationViewController.m
//  HealthyGood
//
//  Created by Qianfeng on 16/3/14.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "MystationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Masonry.h"
@interface MystationViewController ()<CLLocationManagerDelegate,MKMapViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong)CLLocationManager *manager;
@property (nonatomic,strong)MKMapView *mapView;
@property (nonatomic,strong)NSString *textFild;
@end

@implementation MystationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self creatLocationManager];
    [self creatButn];
    [self creatMapView];
    
}

- (void)creatLocationManager{
    _manager = [[CLLocationManager alloc]init];
    _manager.delegate = self;
    //定位过滤器
    _manager.distanceFilter = 10;
    //地图精度
    _manager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [_manager startUpdatingLocation];//iOS 8 以前 直接调用这个方法 就能更新用户位置
    //iOS 8 以后 需要获取用户权限
    //  1  判定系统版本号
    if ([[UIDevice currentDevice].systemVersion floatValue ]>8) {
        //在申请之前 要在InfoPlist 文件中 设置一下
        
         // 需要在info.plist里增加这个key NSLocationAlwaysUsageDescription
//        [_manager requestAlwaysAuthorization ];//一直定位
         // 需要在info.plist里增加这个key NSLocationWhenInUseUsageDescription
        [_manager requestWhenInUseAuthorization];//当程序启动的时候才定位
    }
    //  2  判断这个方法 有没有响应
    if ([_manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_manager requestAlwaysAuthorization];
    }
    
}


//获取移动的位置
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    //获取经纬度
    CLLocationCoordinate2D cordinate = location.coordinate;
    NSLog(@"经度:%f 维度:%f",cordinate.latitude,cordinate.longitude);
}
//地理编码    地名---------》经维度
- (void)geoCoder{
    CLGeocoder *coder =  [[CLGeocoder alloc]init];
    [coder geocodeAddressString:@"河南" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count ==0|| error) {
            NSLog(@"没有找到位置");
        }else {
            CLPlacemark *clipMark = [placemarks lastObject];
            NSLog(@"地址信息字典:%@",clipMark.addressDictionary);//地址信息字典
            if (clipMark) {
                NSLog(@"城市:%@",clipMark.locality);
            }
        }
    }];
}
//反地理编码  经纬度 ------》地名
- (void)reverseCoder{
    CLGeocoder *coder = [[CLGeocoder alloc]init];
    //经纬度
    CLLocation *location = [[CLLocation alloc]initWithLatitude:34.7568711 longitude:113.663221];
    //根据经纬度 算出具体位置
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *pm = [placemarks lastObject];
        NSLog(@"%@",pm.addressDictionary);
        
    }];
}


//创建一张地图视图
- (void)creatMapView{
    //创建一张地图视图 添加到View 上
    _mapView = [[MKMapView alloc]init];
    [self.view addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.leading.equalTo(self.view.mas_leading).offset(20);
        make.trailing.equalTo(self.view.mas_trailing).offset(-20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
    }];
    _mapView.mapType = MKMapTypeStandard;//地图类型
    _mapView.showsUserLocation = YES;//显示用户位置
    _mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;//跟踪用户位置
    _mapView.delegate = self;//设置代理
    [self creatBackButn];
}
//自己的位置
- (void)creatBackButn{
    UIButton *butn = [UIButton buttonWithType:UIButtonTypeSystem];
    butn.frame = CGRectMake(10, 30, 100, 50);
    [butn setTitle:@"我的位置" forState:UIControlStateNormal];
    [_mapView addSubview:butn];
    [butn addTarget:self action:@selector(backLocation:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)backLocation:(UIButton *)butn {
    [_mapView setRegion:MKCoordinateRegionMake(_mapView.userLocation.coordinate, MKCoordinateSpanMake(0.002, 0.001)) animated:YES];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    userLocation.title = @"用户当前位置";
    userLocation.subtitle = @"详细位置";
    //反地理编码
    CLGeocoder *reverGeoCode = [[CLGeocoder alloc]init];
    [reverGeoCode reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placmak = [placemarks lastObject];
        if (placmak.locality) {
            // 市
            userLocation.title = placmak.locality;
        }else {
            //省
            userLocation.title = placmak.administrativeArea;
        }
        NSLog(@"%@,%@,%@",placmak.locality,placmak.name,placmak.subAdministrativeArea);
        userLocation.subtitle= placmak.name;
    }];
    
    
}





- (void)creatButn{
    UIButton *loginButn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButn.frame = CGRectMake(10, 30, 80, 30);
    loginButn.backgroundColor = [UIColor cyanColor];
    [loginButn setTitle:@"返 回" forState:UIControlStateNormal];
    loginButn.layer.cornerRadius = 5;
    loginButn.clipsToBounds = YES;
    loginButn.titleLabel.font = [UIFont systemFontOfSize:20];
    [loginButn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginButn addTarget: self action:@selector(loginPress:) forControlEvents:UIControlEventTouchUpInside];
    loginButn.tag = 201;
    [self.view addSubview:loginButn];
}


- (void)creatTextFiled {
    UITextField *filed = [[UITextField alloc]init];
    filed.backgroundColor = [UIColor orangeColor];
    filed.placeholder = @"请输入查询地点";
    filed.tag = 100;
    [self.view addSubview:filed];
    
    [filed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(30);
        make.leading.equalTo(self.view.mas_leading).offset(100);
        make.trailing.equalTo(self.view.mas_trailing).offset(-20);
        make.height.mas_equalTo(30);
    }];
    
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    UITextField *texFiled = (UITextField *)[self.view viewWithTag:100];
    
    return YES;
}

- (void)loginPress:(UIButton *)butn {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
