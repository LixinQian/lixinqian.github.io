//  AllURLHeader.h
//  TestOC
//
//  Created by 钱立新 on 15/12/1.
//  Copyright © 2015年 钱立新. All rights reserved.
//

#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString * const AppStoreUrl;

#define BaseURL @"https://release.qycloud.com.cn/"

/** 下载用户头像 -URL */
#define user_down_photo_Url [NSString stringWithFormat:@"%@api/user/avatar/show/120/120/",BaseURL]


/**消息三端统一（融云通道）*/
UIKIT_EXTERN NSString * const QYC_messageRead;
UIKIT_EXTERN NSString * const QYC_messageReadUnite;

/**获取群组的成员*/
UIKIT_EXTERN NSString * const getAllGroupMembers;
/**获取对应的部门，岗位，角色的名称*/
UIKIT_EXTERN NSString * const getRoleOrDepartmentOrRoleGroup;
// 获取指定群组信息
UIKIT_EXTERN NSString * const getCustomGroupInfo;
//获取token
UIKIT_EXTERN NSString * const Token_Url;

//登陆
UIKIT_EXTERN NSString * const LoginBase_Url;

//基本信息（设置）
UIKIT_EXTERN NSString * const setting_Url ;

/**
 * 获取所有部门 -URL
 */
UIKIT_EXTERN NSString * const AllDepartMent_Url ;

/**
 * 获取组织架构的所有用户 -URL
 */
UIKIT_EXTERN NSString * const All_Organization_User_Url ;

/**
 *  (获取通讯录所有用户v1.1)
 */
UIKIT_EXTERN NSString * const QYC_communication_allUsers_api ;

/**
 *  获取融云token
 */
UIKIT_EXTERN NSString * const GetRongCloudToken;
/**
 *  获取启聊用户信息
 */
UIKIT_EXTERN NSString * const GetUserInfoURL;
/**
 *  获取启聊用户信息 通过im
 */
UIKIT_EXTERN NSString * const GetUserInfoByImUserid;

/**
 *  获取entId企业下 启聊所有用户信息
 */
UIKIT_EXTERN NSString * const GetAllUserInfo;

/**
 *  获取启聊企业信息
 */
UIKIT_EXTERN NSString * const GetDptGroupinfo;


/**
 *  获取启聊部门群信息
 */
UIKIT_EXTERN NSString * const GetAllDptGroupinfo;

/**
 *  获取最近联系人
 */
UIKIT_EXTERN NSString * const contacts_Url ;


/**
 注销登录，企业概况使用
 */
UIKIT_EXTERN NSString * const Logout_Url;







