//
//  YBGViewControllerIntercepter.m
//  YRDGoodArc
//
//  Created by yurongde on 16/7/28.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGViewControllerIntercepter.h"
#import <Aspects/Aspects.h>
#import "UINavigationController+FDFullscreenPopGesture.h"

@implementation YBGViewControllerIntercepter
+ (void)load {
    /* + (void)load 会在应用启动的时候自动被runtime调用，通过重载这个方法来实现最小的对业务方的“代码入侵” */
    [super load];
    [YBGViewControllerIntercepter sharedInstance];
}
/*
 
 按道理来说，这个sharedInstance单例方法是可以放在头文件的，但是对于目前这个应用来说，暂时还没有放出去的必要
 
 当业务方对这个单例产生配置需求的时候，就可以把这个函数放出去
 */
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static YBGViewControllerIntercepter *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YBGViewControllerIntercepter alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {

//        hook已经被交换过的方法会有崩溃
        /* 在这里做好方法拦截 */
            //注意要调用 FD的viewillAppear，不然导航显示的时候会有问题
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
            [self viewWillAppear:animated viewController:[aspectInfo instance]];
        } error:NULL];
        [UIViewController aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
            [self viewDidAppear:animated viewController:[aspectInfo instance]];
        } error:NULL];
        [UIViewController aspect_hookSelector:@selector(viewWillDisappear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
            [self viewWillDisappear:animated viewController:[aspectInfo instance]];
        }error:NULL];
//        [UITableView aspect_hookSelector:@selector(reloadData) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
//            
//        }error:NULL];
    }
    return self;
}

/*
 各位架构师们，这里就是你们可以发挥聪明才智的地方啦。
 你也可以随便找一个什么其他的UIViewController，只要加入工程中，不需要额外添加什么代码，就可以做到自动拦截了。
 
 所以在你原来的架构中，大部分封装UIViewController的基类或者其他的什么基类，都可以使用这种方法让这些基类消失。
 */
#pragma mark - lifeCycle methods
- (void)loadView:(UIViewController *)viewController
{
    /* 你可以使用这个方法进行打日志，初始化基础业务相关的内容 */
    NSLog(@"[%@ loadView]", [viewController class]);
    viewController.view.backgroundColor = [UIColor yellowColor];
}
- (void)viewWillAppear:(BOOL)animated viewController:(UIViewController *)viewController
{
    //注意：一定要调用这个方法，让FDFullScreen执行他的方法才能让导航条的隐藏状态正常显示
    [viewController fd_viewWillAppear:animated];
//    如果是框架继承的BaseController才打印东西
    Class ybgClazz = NSClassFromString(@"YBGBaseViewController");
    if ([viewController isKindOfClass:ybgClazz]) {
        /* 你可以使用这个方法进行打日志，初始化基础业务相关的内容 */
        NSLog(@"pageId=%@",[viewController valueForKey:@"pageId"]);
        NSLog(@"[%@ viewWillAppear:%@]", [viewController class], animated ? @"YES" : @"NO");
    }
    
}
- (void)viewDidAppear:(BOOL)animated viewController:(UIViewController *)viewController
{
    /* 你可以使用这个方法进行打日志，初始化基础业务相关的内容 */
    NSLog(@"[%@ viewDidAppear:%@]", [viewController class], animated ? @"YES" : @"NO");
}
- (void)viewWillDisappear:(BOOL)animated viewController:(UIViewController *)viewController
{
    /* 你可以使用这个方法进行打日志，初始化基础业务相关的内容 */
    NSLog(@"[%@ viewWillDisappear:%@]", [viewController class], animated ? @"YES" : @"NO");
}

@end
