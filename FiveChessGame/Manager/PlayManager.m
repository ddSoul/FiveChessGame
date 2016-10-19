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

- (BOOL)finalWinAtPoint:(MyPoint *)point
{
    NSArray *_myPointArray = [[PlayData shareDataManager] getPointArrayAtRole:point.role];
    
    if (_myPointArray.count < 5) {
        return NO;
    }
    
    NSArray *_horizontalCoordinateArray = [self getHorizontalcoordinateAtPoint:point ofAllPoint:_myPointArray];
    NSArray *_verticalCoordinateArray = [self getverticallcoordinateAtPoint:point ofAllPoint:_myPointArray];
    NSArray *_45CoordinateArray = [self get45coordinateAtPoint:point ofAllPoint:_myPointArray];
    NSArray *_135CoordinateArray = [self get135coordinateAtPoint:point ofAllPoint:_myPointArray];
    
    return [self equeToSub:_horizontalCoordinateArray] ||
            [self equeToSub:_verticalCoordinateArray] ||
            [self equeToSub:_45CoordinateArray] ||
            [self equeToSub:_135CoordinateArray];
    
}

//取新添加点所在行的所有坐标的X值，返回一个数组
- (NSArray *)getHorizontalcoordinateAtPoint:(MyPoint *)point ofAllPoint:(NSArray *)allPointArray
{
    NSMutableArray *_tempArray = @[].mutableCopy;
    for (MyPoint *value in allPointArray) {
        if (value.y == point.y) {
            [_tempArray addObject:[NSString stringWithFormat:@"%f",value.x]];
        }
    }
    return _tempArray;
}

//取新添加点所在咧所有坐标的Y值，返回一个数组
- (NSArray *)getverticallcoordinateAtPoint:(MyPoint *)point ofAllPoint:(NSArray *)allPointArray
{
    NSMutableArray *_tempArray = @[].mutableCopy;
    for (MyPoint *value in allPointArray) {
        if (value.x == point.x) {
            [_tempArray addObject:[NSString stringWithFormat:@"%f",value.y]];
        }
    }
    return _tempArray;
}

//取新添加点所在45°线上的坐标，返回一个数组(可以只判断X轴或者Y轴)
- (NSArray *)get45coordinateAtPoint:(MyPoint *)point ofAllPoint:(NSArray *)allPointArray
{
    NSMutableArray *_tempArray = @[].mutableCopy;
    for (MyPoint *value in allPointArray) {
        if ((value.x - point.x) == (value.y - point.y)) {
            [_tempArray addObject:[NSString stringWithFormat:@"%f",value.x]];
        }
    }
    return _tempArray;
}

//取新添加点所在135°线上的坐标，返回一个数组(可以只判断X轴或者Y轴)
- (NSArray *)get135coordinateAtPoint:(MyPoint *)point ofAllPoint:(NSArray *)allPointArray
{
    NSMutableArray *_tempArray = @[].mutableCopy;
    for (MyPoint *value in allPointArray) {
        if ((value.x - point.x) == (point.y - value.y)) {
            [_tempArray addObject:[NSString stringWithFormat:@"%f",value.x]];
        }
    }
    return _tempArray;

}

//等差判断
- (BOOL)equeToSub:(NSArray *)array
{
    int count = 0;
    
    //数组内坐标排序??排序会出错？什么原因
//    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
//    
//    NSArray *sortArray = [NSArray arrayWithObjects:descriptor,nil];
//    
//    NSArray *sortedArray = [array sortedArrayUsingDescriptors:sortArray];
    
    NSComparator finderSort = ^(id string1,id string2){
        
        if ([string1 integerValue] > [string2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }else if ([string1 integerValue] < [string2 integerValue]){
            return (NSComparisonResult)NSOrderedAscending;
        }
        else
            return (NSComparisonResult)NSOrderedSame;
    };
    
    //数组排序：
    NSArray *resultArray = [array sortedArrayUsingComparator:finderSort];
    
    
    for (int i = 0; i < resultArray.count -1 ; i++) {
        
        // ==?这个值更具自己的坐标系来写
            if (([resultArray[i+1] intValue] - [resultArray[i] intValue]) == 30) {
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
