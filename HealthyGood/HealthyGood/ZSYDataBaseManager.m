//
//  ZSYDataBaseManager.m
//  HealthyGood
//
//  Copyright © 2016年 ZhouShuYang. All rights reserved.
//

#import "ZSYDataBaseManager.h"
#import "Like.h"
@interface ZSYDataBaseManager ()
@property (nonatomic,copy)NSString *dbpath;
@end

@implementation ZSYDataBaseManager

+(instancetype)defaultManager {
    static ZSYDataBaseManager *manager = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        manager = [[ZSYDataBaseManager alloc]init];
    });

    return manager;
}
-(instancetype)init {
    if (self = [super init]) {
        _dataBase = [[FMDatabase alloc]init];

        //1 从资源中加载模型文件
        //找到模型文件的Url
        NSURL *modelUrl = [[NSBundle mainBundle]URLForResource:@"Model" withExtension:@"momd"];
        //2 初始化模型文件
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelUrl];
        //3 添加数据库支持
        //把我们的模型文件 映射到数据库中
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
        
        //4 创建数据库  并设置数据库路径
        NSString *sqlPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)lastObject];
        _dbpath = [sqlPath stringByAppendingPathComponent:@"my.sqlite"];
        _dataBase = [FMDatabase databaseWithPath:_dbpath];
        NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
        
        //添加持久化存储库  在这里使用SQLLite 作为数据库
        //用协调器去添加一个持久化存储库
        NSError *error = nil;
        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:nil error:&error];
        if (!store) {
            NSLog(@"创建数据库模型失败");
            [NSException raise:@"添加数据库模型错误" format:@"%@",[error localizedDescription]];
        }
            
            
            //创建CoreData的上下文
            self.context = [[NSManagedObjectContext alloc]init];
            self.context.persistentStoreCoordinator = psc;
            NSLog(@"创建数据库模型成功");
        
    }
    
    return self;

}
//插入数据
- (void)insetrDataWithModel:(ChannelsModel*)model{
    Like *like = (Like *)[NSEntityDescription insertNewObjectForEntityForName:@"LikeModel" inManagedObjectContext:self.context];
    like.type      =   model.type;
    like.bookCount =   model.bookcount;
    [self saveDataWithType:@"insert"];
}
//保存类型
- (void)saveDataWithType:(NSString *)type {
    NSError *error = nil;
    BOOL ret = [self.context save:&error];
    if (!ret) {
        NSLog(@"%@ error:%@",type,error.localizedDescription);
    }
}
//删除数据
- (void)deledateDataWithType:(NSString *)type {
    NSArray *arr = [self fetchDataWithType:type];
    for (Like *like in arr) {
        [self.context deleteObject:like];
    }
    [self saveDataWithType:@"delete"];

}
//查询数据
- (NSArray *)fetchDataWithType:(NSString *)type {
    // 1 创建查询的类
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    // 2  查询实体 和 上下文
    request.entity = [NSEntityDescription entityForName:@"LikeModel" inManagedObjectContext:self.context];
    if (type) {
    // 3 查询条件  谓词查询
        NSString *str = [NSString stringWithFormat:@"self.type like '%@'",type];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:str];
        request.predicate = predicate;
    }
    NSError *error;
    // 4 获取结果，用我们的上下文获取结果
    NSArray *array = [self.context executeFetchRequest:request error:&error];
    //使用枚举器 遍历数组
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",[obj valueForKey:@"type"]);
        NSLog(@"%@",[obj valueForKey:@"bookCount"]);
    }];
    
    return array;
}
- (void)updataWithType:(NSString *)type model:(ChannelsModel*)model {
    NSArray *array = [self fetchDataWithType:type];
    for (Like *like in array) {
        like.type = model.type;
        like.bookCount = model.bookcount;
    }
    [self saveDataWithType:@"updata"];
}

@end
