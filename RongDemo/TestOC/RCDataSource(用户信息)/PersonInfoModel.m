//
//  PersonInfoModel.m
//  TestOC
//
//  Created by 林 on 16/2/17.
//  Copyright © 2016年 钱立新. All rights reserved.
//

#import "PersonInfoModel.h"
#import "MJExtension.h"
#import "AccountTool.h"



@implementation PersonInfoModel
@synthesize avatar = _avatar;
MJCodingImplementation

- (void)setAvatar:(NSString *)avatar {
    NSMutableString *str = [NSMutableString stringWithString:avatar];
    if ([str containsString:@"/30/30"] || [str containsString:@"/120/120"]) {
        Account *acc = [AccountTool account];
        [str appendFormat:@"/%@",acc.entId] ;
    }
    str = [str stringByReplacingOccurrencesOfString:@"/30/30" withString:@"/120/120"].mutableCopy;
    str = [str stringByReplacingOccurrencesOfString:@"small" withString:@"big"].mutableCopy;
    _avatar = str;
}


- (RCUserInfo *)getRCUserInfo {
    RCUserInfo *user = [[RCUserInfo alloc]init];
    user.userId = self.imUserId;
    user.name = self.realName;
    user.portraitUri = self.avatar;
    return user;
}

@end
