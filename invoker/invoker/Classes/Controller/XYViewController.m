//
//  XYViewController.m
//  invoker
//
//  Created by 韩元旭 on 2017/5/16.
//  Copyright © 2017年 韩元旭. All rights reserved.
//

#import "XYViewController.h"

@interface XYViewController ()

@end

@implementation XYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)change:(UIButton *)sender {

    //  不支持
    if (![UIApplication sharedApplication].supportsAlternateIcons) {
        return ;
    }
    
    //  获取图标名称, 原始图标为 nil
    NSString *iconName = [[UIApplication sharedApplication] alternateIconName];
    
    if (iconName) {
        
        //  设置过图标了.还原,nil为原始图标
        [[UIApplication sharedApplication] setAlternateIconName:nil completionHandler:nil];
        
    } else {
        
        //  没有设置图标,设置新图标
        [[UIApplication sharedApplication] setAlternateIconName:@"newIcon" completionHandler:nil];
        
    }
}

@end
