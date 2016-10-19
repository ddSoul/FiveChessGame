//
//  GameViews.m
//  FiveChessGame
//
//  Created by ddSoul on 16/10/19.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "GameViews.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define view_scal (ScreenWidth/1242)

@interface GameViews ()


@end

@implementation GameViews

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.frame = frame;
        [self createControls];
    }
    return self;
}

/**
 * 创建控件
 */
- (void)createControls
{

    for (int i = 0; i<11; i++) {
        UIView *_lineView = [[UIView alloc] initWithFrame:CGRectMake(35, 150 + i*30, 300, 1)];
        _lineView.backgroundColor = [UIColor redColor];
        [self addSubview:_lineView];
    }
    
    for (int i = 0; i<11; i++) {
        UIView *_lineView = [[UIView alloc] initWithFrame:CGRectMake(35+ i*30, 150, 1, 300)];
        _lineView.backgroundColor = [UIColor redColor];
        [self addSubview:_lineView];
    }
    
    for (int i = 0; i<121; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i + 100;
        button.backgroundColor = [UIColor clearColor];
        button.layer.cornerRadius = 10;
        button.frame = CGRectMake(0, 0, 20, 20);
        button.center = CGPointMake(35+i%11*30, 150+i/11*30);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    UIButton *rePlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rePlayButton.backgroundColor = [UIColor brownColor];
    [rePlayButton setTitle:@"rePlay" forState:UIControlStateNormal];
    rePlayButton.frame = CGRectMake(0, ScreenHeight-80, ScreenWidth, 80);
    [rePlayButton addTarget:self action:@selector(rePlayButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rePlayButton];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.backgroundColor = [UIColor grayColor];
    [backButton setTitle:@"back" forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 20, ScreenWidth, 60);
    [backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    
}

- (void)buttonClick:(UIButton *)btn
{
    if (self.chessClickButtonBlock) {
        self.chessClickButtonBlock(btn);
    }
}

- (void)rePlayButton:(UIButton *)btn{
    
    if (self.rePlayButtonBlock) {
        self.rePlayButtonBlock(btn);
    }
}

- (void)backButton:(UIButton *)btn{
    
    if (self.backButtonBlock) {
        self.backButtonBlock(btn);
    }
}

@end
