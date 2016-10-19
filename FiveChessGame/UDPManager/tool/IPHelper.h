//
//  HYBIPHelper.h
//  httpServer
//
//  Created by lifubing on 16/3/2.
//  Copyright © 2016年 lifubing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPHelper : NSObject

+ (NSString *)deviceIPAdress; //获取设备局域网中IP地址
+ (NSString *)deviceMAKAdress;//获取mak地址
@end
