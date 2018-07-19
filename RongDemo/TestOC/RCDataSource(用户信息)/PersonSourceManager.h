//
//  PersonSourceManager.h
//  TestOC
//
//  Created by 林 on 16/2/17.
//  Copyright © 2016年 钱立新. All rights reserved.
//  启聊用户管理类

#import <Foundation/Foundation.h>
#import "PersonInfoModel.h"

@interface PersonSourceManager : NSObject

// 获得一个用户管理单例
+ (PersonSourceManager *)sharedPersonSourceManager;

// 更新用户信息
- (void)getDataFromServer;

/**
 *  根据userID获取用户模型
 */
- (void)getPersonDataByUserId:(NSString *)userId block:(void(^)(PersonInfoModel *model))block;

/**
 *  根据userID数组 获取用户模型数组
 */
- (void)getPersonDataByUserIds:(NSArray *)userIds block:(void(^)(NSArray <PersonInfoModel *>*models))block;

/**
 *  根据imID获取用户模型 异步返回
 */
- (void)getPersonDataByImId:(NSString *)imId block:(void (^)(PersonInfoModel *model))block;

- (void)getPersonDataByImIds:(NSArray *)imIds block:(void (^)(NSArray <PersonInfoModel *>*models))block;

@end
