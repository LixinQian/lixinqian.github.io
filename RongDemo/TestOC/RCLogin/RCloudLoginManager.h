//
//  RCloudLoginModel.h
//  TestOC
//
//  Created by 林 on 16/2/29.
//  Copyright © 2016年 安元. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>

/**
 融云登录管理类
 */
@interface RCloudLoginManager : NSObject

/**
 *  获取一个登陆管理
 */
+ (instancetype)sharedRCloudManager;
/**
 *  直接默认登陆
 */
- (void)loginRCServer;
/**
 *  根据用户名登录
 */
- (void)loginRCServerWithUserId:(NSString *)userId;

- (void)removeToken;


@end
