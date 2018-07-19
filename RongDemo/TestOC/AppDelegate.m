//
//  AppDelegate.m
//  TestOC
//
//  Created by 钱立新 on 2017/5/13.
//  Copyright © 2017年 钱立新. All rights reserved.
//

#import "AppDelegate.h"
#import <RongIMKit/RongIMKit.h>
#import "AllURLHeader.h"
@interface AppDelegate () <RCIMConnectionStatusDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setUpRCSDK];
    return YES;
}
- (void)setUpRCSDK{
    
    // 生产
    [[RCIM sharedRCIM] initWithAppKey:@"vnroth0kr9y0o"];
    
//    /**启聊推送*/
//    _receive = [[ReceiveMessageViewController alloc] init];
//    [RCIM sharedRCIM].receiveMessageDelegate = _receive;
    
    
    /**启聊连接监听*/
    [RCIM sharedRCIM].connectionStatusDelegate = self;
    
    /**群组|讨论组的@*/
    [RCIM sharedRCIM].enableMessageMentioned = YES;
    
    /**消息多端同步*/
    [RCIM sharedRCIM].enableSyncReadStatus = YES;
    
    /**消息阅读回执*/
    [RCIM sharedRCIM].enabledReadReceiptConversationTypeList =       @[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP)];
    
    /**撤回*/
    [RCIM sharedRCIM].enableMessageRecall = YES;
    [RCIM sharedRCIM].maxRecallDuration = 120;
    
    [RCIM sharedRCIM].enableSyncReadStatus = YES;
}


/**
 *  网络状态变化。
 *
 *  @param status 网络状态。
 */
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
#ifndef __OPTIMIZE__
#else
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
  
    } else if (status == ConnectionStatus_TOKEN_INCORRECT) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[RCloudLoginManager sharedRCloudManager] loginRCServer];
        });
    }
#endif
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
