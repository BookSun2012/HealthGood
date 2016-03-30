//
//  HttpEngine.h
//  LimitFreeApp
//
//  Created by zhoushuyang on 16/2/17.
//  Copyright © 2016年 zhoushuyang. All rights reserved.
//

#import <Foundation/Foundation.h>
//成功的回调Block
typedef void (^SuccessBlockType)(id response);
//失败的回调Block
typedef void(^FailedBlockType) (NSError *error);


@interface HttpEngine : NSObject

//公开方法
+ (instancetype)shareEngine;

- (void)GET:(NSString *)URLString parameters:(id)parameter  success:(SuccessBlockType)success failed:(FailedBlockType)failed;


@end
