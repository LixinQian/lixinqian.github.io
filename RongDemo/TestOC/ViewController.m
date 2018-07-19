//
//  ViewController.m
//  TestOC
//
//  Created by 钱立新 on 2017/5/13.
//  Copyright © 2017年 钱立新. All rights reserved.
//

#import "ViewController.h"
#import "ConversationListViewController.h"
#import "NET.h"
#import "AccountTool.h"
#import "RCloudLoginManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)pushView:(id)sender {
    [self loginHandle];
}

- (void)loginHandle {
   
    //网络请求
    [AccountTool accountWithLoginName:@"admin_pretest" passWord:@"11111111" success:^(NSNumber *succ, id data, id verify) {
        if ([succ isEqual:@200]) {
            NSLog(@"登录返回的数据描述：%@",data);
            if ([verify isEqual:@1]) {
               
            }else{
                Account *acc = [AccountTool account];
                RCloudLoginManager * rclm = [RCloudLoginManager sharedRCloudManager];
                [rclm removeToken];
                [rclm loginRCServerWithUserId:acc.userId];
                dispatch_async(dispatch_get_main_queue(), ^{
                    ConversationListViewController *tabBarVC = [ConversationListViewController new];
                    [self.navigationController pushViewController:tabBarVC animated:YES];
                });
            }
            
        }else if([succ isEqual:@402]){
            return ;
        }
    } failure:^(NSError *error) {
        return ;
    }];
    
}
@end
