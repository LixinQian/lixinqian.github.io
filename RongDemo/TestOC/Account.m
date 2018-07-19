//
//  Account.m
//  TestOC
//
//  Created by 钱立新 on 15/11/19.
//  Copyright © 2015年 钱立新. All rights reserved.
//

#import "Account.h"
#import "MJExtension.h"

#define AccountTokenKey @"token"

@interface Account ()


@end
@implementation Account
MJCodingImplementation

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
     return [[self alloc] initWithDic:dict];;
}



@end
