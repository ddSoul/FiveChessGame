//
//  UDPSendManager.h
//  FiveChessGame
//
//  Created by ddSoul on 16/10/19.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncUdpSocket.h"
#import "IPHelper.h"
#import "DeveiceDataModel.h"
#import "NetWorkHelper.h"

@interface UDPSendManager : NSObject<AsyncUdpSocketDelegate>

+(UDPSendManager *)shareManager;

-(void)sendManagerWith:(NSString *)str WithIP:(NSString *)IP;

-(void)sendFirstManagerWith;

@end
