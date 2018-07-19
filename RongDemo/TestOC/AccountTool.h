//
//  AccountTool.h
//  TestOC
//
//  Created by 钱立新 on 15/11/19.
//  Copyright © 2015年 钱立新. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import "Account.h"
#import <YYKit/YYDiskCache.h>
@interface AccountTool : NSObject

@property (nonatomic, strong) YYDiskCache *cache;

//保存登陆返回信息
+ (void)saveAccount:(Account *)account;

// 原始信息
+ (Account *)originalAccount;
//获取登陆返回信息
+ (Account *)account;

/**
 *  登录请求
 *
 *  @param success 成功时回调
 *  @param failure 失败时回调
 */
+ (int)accountWithLoginName:(NSString *)userName passWord:(NSString*)paw success:(void(^)(NSNumber*succ,id data,id verify))success failure:(void(^)(NSError *error))failure;

@end
