//
//  GameViews.h
//  FiveChessGame
//
//  Created by ddSoul on 16/10/19.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViews : UIView

/**
 * 点击棋子处理
 */
@property (nonatomic, copy) void (^chessClickButtonBlock)(UIButton *chessButton);

/**
 * 重新开局处理
 */
@property (nonatomic, copy) void (^rePlayButtonBlock)(UIButton *rePlaybutton);

/**
 * 返回处理
 */
@property (nonatomic, copy) void (^backButtonBlock)(UIButton *backbutton);

@end
