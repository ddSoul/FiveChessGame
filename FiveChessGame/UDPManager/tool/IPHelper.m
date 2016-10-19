//
//  HYBIPHelper.m
//  httpServer
//
//  Created by lifubing on 16/3/2.
//  Copyright © 2016年 lifubing. All rights reserved.
//

#import "IPHelper.h"
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation IPHelper
+ (NSString *)deviceMAKAdress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    //    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    NSLog(@"outString:%@", outstring);
    
    free(buf);
    
    return [outstring uppercaseString];
}
+ (NSString *)deviceIPAdress {

    NSString *address = @"an error occurred when obtaining ip address";

    struct ifaddrs *interfaces = NULL;

    struct ifaddrs *temp_addr = NULL;

    int success = 0;

    

    success = getifaddrs(&interfaces);

    

    if (success == 0) { // 0 表示获取成功

        

        temp_addr = interfaces;

        while (temp_addr != NULL) {

            if( temp_addr->ifa_addr->sa_family == AF_INET) {

                // Check if interface is en0 which is the wifi connection on the iPhone

                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {

                    // Get NSString from C String

                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];

                }

            }

            

            temp_addr = temp_addr->ifa_next;

        }

    }

    

    freeifaddrs(interfaces);

    return address;

}
@end
