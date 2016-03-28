//
//  TopSliderButn.h
//  HealthyGood
//
//  Created by Qianfeng on 16/3/3.
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TopButnHeight  42
typedef void (^ButnonClickHandle)(NSInteger currentPage);

@interface TopSliderButn : UIScrollView

@property (nonatomic,strong)NSMutableArray *titles;
@property (nonatomic,assign) NSInteger currentPage;


@end
