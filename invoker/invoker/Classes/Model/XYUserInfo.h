//
//  XYUserInfo.h
//  invoker
//
//  Created by 韩元旭 on 2017/5/16.
//  Copyright © 2017年 韩元旭. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 用户模型
 */
@interface XYUserInfo : NSObject

/**
 名称
 */
@property (nonatomic, copy) NSString *name;

/**
 头像
 */
@property (nonatomic, copy) NSString *icon;

/**
 地址
 */
@property (nonatomic, copy) NSString *address;


/**
 测试数据返回用户列表
 */
+ (NSArray<XYUserInfo *> *)userList;

/**
 返回名称对应的用户信息
 */
+ (XYUserInfo *)userInfoNamed:(NSString *)name;

@end
