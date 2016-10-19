//
//  PlayManager.h
//  FiveCheese
//
//  Created by ddSoul on 16/10/18.
//  Copyright © 2016年 null公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayData.h"
#import "MyPoint.h"

@interface PlayManager : NSObject

+ (instancetype)shareManager;

- (BOOL)finalWinAtPoint:(MyPoint *)point;

@property (nonatomic, assign) BOOL waiting;

@end
