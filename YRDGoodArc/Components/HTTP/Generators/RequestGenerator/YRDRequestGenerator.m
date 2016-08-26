//
//  YRDRequestGenerator.m
//  YRDGoodArc
//
//  Created by yurongde on 16/5/23.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YRDRequestGenerator.h"
#import "YRDSignatureGenerator.h"
#import "YRDServiceFactory.h"
#import "YRDCommonParamsGenerator.h"
#import "NSDictionary+YRDNetworkingMethods.h"
#import "YRDNetworkingConfiguration.h"
#import "NSObject+YRDNetworkingMethods.h"
#import <AFNetworking/AFNetworking.h>
#import "YRDService.h"
#import "NSObject+YRDNetworkingMethods.h"
#import "YRDLogger.h"
#import "NSURLRequest+YRDNetworkingMethods.h"

#import "RSA.h"
#import "YBGRequestParamsTool.h"

@interface YRDRequestGenerator ()
@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end
@implementation YRDRequestGenerator
#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static YRDRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YRDRequestGenerator alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    YRDService *service = [[YRDServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    
    NSMutableDictionary *sigParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    sigParams[@"api_key"] = service.publicKey;
    NSString *signature = [YRDSignatureGenerator signGetWithSigParams:sigParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey publicKey:service.publicKey];
    
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[YRDCommonParamsGenerator commonParamsDictionary]];
    [allParams addEntriesFromDictionary:sigParams];
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?%@&sig=%@", service.apiBaseUrl, service.apiVersion, methodName, [allParams YRD_urlParamsStringSignature:NO], signature];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:nil error:NULL];
    request.timeoutInterval = kYRDNetworkingTimeoutSeconds;
    request.requestParams = requestParams;
    [YRDLogger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"GET"];
    return request;
}

- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    YRDService *service = [[YRDServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *signature = [YRDSignatureGenerator signPostWithApiParams:requestParams privateKey:service.privateKey publicKey:service.publicKey];
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?api_key=%@&sig=%@&%@", service.apiBaseUrl, service.apiVersion, methodName, service.publicKey, signature, [[YRDCommonParamsGenerator commonParamsDictionary] YRD_urlParamsStringSignature:NO]];
    
    NSURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:requestParams error:NULL];
    request.requestParams = requestParams;
    [YRDLogger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"POST"];
    return request;
}
- (NSURLRequest *)generateRestfulGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[YRDCommonParamsGenerator commonParamsDictionary]];
    [allParams addEntriesFromDictionary:requestParams];
    
    YRDService *service = [[YRDServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *signature = [YRDSignatureGenerator signRestfulGetWithAllParams:allParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey];
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?%@", service.apiBaseUrl, service.apiVersion, methodName, [allParams YRD_urlParamsStringSignature:NO]];
    
    NSDictionary *restfulHeader = [self commRESTHeadersWithService:service signature:signature];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:kYRDNetworkingTimeoutSeconds];
    request.HTTPMethod = @"GET";
    [restfulHeader enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];

    request.requestParams = requestParams;
    [YRDLogger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"RESTful GET"];
    return request;
}


- (NSURLRequest *)generateRestfulPOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    YRDService *service = [[YRDServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
//    设备的参数信息,及其他的参数
    NSDictionary *commonParams = [YRDCommonParamsGenerator commonParamsDictionary];
    
    //最终参数
    NSMutableDictionary *finalRequstParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    [finalRequstParams addEntriesFromDictionary:commonParams];

    NSString *signature = [YRDSignatureGenerator signRestfulPOSTWithApiParams:requestParams commonParams:commonParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey];
//    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?&%@", service.apiBaseUrl, service.apiVersion, methodName, [commonParams YRD_urlParamsStringSignature:NO]];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];

    NSDictionary *restfulHeader = [self commRESTHeadersWithService:service signature:signature];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:kYRDNetworkingTimeoutSeconds];
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:nil error:NULL];
    [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
//    request.HTTPMethod = @"POST";
    [request setTimeoutInterval:kYRDNetworkingTimeoutSeconds];
    [restfulHeader enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    if (finalRequstParams) {
//        request.HTTPBody =[NSJSONSerialization dataWithJSONObject:finalRequstParams options:NSJSONWritingPrettyPrinted error:NULL];
        NSData *paramsNSData = [NSJSONSerialization dataWithJSONObject:finalRequstParams options:NSJSONWritingPrettyPrinted error:NULL];
        NSString *jsonParamsStr = [[NSString alloc]initWithData:paramsNSData encoding:NSUTF8StringEncoding];
        NSString *rsaEncryptStr = [RSA encryptString:jsonParamsStr publicKey:[YBGRequestParamsTool sharedRequestParamsTool].RSAEncryptionPublicKey];
        
        NSData *contentData = [rsaEncryptStr dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPBody = contentData;
    }
    request.requestParams = requestParams;
    [YRDLogger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"RESTful POST"];
    return request;
}
- (NSURLRequest *)generateRestfulPUTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    YRDService *service = [[YRDServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSDictionary *commonParams = [YRDCommonParamsGenerator commonParamsDictionary];
    NSString *signature = [YRDSignatureGenerator signRestfulPOSTWithApiParams:requestParams commonParams:commonParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey];
    //    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?&%@", service.apiBaseUrl, service.apiVersion, methodName, [commonParams YRD_urlParamsStringSignature:NO]];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];
    
    NSDictionary *restfulHeader = [self commRESTHeadersWithService:service signature:signature];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:kYRDNetworkingTimeoutSeconds];
    request.HTTPMethod = @"PUT";
    [restfulHeader enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    if (requestParams) {
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:NSJSONWritingPrettyPrinted error:NULL];
        
    }
    request.requestParams = requestParams;
    [YRDLogger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"RESTful PUT"];
    return request;
}
- (NSURLRequest *)generateRestfulDELETERequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    YRDService *service = [[YRDServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSDictionary *commonParams = [YRDCommonParamsGenerator commonParamsDictionary];
    NSString *signature = [YRDSignatureGenerator signRestfulPOSTWithApiParams:requestParams commonParams:commonParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey];
    //    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?&%@", service.apiBaseUrl, service.apiVersion, methodName, [commonParams YRD_urlParamsStringSignature:NO]];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];
    
    NSDictionary *restfulHeader = [self commRESTHeadersWithService:service signature:signature];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:kYRDNetworkingTimeoutSeconds];
    request.HTTPMethod = @"DELETE";
    [restfulHeader enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    if (requestParams) {
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:NSJSONWritingPrettyPrinted error:NULL];
    }
    request.requestParams = requestParams;
    [YRDLogger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"RESTful DELETE"];
    return request;
}
#pragma mark - private methods
- (NSDictionary *)commRESTHeadersWithService:(YRDService *)service signature:(NSString *)signature
{
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
//    [headerDic setValue:signature forKey:@"sig"];
//    [headerDic setValue:service.publicKey forKey:@"key"];
    //要使用到的token
    [headerDic setValue:@"12345" forKey:@"token"];
    [headerDic setValue:@"123" forKey:@"Asym-Key"];
//    [headerDic setValue:@"application/json" forKey:@"Accept"];
//    [headerDic setValue:@"application/json" forKey:@"Content-Type"];
   
    return headerDic;
}
#pragma mark - public methods
- (NSDictionary *)requestHeaderTokenParams {
    return @{@"token":@"12345"};
}
#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer {
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kYRDNetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;

}
@end
