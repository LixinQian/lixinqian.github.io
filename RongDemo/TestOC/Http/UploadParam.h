//
//  UploadParam.h
//  TestOC
//
//  Created by 钱立新 on 15/10/28.
//  Copyright © 2015年 钱立新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadParam : NSObject

/**
 *  上传文件的二进制数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  上传的参数名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  上传到服务器的文件名称
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  上传文件的类型
 */
@property (nonatomic,copy)NSString *uploadType;

@end
