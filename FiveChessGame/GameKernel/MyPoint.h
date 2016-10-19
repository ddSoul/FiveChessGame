//
//  MyPoint.h
//  FiveCheese
//
//  Created by ddSoul on 16/10/18.
//  Copyright © 2016年 null公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Role) {
    mine = 0,
    otherPlayer
};

@interface MyPoint : NSObject

@property (nonatomic, assign) double x;
@property (nonatomic, assign) double y;
//玩家角色
@property (nonatomic, assign) Role role;



@end
