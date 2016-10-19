//
//  UDPSendManager.m
//  FiveChessGame
//
//  Created by ddSoul on 16/10/19.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "UDPSendManager.h"
#import <UIKit/UIKit.h>

static AsyncUdpSocket * sendSouket;

@implementation UDPSendManager

+(UDPSendManager *)shareManager{
    
    static UDPSendManager *manager = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        manager = [[[self class] alloc] init];
        
        sendSouket = [[AsyncUdpSocket alloc]initWithDelegate:self];
        
        [sendSouket enableBroadcast:TRUE error:nil];
        
        [sendSouket bindToPort:3333 error:nil];
        
//        [sendSouket joinMulticastGroup:@"255.255.255.255" error:nil];
        
    });
    return manager;
    
}
-(void)SendManagerWith:(NSString *)str WithIP:(NSString *)IP{
    
    
    NSString * newStr = [[NSString alloc]initWithFormat:@"soul%@",str];
    
    if ([sendSouket sendData:[newStr dataUsingEncoding:NSUTF8StringEncoding]
                      toHost:IP  port:8005 withTimeout:-1 tag:1]) {
        NSLog(@"发送成功");
        
    }else{
        NSLog(@"失败发送");
    }
    
    
    
}
-(void)SendFirstManagerWith{
    
    NSString *str = [NSString stringWithFormat:@"firs%@ My IP:%@ myname:%@",[IPHelper deviceMAKAdress],[IPHelper deviceIPAdress],[[UIDevice alloc] init].name];
    
    [sendSouket sendData:[str dataUsingEncoding:NSUTF8StringEncoding]
                  toHost: @"255.255.255.255" port:8005 withTimeout:-1 tag:1];
    
    [sendSouket receiveWithTimeout: -1 tag:1];
    
    if ([sendSouket sendData:[str dataUsingEncoding:NSUTF8StringEncoding]
                      toHost: @"255.255.255.255" port:8005 withTimeout:-1 tag:1]) {
        NSLog(@"发送成功");
        
    }else{
        NSLog(@"失败发送");
    }
    
    NSLog(@"持续搜索中！！");
    
    
}

@end
