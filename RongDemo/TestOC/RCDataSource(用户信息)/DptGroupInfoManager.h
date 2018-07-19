//
//  DptGroupInfoManager.h
//  TestOC
//
//  Created by 林 on 16/3/2.
//  Copyright © 2016年 安元. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DptGroupInfoModel.h"
@class RCGroup;
@interface DptGroupInfoManager : NSObject

// 获得一个用户管理单例
+ (DptGroupInfoManager *)sharedPersonSourceManager;

- (NSArray *)allGroupInfo;

// 请求所有用户信息
- (void)getAllDptGroupInfo;

// 重亲请求数据
- (void)getDataFromServer;

// 根据GroupId获取用户模型
- (DptGroupInfoModel *)getDptGroupInfoByGroupId:(NSString *)groupId;

// 通过自定义群组Id来获取对应的群组信息
- (void)getCustomGroupInfoByGroupId:(NSString *)groupId completion:(void (^)(NSUInteger code, RCGroup *groupInfo))completion;
@end
