//
//  RCGroupModel.h
//  TestOC
//
//  Created by dong on 2017/6/23.
//  Copyright © 2017年 安元. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCGroupUser : NSObject

@property (nonatomic,strong)NSString *userId;
@property (nonatomic,strong)NSString *imUserId;
@property (nonatomic,strong)NSString *realName;
@property (nonatomic,strong)NSString *avatar;

@end



@interface RCGroupModel : NSObject

/**
 at组名（A,B,C,D....）
 */
@property (nonatomic,copy)NSString *groupName;

/**
 组内总人数
 */
@property (nonatomic,copy)NSString *total;


/**
 组内user数组
 */
@property (nonatomic,strong)NSArray <RCGroupUser *>*list;


@end

@interface LHLQYCContactModel : NSObject

/**
 at组名（A,B,C,D....）
 */
@property (nonatomic,copy)NSString *letter;

/**
 组内总人数
 */
@property (nonatomic,copy)NSString *count;

/**
 组内user数组
 */
@property (nonatomic,strong)NSMutableArray <RCGroupUser *>*list;


@end


