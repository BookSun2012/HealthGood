//
//  ChannalCellDetailViewController.m
//  HealthyGood
//
//  Created by Qianfeng on 16/2/28.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "ChannalCellDetailViewController.h"
#import "HttpEngine.h"
#import "Define.h"
#import <DKNightVersion.h>
@interface ChannalCellDetailViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) NSString *doce;
@property (nonatomic,strong) NSString *webUrl;
@property (nonatomic,strong)UIWebView *Webview;
@property (nonatomic,strong)UIActivityIndicatorView *indicator;

@end
//http://i3.go2yd.com/image.php?url=0CX2rr00&type=webp_580x000&net=wifi
//<img src="http://image1.hipu.com/image.php?type=thumbnail_580x000&amp;url=0CW6nI00" alt="http://image1.hipu.com/image.php?url=0CW6nI00" width="515" height="240"  style="width:290px; height:135px;" />
@implementation ChannalCellDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self httpRequest];
    
    self.view.backgroundColor = [UIColor whiteColor];
     _doce = [[NSString alloc]init];
    self.Webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, VIEW_W, VIEW_H-44)];
    self.Webview.delegate = self;
    self.Webview.tag = 103;
    self.Webview.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], [UIColor grayColor]);
    self.Webview.dk_tintColorPicker = DKColorWithColors([UIColor whiteColor], [UIColor grayColor]);
    [self.view addSubview:self.Webview];
}
//添加菊花加载效果
- (void)creatActivity {
    _indicator = nil;
    _indicator = (UIActivityIndicatorView *)[self.view viewWithTag:103];
    
    if (_indicator == nil) {
        //初始化:
        _indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        _indicator.tag = 103;
        //设置显示样式,见UIActivityIndicatorViewStyle的定义
        _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        //设置背景色
        _indicator.backgroundColor = [UIColor blackColor];
        //设置背景透明
        _indicator.alpha = 0.5;
        //设置背景为圆角矩形
        _indicator.layer.cornerRadius = 6;
        _indicator.layer.masksToBounds = YES;
        //设置显示位置
        [_indicator setCenter:CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0)];
        //开始显示Loading动画
        [_indicator startAnimating];
        [self.view addSubview:_indicator];
    }
}

- (void)httpRequest {
    HttpEngine  *enager = [HttpEngine shareEngine];
    _webUrl = [NSString stringWithFormat:webViewURL,self.doceID];
    
    [enager GET:_webUrl parameters:nil success:^(id response) {
//        NSLog(@"%@",response);
        NSArray *arr = response[@"documents"];
       
        for (NSDictionary *dic in arr) {
            
            _doce = dic[@"url"];
//          _doce = dic[@"content"];
            
        }
        



//           [self.Webview loadHTMLString:htmlStr baseURL:nil];
       [self.Webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_doce]]];
        
        
        
    } failed:^(NSError *error) {
        
    }];
    
//    NSLog(@"*****************WebUrl%@",_webUrl);
}
//
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    NSLog(@"url123:%@",request.URL.absoluteString);
//    if ([request.URL.absoluteString isEqualToString:_doce] ) {
//        return YES;
//    }
//    
//    NSLog(@"开始请求数据");
//    return NO;
//}
//

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self creatActivity];
    //开始显示Loading动画
    [_indicator startAnimating];
    //开始加载，可以加上风火轮（也叫菊花）
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_indicator stopAnimating];
    //完成加载
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //加载出错
    NSLog(@"加载出错%@",error);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
