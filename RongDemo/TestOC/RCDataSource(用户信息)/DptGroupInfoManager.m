//
//  DptGroupInfoManager.m
//  TestOC
//
//  Created by 林 on 16/3/2.
//  Copyright © 2016年 安元. All rights reserved.
//

#import "DptGroupInfoManager.h"
#import "NET.h"
#import "MJExtension.h"
#import <YYKit/YYDiskCache.h>
#import <RongIMLib/RCGroup.h>
#import <YYKit/NSString+YYAdd.h>
#import "AllURLHeader.h"

@interface DptGroupInfoManager ()

@property (nonatomic, strong) NSMutableArray *allDptGroupModel;
@property (nonatomic, strong) YYDiskCache *cache;

@end

@implementation DptGroupInfoManager

+ (DptGroupInfoManager *)sharedPersonSourceManager {
    static DptGroupInfoManager *sharedManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManager = [[self alloc] init];
        [sharedManager getAllDptGroupInfo];
    });
    return sharedManager;
}

- (NSArray *)allGroupInfo {
    return self.allDptGroupModel;
}

- (void)getAllDptGroupInfo {
    NSDictionary *lastPerson = [[[NSUserDefaults standardUserDefaults] valueForKey:@"lastPerson"] jsonValueDecoded];
    if (lastPerson) {
        NSDictionary *currentPerso = [[[NSUserDefaults standardUserDefaults] valueForKey:@"QYC_UserInfo"] jsonValueDecoded];
        NSString *lastEnt = lastPerson[@"entId"];
        NSString *currentEnt = currentPerso[@"entId"];
        if ([lastEnt isEqualToString:currentEnt]) {
            if ([lastPerson[@"userId"] isEqualToString:currentPerso[@"userId"]]) {
                NSMutableArray *array = (NSMutableArray *)[self.cache objectForKey:@"dptGroupArray"];
                if (array) {
                    _allDptGroupModel = array;
                    return;
                }
            }
        }
    }
    [self getDataFromServer];

}

- (void)getDataFromServer {
    [NET GET:GetAllDptGroupinfo parameters:nil success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"status"] intValue] == 1200) {
            NSArray *deparments = dict[@"deparments"];
            NSArray *group = [deparments valueForKey:@"group"];
            self.allDptGroupModel = [DptGroupInfoModel objectArrayWithKeyValuesArray:group];
            [self.cache setObject:self.allDptGroupModel forKey:@"dptGroupArray"];
        }else if ([dict[@"status"] integerValue] == 2101) {
            return;
        }
    } failure:^(NSError *error) {
        
    }];
}

- (DptGroupInfoModel *)getDptGroupInfoByGroupId:(NSString *)groupId {
    for (int i = 0; i < self.allDptGroupModel.count; i++) {
        DptGroupInfoModel *model = self.allDptGroupModel[i];
        if ([groupId isEqualToString:model.groupId]) {
            return model;
        }
    }
    return nil;
}

- (void)getCustomGroupInfoByGroupId:(NSString *)groupId completion:(void (^)(NSUInteger code, RCGroup *groupInfo))completion {
  RCGroup *group = (RCGroup *)[self.cache objectForKey:[NSString stringWithFormat:@"group_%@",groupId]];
    if (group) {
        completion(1200,group);
    }else {
        [NET GET:getCustomGroupInfo parameters:@{@"groupId":groupId,@"needUser":@1} success:^(id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([dict[@"status"] integerValue] == 200) {
                if ([dict[@"code"] integerValue] == 1200) {
                    NSDictionary *groupInfo = dict[@"result"];
                    RCGroup *group = [[RCGroup alloc]initWithGroupId:groupId groupName:groupInfo[@"groupName"] portraitUri:nil];
                    [self.cache setObject:group forKey:[NSString stringWithFormat:@"group_%@",groupId]];
                    completion(1200,group);
                } else {
                    completion(0,nil);
                }
            }else if ([dict[@"code"] integerValue] == 1100) {
                completion(1100,nil);
            }else {
                completion(0,nil);
            }
        } failure:^(NSError *error) {
            completion(0,nil);
        }];
    }
}

- (YYDiskCache *)cache {
    if (!_cache) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _cache = [[YYDiskCache alloc] initWithPath:paths[0]];
        _cache.ageLimit = 3 * 60 * 60;
    }
    return _cache;
}


@end
