//
//  IntentViewController.m
//  SiriExtensionUI
//
//  Created by 韩元旭 on 2017/5/15.
//  Copyright © 2017年 韩元旭. All rights reserved.
//

#import "IntentViewController.h"
#import <Intents/Intents.h>
#import "XYHeader.pch"

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

@interface IntentViewController () <INUIHostedViewSiriProviding>

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *sectionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *msgBgView;
@property (weak, nonatomic) IBOutlet UIImageView *toIconView;

@end

@implementation IntentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - INUIHostedViewControlling

// Prepare your view controller for the interaction to handle.
- (void)configureWithInteraction:(INInteraction *)interaction context:(INUIHostedViewContext)context completion:(void (^)(CGSize))completion {
    // Do configuration here, including preparing views and calculating a desired size for presentation.
    
    //  获取发送消息的意图
    INSendMessageIntent *intent = (INSendMessageIntent *)(interaction.intent);
    NSString *name = [[intent.recipients lastObject] displayName];
    NSString *content = intent.content;
    NSString *icon = [XYUserInfo userInfoNamed:name].icon;
    
    NSLog(@"发送内容:%@", content);
    
    //  展示内容
    
    //  设置自身头像
    self.iconView.image = [UIImage imageNamed:[[XYUserInfo userList] firstObject].icon];
    self.toIconView.image = [UIImage imageNamed:icon];
    
    //  标题
    self.sectionTitleLabel.text = [NSString stringWithFormat:@"和\"%@\"对话", name];
    //  内容
    self.msgContentLabel.text = content;
    
     // 显示与隐藏
    self.sectionTitleLabel.hidden = !name.length;
    self.msgContentLabel.hidden = !content.length;
    self.msgBgView.hidden = !content.length;
    self.toIconView.hidden = !self.toIconView.image;
    
    //  获取错误信息
//    NSUserActivity *activity = interaction.intentResponse.userActivity;
    
    //  处理,并返回大小
    if (completion) {
        completion(CGSizeMake([self desiredSize].width, 150));
    }
}

- (CGSize)desiredSize {
    return [self extensionContext].hostedViewMaximumAllowedSize;
}

#pragma mark - INUIHostedViewSiriProviding

- (BOOL)displaysMessage {
    return YES;
}

@end
