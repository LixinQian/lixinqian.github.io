//
//  AccountTool.m
//  TestOC
//
//  Created by 钱立新 on 15/11/19.
//  Copyright © 2015年 钱立新. All rights reserved.
//

#import "AccountTool.h"
#import "AFNetworking.h"

#import "NET.h"

#import "MJExtension.h"
#import <RongIMKit/RongIMKit.h>
#import "AllURLHeader.h"
#import <YYKit/NSString+YYAdd.h>

@interface AccountTool ()

@end

#define KFileDomaumentDir(fileName) [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:fileName]

#define  Kdefaults                [NSUserDefaults standardUserDefaults]

@implementation AccountTool

+ (void)saveAccount:(Account *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:KFileDomaumentDir(@"account.data")];
}

+ (Account *)accountEntrust {
    AccountTool *tool = [[AccountTool alloc] init];
    Account *model = (Account *)[tool.cache objectForKey:@"entrust"];
    return model;
}

+ (Account *)account
{

    return [NSKeyedUnarchiver unarchiveObjectWithFile:KFileDomaumentDir(@"account.data")];

}

+ (Account *)originalAccount
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:KFileDomaumentDir(@"account.data")];
}

- (YYDiskCache *)cache {
    if (!_cache) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _cache = [[YYDiskCache alloc] initWithPath:paths[0]];
        _cache.ageLimit = 3 * 60 * 60;
    }
    return _cache;
}


#pragma mark 网络请求

//登陆请求
+ (int)accountWithLoginName:(NSString *)userName passWord:(NSString*)paw success:(void(^)(NSNumber*succ,id data,id verify))success failure:(void(^)(NSError *error))failure {
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (id obj in [cookieJar cookies]) {
        [cookieJar deleteCookie:obj];
    }

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    [dict setObject:@"1531929396:qexSoXuyHS4Zf8eYbZfqx39hk2y/bYdR/Pcwjv4aKhKBxQj7EqAgLczXKbuyrXqtfBYBRZCqlhMlVwUfQ81Mqg==:q1XojIafYUm3K5dDMCZDMQjk0X4xzRPhmPoiojzRZNfyJbRsWzsHtVyTFOxjC0EfQ7nwO9KCLRz0Yp8Q8rvVCw==" forKey:@"token"];
    NSString *name = userName;
    [dict setObject:/*passWd*/paw forKey:@"password"];
    [dict setObject:name forKey:@"username"];
    [dict setObject:@"true" forKey:@"ismobile"];
    
    [NET POST:LoginBase_Url parameters:dict success:^(id responseObject) {
        
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([data[@"status"] integerValue] == 402) {
            if (success)  success(data[@"status"],data[@"msg"],nil);
        }else if([data[@"status"] integerValue] == 200){
            
            
            // 字典转模型
            Account *account = [Account objectWithKeyValues:data[@"result"]];
            // 保存账号信息 以后不用归档，用数据库，直接改业务类
            [AccountTool saveAccount:account];
            
            if (success)  success(data[@"status"],nil,data[@"result"][@"verify_two"]);
            
        }} failure:^(NSError *error) {
            if (failure)  failure(error);
            
        }];
    
    return 1;
}

@end
