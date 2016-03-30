//
//  CacheManger.h
//  LimitFreeApp
//
//  Created by zhoushuyang on 16/2/18.
//  Copyright © 2016年 zhoushuyang. All rights reserved.
//

#import <Foundation/Foundation.h>

//sd_WebImage 缓存原理  就是把请求回来的数据   存在本地沙盒里面   把这个请求的URL用MD5加密一下 当做文件名称


@interface CacheManger : NSObject


//

//存数据  传入对象 和Url
+ (void)saveData:(id)object withUrl:(NSString *)urlStr;
//读数据
+ (id)readDataWithUrl :(NSString *)urlStr;

@end
