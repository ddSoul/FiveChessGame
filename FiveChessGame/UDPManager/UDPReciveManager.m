//
//  UDPReciveManager.m
//  FiveChessGame
//
//  Created by 邓西亮 on 16/10/19.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "UDPReciveManager.h"
#import "PlayManager.h"

static AsyncUdpSocket *reciveSocket;
static NSMutableArray *driverIPList;
static NSInteger deveiceTag;

@implementation UDPReciveManager

+(UDPReciveManager *)shareManager{
    
    static UDPReciveManager *manager = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        manager = [[[self class] alloc] init];
        
        driverIPList = [NSMutableArray array];
        
        deveiceTag =0;
        
    });
    return manager;
}

-(void)setSendMessage{
    
    reciveSocket = [[AsyncUdpSocket alloc] initIPv4];
    [reciveSocket setDelegate: self];
    [reciveSocket bindToPort:8005 error:nil];
    [reciveSocket receiveWithTimeout:-1 tag:1];
    
    
}

- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port{
    
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString *IPAdress = [host componentsSeparatedByString:@"::ffff:"].lastObject;
    
    if ([IPAdress isEqualToString:[IPHelper deviceIPAdress]]) {
        //过滤来自本机的消息
        //继续监听接收消息
        [reciveSocket receiveWithTimeout:-1 tag:0];
        return YES;
    }
    NSLog(@"收到 %s %ld %@ %d ++++++%@",__FUNCTION__,tag,host,port,dataString);
    
    //收到消息后，自己可以走棋
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"waiting"];
    
    if([dataString rangeOfString:@"soul"].location != NSNotFound && [dataString rangeOfString:@"win"].location ==NSNotFound)//_roaldSearchText
    {
        NSString *btnTagString;
        btnTagString = [dataString substringFromIndex:4];//截取掉
        [self.delegate reciveTag:btnTagString];

    }else if ([dataString rangeOfString:@"win"].location !=NSNotFound){
        [self.delegate noticationWin];
    }
    
    [reciveSocket receiveWithTimeout:-1 tag:0];
    
    return YES;
}

@end
