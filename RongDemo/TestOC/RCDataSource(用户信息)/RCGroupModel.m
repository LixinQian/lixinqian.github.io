//
//  RCGroupModel.m
//  TestOC
//
//  Created by dong on 2017/6/23.
//  Copyright © 2017年 安元. All rights reserved.
//

#import "RCGroupModel.h"
#import "MJExtension.h"

@implementation RCGroupUser
- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    if (![[self class] isEqual:[object class]]) {
        return NO;
    }
    RCGroupUser *user = (RCGroupUser *)object;
    if ([user.userId isEqualToString:self.userId] && [user.realName isEqualToString:self.realName] && [user.imUserId isEqualToString:self.imUserId] &&[user.avatar isEqualToString:self.avatar]) {
        return YES;
    } else {
        return NO;
    }
}


@end


@implementation RCGroupModel
+ (NSDictionary *)objectClassInArray {
    return @{
             @"list" : @"RCGroupUser"
             
             };
}
@end


@implementation LHLQYCContactModel

+ (NSDictionary *)objectClassInArray {
    return @{
             @"list" : @"RCGroupUser"
             
             };
}
@end

