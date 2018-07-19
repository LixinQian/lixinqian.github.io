//
//  ConversationViewController.m
//  TestOC
//
//  Created by 林 on 16/2/15.
//  Copyright © 2016年 钱立新. All rights reserved.
//

#import "ConversationListViewController.h"
#import "NET.h"
#import "PersonSourceManager.h"
#import "ChatViewController.h"
#import "DptGroupInfoManager.h"

#import "NET.h"
#import "PersonInfoModel.h"
#import "MJExtension.h"
#import <YYKit/NSAttributedString+YYText.h>
#import "AllURLHeader.h"

@interface ConversationListViewController () <RCIMUserInfoDataSource, RCIMGroupInfoDataSource, RCIMGroupMemberDataSource>

@property (nonatomic, strong) PersonSourceManager *personMgr;
@property (nonatomic, strong) DptGroupInfoManager *dptGroupMgr;


@end

@implementation ConversationListViewController

- (void)viewDidLoad {
    //重写显示相关的接口，必须先调用super，否则会屏蔽SDK默认的处理
    [super viewDidLoad];
    [self setupBaseCfg];
    [self personMgr];
    [self dptGroupMgr];
}


- (NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource{
   return [super willReloadTableData:dataSource];
}

// 配置基本显示
- (void)setupBaseCfg {
    
    self.conversationListTableView.tableFooterView = [UIView new];
    [RCIM sharedRCIM].globalConversationAvatarStyle=RC_USER_AVATAR_CYCLE;
    [RCIM sharedRCIM].globalMessageAvatarStyle=RC_USER_AVATAR_CYCLE;
    
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [[RCIM sharedRCIM] setGroupInfoDataSource:self];
    [[RCIM sharedRCIM] setGroupMemberDataSource:self];
    
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_GROUP)]];
    
}


- (PersonSourceManager *)personMgr {
    
    if (_personMgr == nil) {
        _personMgr = [PersonSourceManager sharedPersonSourceManager];
    }
    return _personMgr;
    
}

- (DptGroupInfoManager *)dptGroupMgr {
    
    if (_dptGroupMgr == nil) {
        _dptGroupMgr = [DptGroupInfoManager sharedPersonSourceManager];
    }
    return _dptGroupMgr;
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    
    ChatViewController *chatVC = [[ChatViewController alloc]init];
    chatVC.conversationType = model.conversationType;
    chatVC.targetId = model.targetId;
    

    if (model.conversationType == 3) {
        DptGroupInfoModel *infoModel = [self.dptGroupMgr getDptGroupInfoByGroupId:model.targetId];
        chatVC.title = infoModel?infoModel.groupName:model.conversationTitle;
    } else {
        chatVC.title = model.conversationTitle;
    }
    [self.navigationController pushViewController:chatVC animated:YES];
}


/**
 通过 userID 获取用户信息

 @param userId     userId
 @param completion 回调
 */
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion {

    [self.personMgr getPersonDataByImId:userId block:^(PersonInfoModel *infoModel) {
        if (infoModel) {

            RCUserInfo *Info = [[RCUserInfo alloc] initWithUserId:infoModel.imUserId name:infoModel.realName portrait:infoModel.avatar];
            [[RCIM sharedRCIM] refreshUserInfoCache:Info withUserId:userId];
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(Info);
                });
            }
        } else {
            RCUserInfo *user = [RCUserInfo new];
            user.userId = userId;
            user.name = [NSString stringWithFormat:@"name: %@", userId];
            user.portraitUri = nil;
            
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(user);
                });
            }
            [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_PRIVATE targetId:userId];
        }
    }];
}

- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *groupInfo))completion {
    
    if (![groupId hasPrefix:@"PR_"]) {
        DptGroupInfoModel *infoModel = [self.dptGroupMgr getDptGroupInfoByGroupId:groupId];
        if (infoModel) {
            RCGroup *info = [[RCGroup alloc] initWithGroupId:infoModel.groupId groupName:infoModel.groupName portraitUri:nil];
            completion(info);
        } else {
            completion(nil);
            [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_GROUP targetId:groupId];
        }
    } else {
        [[DptGroupInfoManager sharedPersonSourceManager] getCustomGroupInfoByGroupId:groupId completion:^(NSUInteger code,RCGroup *groupInfo) {
            completion(groupInfo);
            if (!groupInfo) {//不存在，删除
                [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_GROUP targetId:groupId];
            }
        }];
    }
    
}


- (void)getAllMembersOfGroup:(NSString *)groupId result:(void (^)(NSArray<NSString *> *))resultBlock {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?groupId=%@",getAllGroupMembers,groupId];
    [NET GET:urlStr parameters:nil success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"status"] integerValue] == 1200) {
            NSMutableArray<PersonInfoModel *> *arr = [PersonInfoModel objectArrayWithKeyValuesArray:dict[@"result"][@"users"]];
            NSMutableArray *temArr = [NSMutableArray array];
            [arr enumerateObjectsUsingBlock:^(PersonInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [temArr addObject:obj.imUserId];
            }];
            resultBlock(temArr);
        }else{
           resultBlock(@[]);
        }
    } failure:^(NSError *error) {
         resultBlock(@[]);
    }];
    
}

@end
