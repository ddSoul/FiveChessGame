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

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define view_scal (ScreenWidth/1242)

@interface GameViewController ()

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI
{
    GameViews *views = [[GameViews alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:views];
    views.chessClickButtonBlock = ^(UIButton *btn){
        NSLog(@"____你点击的位置X:%f,Y:%f",btn.center.x,btn.center.y);

        if (btn.selected == NO) {
            btn.backgroundColor = [UIColor blackColor];
            btn.selected = YES;
            
            MyPoint *point = [[MyPoint alloc] init];
            point.x = btn.center.x;
            point.y = btn.center.y;
            point.role = mine;
            
            
            if ([[PlayData shareDataManager] addMyPoint:point]) {
                NSLog(@"棋子坐标添加");
                
                if ([[PlayManager shareManager] finalWinAtPoint:point]) {
                    NSLog(@"赢了");
                    [self win];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
