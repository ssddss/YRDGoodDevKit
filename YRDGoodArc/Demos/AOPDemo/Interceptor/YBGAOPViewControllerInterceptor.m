//
//  YBGAOPViewControllerInterceptor.m
//  YRDGoodArc
//
//  Created by yurongde on 16/8/4.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGAOPViewControllerInterceptor.h"
#import "NSDictionary+Events.h"
#import <Aspects/Aspects.h>
#import "YBGAOPViewController.h"

@implementation YBGAOPViewControllerInterceptor
+ (void)load {
    /* + (void)load 会在应用启动的时候自动被runtime调用，通过重载这个方法来实现最小的对业务方的“代码入侵” */
    [super load];
    [YBGAOPViewControllerInterceptor sharedInstance];
}
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static YBGAOPViewControllerInterceptor *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YBGAOPViewControllerInterceptor alloc] init];
    });
    return sharedInstance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //        hook已经被交换过的方法会有崩溃
        /* 在这里做好方法拦截 */
        [self setupWithConfiguration:[NSDictionary getEvents]];
        
    }
    return self;
}
- (void)setupWithConfiguration:(NSDictionary *)configuration
{
    [YBGAOPViewController aspect_hookSelector:@selector(loadView) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
        [self loadView:[aspectInfo instance]];
    } error:NULL];
    // screen views tracking
    for (NSDictionary *trackedScreen in configuration[@"trackedScreens"]) {
        Class clazz = NSClassFromString(trackedScreen[@"class"]);
        
        [clazz aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
            
            NSString *viewName = trackedScreen[@"label"];
            [self logPage:viewName];
        } error:NULL];

        
    }
    
    // events tracking
    for (NSDictionary *trackedEvents in configuration[@"trackedEvents"]) {
        Class clazz = NSClassFromString(trackedEvents[@"class"]);
        SEL selektor = NSSelectorFromString(trackedEvents[@"selector"]);
        [clazz aspect_hookSelector:selektor withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
            NSString *eventName = trackedEvents[@"label"];
            [self logEvent:eventName];
        } error:NULL];

        
    }
}
- (void)loadView:(UIViewController *)viewController
{
    /* 你可以使用这个方法进行打日志，初始化基础业务相关的内容 */
    NSLog(@"[%@ loadView]", [viewController class]);
    viewController.view.backgroundColor = [UIColor yellowColor];
}
- (void)logPage:(NSString *)pageId {
    NSLog(@"page=%@",pageId);
}
- (void)logEvent:(NSString *)event {
    NSLog(@"event%@",event);
}
@end
