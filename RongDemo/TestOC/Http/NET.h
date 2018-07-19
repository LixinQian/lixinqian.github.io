//
//  NET.h
//  TestOC
//
//  Created by 钱立新 on 15/10/28.
//  Copyright © 2015年 钱立新. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UploadParam.h"
@class AFHTTPRequestSerializer;
@interface NET : NSObject


+(NSDictionary*)requestWithMethod:(NSString*)method URLStr:(NSString*)URLString parameters:(id)parameters;


/**
 *  发送get请求异步
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+(void)GET:(NSString*)URLString parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  发送post请求异步
 *
 *  @param URLString 请求的基本url
 *  @param parameter 请求的参数字典
 *  @param success   请求成功的回调
 *  @param failure   请求失败的回调
 */
+(void)POST:(NSString*)URLString parameters:(id)parameter success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  上传请求
 *
 *  @param URLSting    请求的基本的url
 *  @param parameters   请求的参数字典
 *  @param uploadParams  上传的内容
 *  @param success      请求成功的回调
 *  @param failure      请求失败的回调
 */
+(void)Upload:(NSString*)URLSting parameter:(id)parameters uploadParam:(NSArray*)uploadParams success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  delete请求
 *
 *  @param urlString 请求的基本url
 *  @param paramer 请求的参数字典
 *  @param success   请求成功的回调
 *  @param failure   请求失败的回调
 */
+(void)Delete:(NSString *)urlString parameter:(id)paramer success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  put请求
 *
 *  @param urlString 请求的基本url
 *  @param paramer 请求的参数字典
 *  @param success   请求成功的回调
 *  @param failure   请求失败的回调
 */
+ (void)Put:(NSString *)urlString parameter:(id)paramer success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  文件下载
 *
 *  @param urlString 请求的基本url
 *  @param paramer 请求的参数字典
 *  @param fileName  保存的文件名称
 *  @param success   请求成功的回调
 *  @param failure   请求失败的回调
 */
+ (void)Down:(NSString *)urlString parameter:(id)paramer fileName:(NSString*)fileName success:(void (^)(NSString *filePath))success failure:(void (^)(NSError *error))failure;



/**
 发送带有缓存的get请求异步
 
 @param URLString 请求的基本的url
 @param parameters 请求的参数字典
 @param cache 缓存的回调
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+(void)GET:(NSString*)URLString parameters:(id)parameters responseCache:(void(^)(id responseCache))cache success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 发送带有缓存的post请求异步

 @param URLString 请求的基本的url
 @param parameter 请求的参数字典
 @param cache 缓存的回调
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+(void)POST:(NSString*)URLString parameters:(id)parameter responseCache:(void(^)(id responseCache))cache success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 有网YES, 无网:NO
 */
+ (BOOL)isNetwork;
@end
