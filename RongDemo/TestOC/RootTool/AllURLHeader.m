//
//  AllURLHeader.m
//  TestOC
//
//  Created by lhl on 2018/3/9.
//  Copyright © 2018年 安元. All rights reserved.
//

#import <UIKit/UIKit.h>

/**消息三端统一（融云通道）*/
NSString * const QYC_messageRead = @"api2/chat/chat";
NSString * const QYC_messageReadUnite = @"api2/chat/chat/mobileToWebMessage";


/**获取群组的成员*/
NSString * const getAllGroupMembers = @"api2/chat/chat/Getallusersbygroupid";
/**获取对应的部门，岗位，角色的名称*/
NSString * const getRoleOrDepartmentOrRoleGroup= @"orgapp/tree/name/";
// 获取指定群组信息
NSString * const getCustomGroupInfo = @"api2/chat/groupchat/getgroupinfo";

NSString * const getDataSourceInfo  = @"api/information/data/datasource";

//获取token
NSString * const Token_Url = @"api2/user/token";

//登陆
NSString * const LoginBase_Url = @"api2/user/login";

//基本信息（设置）
NSString * const setting_Url  = @"api2/user/data";

/**
 * 获取所有部门 -URL
 */
//NSString * const AllDepartMent_Url  = @"api/organization/getAllDpts";
NSString * const AllDepartMent_Url = @"orgapp/tree/departments";

/**
 * 获取组织架构的所有用户 -URL
 */
//NSString * const All_Organization_User_Url  = @"api/organization/getUserInfoEx";
NSString * const All_Organization_User_Url = @"orgapp/user/info";

/**
 *  (获取通讯录所有用户v1.1)
 */
//NSString * const QYC_communication_allUsers_api  = @"api/organization/getuserinfo";
NSString * const QYC_communication_allUsers_api = @"orgapp/user/pinfo";

#pragma mark 启聊URL地址区
/**
 *  获取融云token
 */
NSString * const GetRongCloudToken = @"api2/chat/chat/gettoken";
/**
 *  获取启聊用户信息
 */
NSString * const GetUserInfoURL = @"api2/chat/chat/getimuserinfo";
/**
 *  获取启聊用户信息 通过im
 */
NSString * const GetUserInfoByImUserid = @"api2/chat/chat/getuserinfobyimuserid";

/**
 *  获取entId企业下 启聊所有用户信息
 */
NSString * const GetAllUserInfo = @"api2/chat/chat/GetAllImUserInfoByEntId";

/**
 *  获取启聊企业信息
 */
NSString * const GetDptGroupinfo = @"api2/chat/chat/getdptgroupinfo?departmentId";


/**
 *  获取启聊部门群信息
 */
NSString * const GetAllDptGroupinfo = @"api2/chat/chat/getAllDptGroupinfo";

/**
 *  获取最近联系人
 */
NSString * const contacts_Url  = @"api/comments/user/";


/**
 注销登录，企业概况使用
 */
NSString * const Logout_Url = @"api2/user/loginout";

