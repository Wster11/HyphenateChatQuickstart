//
//  ViewController.m
//  HyphenateChatQuickstart
//
//  Created by stwang on 2025/3/31.
//

#import "ViewController.h"
#import <HyphenateChat/HyphenateChat.h>

@interface ViewController ()<EMChatManagerDelegate>

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
    
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
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

- (void)messagesDidReceive:(NSArray *)aMessages
{
    // 收到消息，遍历消息列表。
    for (EMChatMessage *message in aMessages) {
        if (message.body.type==EMMessageBodyTypeText) {
            // 确认是文本消息后，可以将消息体转换为文本消息体类型
            EMTextMessageBody *textBody = (EMTextMessageBody *)message.body;
            // 获取文本消息内容
            NSString *text = textBody.text;
            
            NSLog(@"收到文本消息: %@", text);
            NSLog(@"发送者: %@", message.from);
            NSLog(@"会话ID: %@", message.conversationId);
        }
    }
}

// 移除代理。

- (void)dealloc
{
    [[EMClient sharedClient].chatManager removeDelegate:self];
}

@end
