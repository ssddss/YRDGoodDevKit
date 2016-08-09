//
//  YRDServiceFactory.m
//  YRDGoodArc
//
//  Created by yurongde on 16/5/23.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YRDServiceFactory.h"
#import "YRDNetworkingConfiguration.h"


NSString *const kYRDServiceChangable = @"ChangableServiceUrl";
@interface YRDServiceFactory()
    
@property (nonatomic, strong) NSCache *serviceStorage;

@end
@implementation YRDServiceFactory
#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static YRDServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YRDServiceFactory alloc] init];
    });
    return sharedInstance;
}
#pragma mark - public methods
- (YRDService<YRDServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier
{
    if ([self.serviceStorage objectForKey:identifier] == nil) {
        [self.serviceStorage setObject:[self newServiceWithIdentifier:identifier]
                                forKey:identifier];
    }
    return [self.serviceStorage objectForKey:identifier];
}

#pragma mark - private methods
- (YRDService<YRDServiceProtocal> *)newServiceWithIdentifier:(NSString *)identifier
{
    //一定要提供service的类名
    if (identifier.length==0) {
        NSException *exception = [[NSException alloc] init];
        @throw exception;

        return nil;
    }
//    根据service的类名动态创建
    Class serviceClazz = NSClassFromString(identifier);
    return [[serviceClazz alloc]init];
 
}

#pragma mark - getters and setters
- (NSCache *)serviceStorage
{
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSCache alloc] init];
        _serviceStorage.countLimit = 5; // 我在这里随意定了一个，具体的值还是要取决于各自App的要求。
    }
    return _serviceStorage;
}
@end
