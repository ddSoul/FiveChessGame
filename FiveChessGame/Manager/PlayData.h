//
//  PlayData.h
//  FiveCheese
//
//  Created by ddSoul on 16/10/18.
//  Copyright © 2016年 null公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MyPoint.h"


@interface PlayData : NSObject

+ (instancetype)shareDataManager;

- (BOOL)addPoint:(CGPoint)coordinate atRole:(Role)role;

- (NSArray *)getPointArrayAtRole:(Role)role;

@end
