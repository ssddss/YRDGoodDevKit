//
//  NSDictionary+Events.m
//  YRDGoodArc
//
//  Created by yurongde on 16/8/4.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "NSDictionary+Events.h"

@implementation NSDictionary (Events)
+ (NSDictionary *)getEvents {
    return @{
             @"trackedScreens" : @[
                     @{
                         @"class" : @"YBGAOPViewController",
                         @"label" : @"主页"
                         }
                     ],
             @"trackedEvents" : @[
                     @{
                         @"class" : @"YBGAOPViewController",
                         @"selector" : @"doApiRequest",
                         @"label" : @"请求数据 interceptor"
                         },
                     @{
                         @"class" : @"YBGAOPViewController",
                         @"selector" : @"LoginAction:",
                         @"label" : @"login interceptor"
                         },
                     @{
                         @"class" : @"YBGAOPViewController",
                         @"selector" : @"playGameAction:",
                         @"label" : @"playGameAction interceptor"
                         },
                     @{
                         @"class" : @"YBGAOPViewController",
                         @"selector" : @"walkMyDogAction:",
                         @"label" : @"walkMyDogAction interceptor"
                         }
                   
                     ]
             
             };

}
@end
