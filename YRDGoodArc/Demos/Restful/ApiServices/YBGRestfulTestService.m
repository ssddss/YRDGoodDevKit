//
//  YBGRestfulTestService.m
//  YRDGoodArc
//
//  Created by yurongde on 16/8/8.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGRestfulTestService.h"

@implementation YBGRestfulTestService
#pragma mark - AIFServiceProtocal
- (BOOL)isOnline
{
    return YES;
}

- (NSString *)onlineApiBaseUrl
{
    return @"http://192.168.151.107:8080";
}

- (NSString *)onlineApiVersion
{
    return @"";
}

- (NSString *)onlinePrivateKey
{
    return @"";
}

- (NSString *)onlinePublicKey
{
    return @"";
}

- (NSString *)offlineApiBaseUrl
{
    return self.onlineApiBaseUrl;
}

- (NSString *)offlineApiVersion
{
    return self.onlineApiVersion;
}

- (NSString *)offlinePrivateKey
{
    return self.onlinePrivateKey;
}

- (NSString *)offlinePublicKey
{
    return self.onlinePublicKey;
}

@end
