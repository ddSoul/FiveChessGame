//
//  PlayData.m
//  FiveCheese
//
//  Created by ddSoul on 16/10/18.
//  Copyright © 2016年 null公司. All rights reserved.
//

#import "PlayData.h"


@interface PlayData ()

@property (nonatomic, strong) NSMutableArray *mineMutableArray;
@property (nonatomic, strong) NSMutableArray *otherMutaleArray;

@end

@implementation PlayData

+ (instancetype)shareDataManager
{
    static PlayData *manager = nil;
    
    static dispatch_once_t onec;
    
    dispatch_once(&onec, ^{
        
        manager = [[[self class] alloc] init];
        
    });
    
    return manager;
}

- (BOOL)addMyPoint:(MyPoint *)coordinate
{
    MyPoint *point = [[MyPoint alloc] init];
    point.x = coordinate.x;
    point.y = coordinate.y;
    point.role = coordinate.role;
    if (point.role == mine) {
        [self.mineMutableArray addObject:point];
    }
    return YES;
}

- (NSArray *)getPointArrayAtRole:(Role)role
{
    if (role == mine) {
        return self.mineMutableArray;
    }
    return self.otherMutaleArray;
}

- (void)removePlayManagerData
{
    [self.mineMutableArray removeAllObjects];
    [self.otherMutaleArray removeAllObjects];
}

- (NSMutableArray *)mineMutableArray
{
    if (!_mineMutableArray) {
        _mineMutableArray = @[].mutableCopy;
    }
    return _mineMutableArray;
}

- (NSMutableArray *)_otherMutaleArray
{
    if (!_otherMutaleArray) {
        _otherMutaleArray = @[].mutableCopy;
    }
    return _otherMutaleArray;
}

@end
