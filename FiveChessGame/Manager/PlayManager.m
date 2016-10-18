//
//  PlayManager.m
//  FiveCheese
//
//  Created by ddSoul on 16/10/18.
//  Copyright © 2016年 null公司. All rights reserved.
//

#import "PlayManager.h"

@implementation PlayManager

+ (instancetype)shareManager
{
    static PlayManager *manager = nil;
    
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        
        manager = [[[self class] alloc] init];
        
    });
    
    return manager;
}

- (BOOL)finalWinAtRole:(Role)role
{
    NSArray *_myPointArray = [[PlayData shareDataManager] getPointArrayAtRole:role];
    
    if (_myPointArray.count < 5) {
        return NO;
    }
    return [self horizontalByPointArry:_myPointArray] ||
            [self verticalByPointArry:_myPointArray] ||
            [self slopeByPointArry:_myPointArray];
    
}

//判断横向
- (BOOL)horizontalByPointArry:(NSArray *)pointArray
{
    
    NSMutableArray *_tempArray = @[].mutableCopy;
    for (MyPoint *point in pointArray) {
        
        [_tempArray addObject:[NSString stringWithFormat:@"%f",point.x]];

    }
    return [self equeToSub:_tempArray];
}

//判断竖向
- (BOOL)verticalByPointArry:(NSArray *)pointArray
{
    NSMutableArray *_tempArray = @[].mutableCopy;
    for (MyPoint *point in pointArray) {
        
        [_tempArray addObject:[NSString stringWithFormat:@"%f",point.y]];
        
    }
    return [self equeToSub:_tempArray];

}


//45度判断
- (BOOL)slopeByPointArry:(NSArray *)pointArray
{
    NSMutableArray *_xArray = @[].mutableCopy;
    NSMutableArray *_yArray = @[].mutableCopy;
    
    for (MyPoint *point in pointArray) {
        
        [_xArray addObject:[NSString stringWithFormat:@"%f",point.x]];
        [_yArray addObject:[NSString stringWithFormat:@"%f",point.y]];
        
    }
    return [self equeToSub:_xArray] ||
            [self equeToSub:_yArray];

}


//等差判断
- (BOOL)equeToSub:(NSArray *)array
{
    int count = 0;
    
    //数组内坐标排序
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
    
    NSArray *sortArray = [NSArray arrayWithObjects:descriptor,nil];
    
    NSArray *sortedArray = [array sortedArrayUsingDescriptors:sortArray];
    
    for (int i = 0; i < sortedArray.count -1 ; i++) {
        
            if (([sortedArray[i+1] intValue] - [sortedArray[i] intValue]) == 1) {
                count ++;
                if (count == 4) {
                    return YES;
                }
            }else{
                count = 0;
            }
    }
    return NO;
}



@end
