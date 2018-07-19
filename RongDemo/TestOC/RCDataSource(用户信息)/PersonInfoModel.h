//
//  PersonInfoModel.h
//  TestOC
//
//  Created by 林 on 16/2/17.
//  Copyright © 2016年 钱立新. All rights reserved.
//  启聊用户模型

#import <Foundation/Foundation.h>
#import <RongIMLib/RCUserInfo.h>

@interface PersonInfoModel : NSObject<NSCoding>
/**
 *  用户id
 */
@property (nonatomic, strong) NSString *userId;
/**
 *  imUserId
 */
@property (nonatomic, strong) NSString *imUserId;
/**
 *  姓名
 */
@property (nonatomic, strong) NSString *realName;
/**
 *  头像
 */
@property (nonatomic, strong) NSString *avatar;

- (RCUserInfo *)getRCUserInfo;

@end
