//
//  DeveiceDataModel.m
//  scss
//
//  Created by lifubing on 16/3/10.
//  Copyright © 2016年 lifubing. All rights reserved.
//

#import "DeveiceDataModel.h"

@implementation DeveiceDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(id)initWithIP:(NSString *)IP withMakdress:(NSString *)MAKdress withUserName:(NSString *)Name withText:(NSString *)text withTag:(long long)Tag {
    if ([self init]) {
        _IPAdress = IP;
        _imagetag = Tag;
        _UserName = Name;
        _text = text;
        _MAKAdress = MAKdress;
    }
    return self;
}

@end
