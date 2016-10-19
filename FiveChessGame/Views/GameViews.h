//
//  GameViews.h
//  FiveChessGame
//
//  Created by ddSoul on 16/10/19.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViews : UIView

@property (nonatomic, copy) void (^chessClickButtonBlock)(UIButton *chessButton);

@property (nonatomic, copy) void (^rePlayButtonBlock)(UIButton *rePlaybutton);

@property (nonatomic, copy) void (^backButtonBlock)(UIButton *backbutton);

@end
