//
//  DptGroupInfoModel.h
//  TestOC
//
//  Created by 林 on 16/3/2.
//  Copyright © 2016年 安元. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DptGroupInfoModel : NSObject

/**
 *  公司ID
 */
@property (nonatomic, strong) NSString *departmentId;
/**
 *  公司名称
 */
@property (nonatomic, strong) NSString *departmentName;
/**
 *  群组人数
 */
@property (nonatomic, strong) NSString *groupCount;
/**
 *  群组创建时间
 */
@property (nonatomic, strong) NSString *groupCreateTime;
/**
 *  群组文件..待定
 */
@property (nonatomic, strong) NSString *groupFile;
/**
 *  群组ID
 */
@property (nonatomic, strong) NSString *groupId;
/**
 *  群组信息..待完善
 */
@property (nonatomic, strong) NSString *groupInfo;
/**
 *  群组等级..待完善
 */
@property (nonatomic, strong) NSString *groupLevel;
/**
 *  群组名称
 */
@property (nonatomic, strong) NSString *groupName;


@end
