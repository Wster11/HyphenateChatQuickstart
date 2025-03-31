//
//  ViewController.m
//  HyphenateChatQuickstart
//
//  Created by stwang on 2025/3/31.
//

#import "ViewController.h"
#import <HyphenateChat/HyphenateChat.h>

@interface ViewController ()

@property (nonatomic, strong) UIButton *testButton; // 添加按钮属性
@property (nonatomic, strong) UIButton *sendMessageButton; // 添加按钮属性

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建按钮
    self.testButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.testButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.testButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置按钮frame
    self.testButton.frame = CGRectMake(100, 100, 200, 44);
    
    // 添加到视图
    [self.view addSubview:self.testButton];
    
    self.sendMessageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.sendMessageButton setTitle:@"发送消息" forState:UIControlStateNormal];
    [self.sendMessageButton addTarget:self action:@selector(messageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.sendMessageButton.frame = CGRectMake(100, 200, 200,44);
    [self.view addSubview: self.sendMessageButton];
}

// 按钮点击事件处理
- (void)buttonClicked:(UIButton *)sender {
    [[EMClient sharedClient] loginWithUsername:@"yjj"
                                      password:@"yjj"
                                    completion:^(NSString *aUsername, EMError *aError) {
        if (!aError) {
            NSLog(@"登录成功");
        } else {
            NSLog(@"登录失败: %@", aError.errorDescription);
        }
    }];
}

- (void)messageButtonClicked: (UIButton *)sender{
    // 创建消息
    EMTextMessageBody* textBody = [[EMTextMessageBody alloc] initWithText:@"hello"];
    EMChatMessage *message = [[EMChatMessage alloc] initWithConversationID:@"sttest"
                                                                      from:@"yjj"
                                                                        to:@"sttest"
                                                                      body:textBody
                                                                       ext:@{}];
    // 发送消息
    [[EMClient sharedClient].chatManager sendMessage:message progress:nil completion:^(EMChatMessage *message, EMError *error) {
        if(!error){
            NSLog(@"发送成功");
        }else{
            NSLog(@"发送失败: %@", error.errorDescription);
        }
    }];
}

@end
