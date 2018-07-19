//
//  ChatViewController.m
//  TestOC
//
//  Created by 林 on 16/2/29.
//  Copyright © 2016年 安元. All rights reserved.
//


#import "ChatViewController.h"
#import "PersonSourceManager.h"
#import "AccountTool.h"
#import "NET.h"
#import <YYKit/NSObject+YYAdd.h>
#import <YYKit/YYImageCoder.h>
#import "UIView+WebCache.h"
#import "MJExtension.h"
#import "AccountTool.h"
#import "UIImageView+WebCache.h"
#import "DptGroupInfoManager.h"
#import "PersonSourceManager.h"
#import <RongIMLib/RCImageMessage.h>




@interface ChatViewController ()

@property (nonatomic, assign) NSUInteger imageCellIndex;


/**
  当前长按message的Model
 */
@property (nonatomic,strong)RCMessageModel *menuModel;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.enableUnreadMessageIcon = YES;
    self.enableNewComingMessageIcon = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[RCIMClient sharedRCIMClient] clearMessagesUnreadStatus:self.conversationType targetId:self.targetId];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}


- (void)openPersonInfo {
    [self didTapCellPortrait:self.targetId];
}

@end



