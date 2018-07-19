//  NET.m
//  TestOC
//
//  Created by 钱立新 on 15/10/28.
//  Copyright © 2015年 钱立新. All rights reserved.
//

#import "NET.h"
#import "AFNetworking.h"
#import "PPNetworkHelper.h"
#import <YYKit/UIDevice+YYAdd.h>
#import "AllURLHeader.h"
@implementation NET

+ (BOOL)isNetwork {
    return [PPNetworkHelper isNetwork];
}

+ (void)modeView {
    [PPNetworkHelper cancelAllRequest];
}

+ (void)forceUpdate {
   
}

+ (void)gotoLogonView {
  
}
+ (NSDictionary *)requestWithMethod:(NSString *)method URLStr:(NSString *)URLString parameters:(id)parameters {
    
    /**
     modify LHL

     old version token request without header,replace original request and add the head method ect.
     */
    dispatch_semaphore_t disp = dispatch_semaphore_create(0);
    __block id responseData;
    NSString *aURL = [self dealNormalUrl:URLString];
    [PPNetworkHelper GET:aURL parameters:nil success:^(id responseObject) {
        responseData = responseObject;
        dispatch_semaphore_signal(disp);

    } failure:^(NSError *error) {
        responseData = nil;
        dispatch_semaphore_signal(disp);

    }];
    dispatch_semaphore_wait(disp, DISPATCH_TIME_FOREVER);

    if (responseData) {
        return [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    }else{
        return nil;
    }
//    NSURL *url = [NSURL URLWithString:URLString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    __block NSData *takenData;
//    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        takenData = data;
//        dispatch_semaphore_signal(disp);
//    }];
//    [task resume];
//    dispatch_semaphore_wait(disp, DISPATCH_TIME_FOREVER);
//    if (!takenData) return nil;
//    return [NSJSONSerialization JSONObjectWithData:takenData options:NSJSONReadingMutableContainers error:nil];
    
}

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *aURL = [self dealNormalUrl:URLString];

    [PPNetworkHelper GET:aURL parameters:parameters?:@{} success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        NSLog(@"error:%ld,%@",(long)error.code,error.localizedDescription);
        if ([error.localizedDescription containsString:@"(401)"]) {
            NSLog(@"88888888888888888888888cooekie失效");
            [self gotoLogonView];
            return ;
        }
        if ([error.localizedDescription containsString:@"(503)"]) {
            NSLog(@"系统升级中。。。");
            [self modeView];
            return ;
        }
        
        if (failure) {
            failure(error);
        }
        
    }];
}

+ (void)POST:(NSString *)URLString parameters:(id)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *aURL = [self dealNormalUrl:URLString];

    [PPNetworkHelper POST:aURL parameters:parameter?:@{} success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if ([error.localizedDescription containsString:@"(401)"]) {
            [self gotoLogonView];
            return ;
        }
        if ([error.localizedDescription containsString:@"(503)"]) {
            NSLog(@"系统升级中。。。");
            [self modeView];
            return ;
        }
        if (failure) {
            NSLog(@"error:%@",error);
            failure(error);
        }
    }];
}
+ (void)UploadPic:(NSString *)URLSting parameter:(id)parameters uploadParam:(NSArray *)uploadParams success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    /*[PPNetworkHelper uploadImagesWithURL:URLSting parameters:parameters name:<#(NSString *)#> images:<#(NSArray<UIImage *> *)#> fileNames:<#(NSArray<NSString *> *)#> imageScale:<#(CGFloat)#> imageType:<#(NSString *)#> progress:<#^(NSProgress *progress)progress#> success:<#^(id responseObject)success#> failure:<#^(NSError *error)failure#>];*/
}

+ (void)Upload:(NSString *)URLSting parameter:(id)parameters uploadParam:(NSArray*)uploadParams success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    // 设置请求的超时时间
    sessionManager.requestSerializer.timeoutInterval = 30.f;
    // 设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    NSString *aURL = [self dealNormalUrl:URLSting];

    [sessionManager POST:aURL parameters:parameters?:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (UploadParam *uploadParam in uploadParams) {
            [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.uploadType];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if ([error.localizedDescription containsString:@"(401)"]) {
            [self gotoLogonView];
            return ;
        }
        if ([error.localizedDescription containsString:@"(503)"]) {
            NSLog(@"系统升级中。。。");
            [self modeView];
            return ;
        }
        
        failure ? failure(error) : nil;
        
    }];
}

