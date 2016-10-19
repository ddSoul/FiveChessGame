//
//  UDPReciveManager.h
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

@protocol reciveTagDelegate <NSObject>

- (void)reciveTag:(NSString *)tagString;
- (void)noticationWin;

@end

@interface UDPReciveManager : NSObject<AsyncUdpSocketDelegate>

@property (nonatomic, assign) id <reciveTagDelegate> delegate;

+(UDPReciveManager *)shareManager;

-(void)setSendMessage;


@end
