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

static const CGFloat left_padding = 20.0f;
static const CGFloat top_padding = 100.0f;
static const CGFloat line_width = 1.0f;
static const CGFloat item_width = 30.0f;
static const CGFloat chess_width = 20.0f;

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

    int itemCount = (ScreenWidth - 2*left_padding)/item_width;
    int horLineCount = itemCount + 1;
    CGFloat pWidth = itemCount * item_width;
    
    for (int i = 0; i<horLineCount; i++) {
        UIView *_lineView = [[UIView alloc] initWithFrame:CGRectMake(left_padding, top_padding + i*item_width, pWidth, line_width)];
        _lineView.backgroundColor = [UIColor redColor];
        [self addSubview:_lineView];
    }
    
    for (int i = 0; i<horLineCount; i++) {
        UIView *_lineView = [[UIView alloc] initWithFrame:CGRectMake(left_padding+ i*item_width, top_padding, line_width, pWidth)];
        _lineView.backgroundColor = [UIColor redColor];
        [self addSubview:_lineView];
    }
    
    for (int i = 0; i<itemCount*itemCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i + 100;
        button.backgroundColor = [UIColor clearColor];
        button.layer.cornerRadius = 10;
        button.frame = CGRectMake(0, 0, chess_width, chess_width);
        button.center = CGPointMake(left_padding+i%itemCount*item_width, top_padding+i/itemCount*item_width);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    UIButton *rePlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rePlayButton.backgroundColor = [UIColor brownColor];
    [rePlayButton setTitle:@"rePlay" forState:UIControlStateNormal];
    rePlayButton.frame = CGRectMake(0, ScreenHeight-40, ScreenWidth, 40);
    [rePlayButton addTarget:self action:@selector(rePlayButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rePlayButton];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.backgroundColor = [UIColor grayColor];
    [backButton setTitle:@"back" forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 20, ScreenWidth, 40);
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
