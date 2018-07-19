//
//  Account.h
//  TestOC
//
//  Created by 钱立新 on 15/11/19.
//  Copyright © 2015年 钱立新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *departmentId;

@property (nonatomic, copy) NSString *departmentName;

@property (nonatomic, copy) NSString *entId;

@property (nonatomic, copy) NSString *entName;

@property (nonatomic, copy) NSString *login_user_id;

@property (nonatomic, copy) NSString *realName;

@property (nonatomic, copy) NSString *roleId;

@property (nonatomic, copy) NSString *roleName;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic,assign) BOOL  isLogin;

@property (nonatomic,assign) NSNumber *isNavigation;

@property (nonatomic,assign) NSNumber *sex;

@property (nonatomic,assign) NSNumber *type;

@property (nonatomic,assign) NSNumber *verify_two;

@property (nonatomic,assign) NSNumber *birth_type;

@property (nonatomic,copy) NSString *birthday;

@property (nonatomic,copy) NSString *create_time;

@property (nonatomic,copy) NSString *email;

@property (nonatomic,copy) NSString *last_login_time;

@property (nonatomic,copy) NSString *last_modified;

@property (nonatomic,copy) NSString *phone;

@property (nonatomic,copy) NSString *pinyin;

@property (nonatomic,assign) NSNumber *reg_type;

@property (nonatomic,assign) NSNumber *reset_pwd;

@property (nonatomic,copy) NSString *theme;

- (instancetype)initWithDic:(NSDictionary *)dict;
+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
