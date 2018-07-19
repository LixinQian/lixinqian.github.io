//
//  RCloudLoginModel.m
//  TestOC
//
//  Created by 林 on 16/2/29.
//  Copyright © 2016年 安元. All rights reserved.
//

#import "RCloudLoginManager.h"
#import "AccountTool.h"
#import "Account.h"
#import "NET.h"
#import "PersonSourceManager.h"
#import "DptGroupInfoManager.h"
#import <YYKit/NSString+YYAdd.h>
#import "AllURLHeader.h"

@interface RCloudLoginManager () 

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, assign) int faileCount;

@end


@implementation RCloudLoginManager

+ (instancetype)sharedRCloudManager {
    static RCloudLoginManager *sharedManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManager = [[self alloc] init];;
    });
    return sharedManager;
}

- (void)loginRCServerWithUserId:(NSString *)userId
{
    self.userId = userId;
    if (self.token.isNotBlank) {
        [self connectWithToken:self.token];
    } else {
        [self getTokenFromUserId:userId];
    }
}

- (void)getTokenFromUserId:(NSString *)userId {
    [self removeToken];
    NSString *url = [NSString stringWithFormat:@"%@?userId=%@",GetRongCloudToken, userId];
    [NET GET:url parameters:nil success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"status"] integerValue] == 1200) {
            self.token = dict[@"token"];
            [self connectWithToken:self.token];
        }else if ([dict[@"status"] integerValue] == 2101) {
            return;
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)loginRCServer {
    Account *acc = [AccountTool account];
    [self loginRCServerWithUserId:acc.userId];
}

- (int)faileCount {
    if (!_faileCount) {
        _faileCount = 0;
    }
    return _faileCount;
}

- (void)connectWithToken:(NSString *)token {
    
    __weak typeof(self) weakSelf = self;
    
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        
        RCUserInfo *userInfo = [[RCIM sharedRCIM] currentUserInfo];
        Account *acc = [AccountTool account];
        userInfo.name = acc.realName;
        userInfo.portraitUri = [NSString stringWithFormat:@"%@%@/%@",user_down_photo_Url, acc.userId, acc.entId];
        [[DptGroupInfoManager sharedPersonSourceManager] getDataFromServer];
        [[PersonSourceManager sharedPersonSourceManager] getDataFromServer];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RCKitDispatchMessageNotification" object:nil];
    } error:^(RCConnectErrorCode status) {
        if (self.faileCount > 3) {
            return ;
        }
        [weakSelf getTokenFromUserId:self.userId];
        [weakSelf loginRCServer];
        NSLog(@"登陆的错误码为:%ld", (long)status);
        self.faileCount += 1;
    } tokenIncorrect:^{
        if (self.faileCount > 3) {
            return ;
        }
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
        [weakSelf getTokenFromUserId:self.userId];
        [weakSelf loginRCServer];
        self.faileCount += 1;
    }];
}

- (void)removeToken {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RCloudLoginManager.token"];
}

- (void)setToken:(NSString *)token {
    if (!token) return;
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"RCloudLoginManager.token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
/**
 *  获取缓存的token
 */
- (NSString *)token {
    NSString *tok = [[NSUserDefaults standardUserDefaults] objectForKey:@"RCloudLoginManager.token"];
    if (tok.isNotBlank) {
        self.token = tok;
    }
    return tok;
}


@end
