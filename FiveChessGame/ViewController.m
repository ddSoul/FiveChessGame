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

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *x;
@property (strong, nonatomic) IBOutlet UITextField *y;
- (IBAction)add:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)add:(UIButton *)sender {
    
    CGFloat pointX = [self.x.text floatValue];
    CGFloat pointY = [self.y.text floatValue];
    if ([[PlayData shareDataManager] addPoint:CGPointMake(pointX, pointY) atRole:mine]) {
        NSLog(@"数据添加成功");
        if ([[PlayManager shareManager] finalWinAtRole:mine]) {
            NSLog(@"赢了啊 哈哈哈哈");
        }
    }
}
@end
