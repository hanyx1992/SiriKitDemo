//
//  XYUserInfo.m
//  invoker
//
//  Created by 韩元旭 on 2017/5/16.
//  Copyright © 2017年 韩元旭. All rights reserved.
//

#import "XYUserInfo.h"

@implementation XYUserInfo

+ (NSArray<XYUserInfo *> *)userList {
    
    XYUserInfo *me  = [[XYUserInfo alloc] init];
    me.name         = @"韩元旭";
    me.icon         = @"11437126";
    me.address      = @"hanyuanxu@icourt.cc";
    
    XYUserInfo *yf  = [[XYUserInfo alloc] init];
    yf.name         = @"帆哥";
    yf.icon         = @"https://www.baidu.com/img/baidu_jgylogo3.gif";
    yf.address      = @"yangfan@icourt.cc";
    
    XYUserInfo *fc  = [[XYUserInfo alloc] init];
    fc.name         = @"鱼橙";
    fc.icon         = @"fish";
    fc.address      = @"fishcheng@icourt.cc";
    
    XYUserInfo *yc  = [[XYUserInfo alloc] init];
    yc.name         = @"余橙";
    yc.icon         = @"16649995";
    yc.address      = @"yucheng@icourt.cc";
    
    XYUserInfo *ly  = [[XYUserInfo alloc] init];
    ly.name         = @"兰洋";
    ly.icon         = @"https://www.baidu.com/img/baidu_jgylogo3.gif";
    ly.address      = @"lanyang@icourt.cc";
    
    XYUserInfo *sj  = [[XYUserInfo alloc] init];
    sj.name         = @"世佳";
    sj.icon         = @"https://www.baidu.com/img/baidu_jgylogo3.gif";
    sj.address      = @"qiaoshijia@icourt.cc";
    
    XYUserInfo *ky  = [[XYUserInfo alloc] init];
    ky.name         = @"开洋";
    ky.icon         = @"https://www.baidu.com/img/baidu_jgylogo3.gif";
    ky.address      = @"shenkaiyang@icourt.cc";
    
    XYUserInfo *qx  = [[XYUserInfo alloc] init];
    qx.name         = @"祁翔";
    qx.icon         = @"https://www.baidu.com/img/baidu_jgylogo3.gif";
    qx.address      = @"qixiang@icourt.cc";
    
    XYUserInfo *jy  = [[XYUserInfo alloc] init];
    jy.name         = @"江岩";
    jy.icon         = @"https://www.baidu.com/img/baidu_jgylogo3.gif";
    jy.address      = @"lijiangyan@icourt.cc";
    
    return @[me, yf, fc, yc, ly, sj, ky, qx, jy];
}

+ (XYUserInfo *)userInfoNamed:(NSString *)name {
    
    if (!name.length) {
        return nil;
    }
    
    for (XYUserInfo *info in [self userList]) {
        if ([info.name isEqualToString:name]) {
            return info;
        }
    }
    
    return nil;
    
}

@end
