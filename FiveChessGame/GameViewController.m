//
//  GameViewController.m
//  FiveChessGame
//
//  Created by ddSoul on 16/10/19.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "GameViewController.h"
#import "GameViews.h"
#import "PlayData.h"
#import "PlayManager.h"
#import "UDPSendManager.h"
#import "UDPReciveManager.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define view_scal (ScreenWidth/1242)

@interface GameViewController ()<reciveTagDelegate>

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"waiting"];
    
    [[UDPReciveManager shareManager] setSendMessage];
    [UDPReciveManager shareManager].delegate = self;
    [[UDPSendManager shareManager] SendFirstManagerWith];
    
    [self initUI];
}

#pragma mark - UI
- (void)initUI
{
    GameViews *views = [[GameViews alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:views];
    views.chessClickButtonBlock = ^(UIButton *btn){
        NSLog(@"____你点击的位置X:%f,Y:%f",btn.center.x,btn.center.y);
        
        //如果waiting == NO，自己可以走棋
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"waiting"] == NO) {
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"waiting"];
            
            if (btn.selected == NO) {
                
                btn.backgroundColor = [UIColor blackColor];
                btn.selected = YES;
                
                MyPoint *point = [[MyPoint alloc] init];
                point.x = btn.center.x;
                point.y = btn.center.y;
                point.role = mine;
                
                
                if ([[PlayData shareDataManager] addMyPoint:point]) {
                    NSLog(@"棋子坐标添加");
                    
                    NSString *buttonTagstr = [NSString stringWithFormat:@"%ld",(long)btn.tag];
                    [[UDPSendManager shareManager] SendManagerWith:buttonTagstr WithIP:@"255.255.255.255"];
                    
                    if ([[PlayManager shareManager] finalWinAtPoint:point]) {
                        NSLog(@"赢了");
                        [[UDPSendManager shareManager] SendManagerWith:@"win" WithIP:@"255.255.255.255"];
                        [self win];
                    }
                }
                
            }

        }
        
    };
    
    views.rePlayButtonBlock = ^(UIButton *rePlayButton){
        
        [self rePlay];
    };
    
    views.backButtonBlock = ^(UIButton *backButton){
        [self dismissViewControllerAnimated:YES completion:nil];
    };
}

#pragma mark - mineMethods
- (void)win{
    
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你竟然赢了,重新开始？" preferredStyle:(UIAlertControllerStyleAlert)];

        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            NSLog(@"确定了哈哈哈");
            [self rePlay];
        }];

        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
            NSLog(@"取消了哈哈");
        }];
    
        // 添加按钮 将按钮添加到UIAlertController对象上
        [alertController addAction:sureAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];

    
}
- (void)rePlay{
    
    [[PlayData shareDataManager] removePlayManagerData];
    
    for (int i = 0; i<121; i++) {
        UIButton *tempBtn = (UIButton *)[self.view viewWithTag:i+100];
        tempBtn.backgroundColor = [UIColor clearColor];
        tempBtn.selected = NO;
    }

}

#pragma mark - UDP buttonTap DelegateMethods
- (void)reciveTag:(NSString *)tagString
{
    UIButton *tempBtn = (UIButton *)[self.view viewWithTag:[tagString integerValue]];
    tempBtn.backgroundColor = [UIColor blueColor];
    tempBtn.selected = YES;
    
    MyPoint *point = [[MyPoint alloc] init];
    point.x = tempBtn.center.x;
    point.y = tempBtn.center.y;
    point.role = otherPlayer;

    if ([[PlayData shareDataManager] addMyPoint:point]) {
        NSLog(@"棋子坐标添加");
    }


    NSLog(@"%@",tagString);
    
}
- (void)noticationWin
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"对方赢了，你真菜" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        NSLog(@"确定了哈哈哈");
        [self rePlay];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        NSLog(@"取消了哈哈");
    }];
    
    // 添加按钮 将按钮添加到UIAlertController对象上
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
