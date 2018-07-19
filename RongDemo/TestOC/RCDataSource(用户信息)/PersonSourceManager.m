//
//  PersonSourceManager.m
//  TestOC
//
//  Created by 林 on 16/2/17.
//  Copyright © 2016年 钱立新. All rights reserved.
//

#import "PersonSourceManager.h"
#import "NET.h"
#import "MJExtension.h"
#import <YYKit/YYDiskCache.h>
#import "AllURLHeader.h"

@interface PersonSourceManager ()

@property (nonatomic, strong) YYDiskCache *cache;

@property (nonatomic, strong) NSArray *tempArray;

@end

@implementation PersonSourceManager

+ (PersonSourceManager *)sharedPersonSourceManager {
    static PersonSourceManager *sharedManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)getDataFromServer {
//    [self.cache removeAllObjects];
}

- (YYDiskCache *)cache {
    if (!_cache) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *Documents = paths[0];
        NSString *chatCache = [Documents stringByAppendingPathComponent:@"cache/chatCache"];
        _cache = [[YYDiskCache alloc] initWithPath:chatCache];
        _cache.ageLimit = 6 * 60 * 60;
    }
    return _cache;
}

- (void)getPersonDataByImId:(NSString *)imId block:(void (^)(PersonInfoModel *))block{
    if ([self.cache containsObjectForKey:imId]) {
        PersonInfoModel *model = [PersonInfoModel objectWithKeyValues:[self.cache objectForKey:imId]];
        block(model);
    } else {
        NSDictionary *parame = @{@"imuserId":imId};
        [NET GET:GetUserInfoByImUserid parameters:parame success:^(id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([dict[@"status"] intValue] == 1200) {
                PersonInfoModel *model = [PersonInfoModel objectWithKeyValues:dict];
                [self.cache setObject:dict forKey:model.userId];
                [self.cache setObject:dict forKey:model.imUserId];
                block(model);
            } else {
                block(nil);
            }
        } failure:^(NSError *error) {
            block(nil);
        }];
    }
}

- (void)getPersonDataByImIds:(NSArray *)imIds block:(void (^)(NSArray<PersonInfoModel *> *))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 1
        NSMutableArray *mutArray = [NSMutableArray array];
        dispatch_group_t downloadGroup = dispatch_group_create(); // 2
        
        for (NSInteger i = 0; i < imIds.count; i++) {
            dispatch_group_enter(downloadGroup); // 3
            [self getPersonDataByImId:imIds[i] block:^(PersonInfoModel *model) {
                if (model) {
                    [mutArray addObject:model];
                }
                dispatch_group_leave(downloadGroup);// 4
            }];
        }
        
        dispatch_group_wait(downloadGroup, DISPATCH_TIME_FOREVER); // 5
        dispatch_async(dispatch_get_main_queue(), ^{ // 6
            block(mutArray);
        });
    });
}



- (void)getPersonDataByUserIds:(NSArray *)userIds block:(void (^)(NSArray<PersonInfoModel *> *))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 1
        NSMutableArray *mutArray = [NSMutableArray array];
        
        dispatch_group_t downloadGroup = dispatch_group_create(); // 2
        
        for (NSInteger i = 0; i < userIds.count; i++) {
            dispatch_group_enter(downloadGroup); // 3
            [self getPersonDataByUserId:userIds[i] block:^(PersonInfoModel *model) {
                if (model) {
                    [mutArray addObject:model];
                }
                dispatch_group_leave(downloadGroup);// 4
            }];
        }
        
        dispatch_group_wait(downloadGroup, DISPATCH_TIME_FOREVER); // 5
        dispatch_async(dispatch_get_main_queue(), ^{ // 6
            block(mutArray);
        });
    });
}

- (void)getPersonDataByUserId:(NSString *)userId block:(void (^)(PersonInfoModel *))block {
    if ([self.cache containsObjectForKey:userId]) {
        PersonInfoModel *model = [PersonInfoModel objectWithKeyValues:[self.cache objectForKey:userId]];
        block(model);
    } else {
        NSDictionary *parame = @{@"userId":userId};
        [NET GET:GetUserInfoURL parameters:parame success:^(id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([dict[@"status"] intValue] == 1200) {
                PersonInfoModel *model = [PersonInfoModel objectWithKeyValues:dict];
                [self.cache setObject:dict forKey:model.userId];
                [self.cache setObject:dict forKey:model.imUserId];
                block(model);
            } else {
                block(nil);
            }
        } failure:^(NSError *error) {
            block(nil);
        }];
    }
}

// 二分法查找
//- (PersonInfoModel *)BinarySearchWithArray:(NSArray *)array andID:(NSString *)ID {
//    int low = 0;
//    int high = (int)array.count - 1;
//    int newID = [[ID substringFromIndex:8] intValue];
//    while (low <= high) {
//        int mid = low + ( (high - low) >> 1);
//        PersonInfoModel *model = array[mid];
//        int newimID = [[model.imUserId substringFromIndex:8] intValue];
//
//        if (newimID < newID) {
//            low = mid + 1;
//        } else if (newimID > newID) {
//            high = mid - 1;
//        } else {
//            return model;
//        }
//    }
//    return nil;
//}

@end