+ (void)Delete:(NSString *)urlString parameter:(id)paramer success:(void (^)(id))success failure:(void (^)(NSError*))failure {
    NSString *aURL = [self dealNormalUrl:urlString];

    [PPNetworkHelper DELETE:aURL parameters:paramer?:@{} success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if ([error.localizedDescription containsString:@"(401)"]) {
            [self gotoLogonView];
            return ;
        }
        if ([error.localizedDescription containsString:@"(503)"]) {
            NSLog(@"系统升级中。。。");
            [self modeView];
            return ;
        }
        if (failure) {
            NSLog(@"error:%@",error);
            failure(error);
        }
    }];
}

+ (void)Put:(NSString *)urlString parameter:(id)paramer success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *aURL = [self dealNormalUrl:urlString];

    [PPNetworkHelper PUT:aURL parameters:paramer?:@{} success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if ([error.localizedDescription containsString:@"(401)"]) {
            [self gotoLogonView];
            return ;
        }
        if ([error.localizedDescription containsString:@"(503)"]) {
            NSLog(@"系统升级中。。。");
            [self modeView];
            return ;
        }
        if (failure) {
            NSLog(@"error:%@",error);
            failure(error);
        }
        
    }];
}

+ (void)Down:(NSString *)urlString parameter:(id)paramer fileName:(NSString*)fileName success:(void (^)(NSString *filePath))success failure:(void (^)(NSError *error))failure {
    NSString *aURL = [self dealNormalUrl:urlString];

    [PPNetworkHelper downloadWithURL:aURL fileDir:fileName progress:^(NSProgress *progress) {
        
    } success:^(NSString *filePath) {
        if (success) {
            success(filePath);
        }
    } failure:^(NSError *error) {
        if ([error.localizedDescription containsString:@"(401)"]) {
            [self gotoLogonView];
            return ;
        }
        if ([error.localizedDescription containsString:@"(503)"]) {
            NSLog(@"系统升级中。。。");
            [self modeView];
            return ;
        }
        if (failure) {
            NSLog(@"error:%@",error);
            failure(error);
        }
        
    }];
}

+(void)GET:(NSString*)URLString parameters:(id)parameters responseCache:(void(^)(id responseCache))cache success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    NSString *aURL = [self dealNormalUrl:URLString];

    [PPNetworkHelper GET:aURL parameters:parameters?:@{} responseCache:^(id responseCache) {
        cache(responseCache);
    } success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        NSLog(@"error:%ld,%@",(long)error.code,error.localizedDescription);
        if ([error.localizedDescription containsString:@"(401)"]) {
            NSLog(@"88888888888888888888888cooekie失效");
            [self gotoLogonView];
            return ;
        }
        if ([error.localizedDescription containsString:@"(503)"]) {
            NSLog(@"系统升级中。。。");
            [self modeView];
            return ;
        }
        
        if (failure) {
            failure(error);
        }
        
    }];
}

+(void)POST:(NSString*)URLString parameters:(id)parameters responseCache:(void(^)(id responseCache))cache success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    NSString *aURL = [self dealNormalUrl:URLString];

    [PPNetworkHelper POST:aURL parameters:parameters?:@{} responseCache:^(id responseCache) {
        cache(responseCache);
    } success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        NSLog(@"error:%ld,%@",(long)error.code,error.localizedDescription);
        if ([error.localizedDescription containsString:@"(401)"]) {
            NSLog(@"88888888888888888888888cooekie失效");
            [self gotoLogonView];
            return ;
        }
        if ([error.localizedDescription containsString:@"(503)"]) {
            NSLog(@"系统升级中。。。");
            [self modeView];
            return ;
        }
        
        if (failure) {
            failure(error);
        }
        
    }];
}

+ (NSString *)dealNormalUrl:(NSString *)urlStr {
    return [urlStr containsString:@"//"]?urlStr:[NSString stringWithFormat:@"%@%@",BaseURL,urlStr];
}
@end
