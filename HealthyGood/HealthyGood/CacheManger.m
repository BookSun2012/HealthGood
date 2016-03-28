//
//  CacheManger.m
//  LimitFreeApp
//
//  Created by Qianfeng on 16/2/18.
//  Copyright © 2016年 zhoushuyang. All rights reserved.
//

#import "CacheManger.h"
#import "NSString+Hashing.h"//MD5 加密 的三方库
@implementation CacheManger

//指定一个存取数据的路径  方便存取

+(NSString *)cacheDirectory {
    //创建一个路径
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    cacheDir = [cacheDir stringByAppendingPathComponent:@"mycache"];
    //检查路径是否存在  如果不存在就创建这个目录
    NSError *error;
    BOOL breat = [[NSFileManager defaultManager]createDirectoryAtPath:cacheDir withIntermediateDirectories:YES attributes:nil error:&error];
    if (!breat) {
        NSLog(@"%@",error);
        return nil;
    }
//    NSLog(@"沙盒中的缓存路径%@",cacheDir);
    return cacheDir;
}

//返回指定URL 数据保存的全部路径
+(NSString *)fullPathWithUrl:(NSString *)urlStr {
    //先去得到缓存的路径
    NSString *cacheDir = [self cacheDirectory];
    //得到URL 加密以后的字符串
    NSString *md5Str = [urlStr MD5Hash];
    //拼成完整的路径
    NSString *fullPath = [cacheDir stringByAppendingPathComponent:md5Str];
    return fullPath;
}
//存数据
+(void)saveData:(id)object withUrl:(NSString *)urlStr{
    //首先拿到 文件存的地址
    NSString *fillPath =  [self fullPathWithUrl:urlStr];
    //把对象转换为二进制数据  (归档)
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    
    //把数据写入文件
    [data writeToFile:fillPath atomically:YES];
    
}
//读数据
+ (id)readDataWithUrl :(NSString *)urlStr{
    //先把Url 转换为地址路径
    NSString *path = [self fullPathWithUrl:urlStr];
    //读取数据
    NSData *data = [NSData dataWithContentsOfFile:path];
    //最后返回的时候 需要把二进制数据转换为对象（解档）
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
@end
