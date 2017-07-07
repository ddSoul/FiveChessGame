//
//  ViewController.m
//  FiveChessGame
//
//  Created by ddSoul on 16/10/18.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "ViewController.h"

#import "PlayData.h"
#import "PlayManager.h"
#import "GameViewController.h"
#import "PlayerListViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *x;
@property (strong, nonatomic) IBOutlet UITextField *y;
- (IBAction)add:(UIButton *)sender;
- (IBAction)paly:(UIButton *)sender;

@end

@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)add:(UIButton *)sender {
    
    CGFloat pointX = [self.x.text floatValue];
    CGFloat pointY = [self.y.text floatValue];
    MyPoint *point = [[MyPoint alloc] init];
    point.x = pointX;
    point.y = pointY;
    point.role = mine;
    
    if ([[PlayData shareDataManager] addMyPoint:point]) {
        NSLog(@"棋子坐标添加");
        
        if ([[PlayManager shareManager] finalWinAtPoint:point]) {
            NSLog(@"赢了");
        }
    }
  }

- (IBAction)paly:(UIButton *)sender {
    
    PlayerListViewController *preVc = [[PlayerListViewController alloc] init];
    [self presentViewController:preVc animated:YES completion:nil];

}


@end
