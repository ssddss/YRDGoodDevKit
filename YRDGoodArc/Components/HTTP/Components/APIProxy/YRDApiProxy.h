//
//  YRDApiProxy.h
//  YRDGoodArc
//
//  Created by yurongde on 16/5/23.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YRDURLResponse.h"
#import "AFNetworking.h"

typedef void(^YRDCallback)(YRDURLResponse *response);
@interface YRDApiProxy : NSObject
+ (instancetype)sharedInstance;
//Get方法
- (NSInteger)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName httpHeaderFields:(NSDictionary *)headerFields success:(YRDCallback)success fail:(YRDCallback)fail;
//Post方法
- (NSInteger)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName httpHeaderFields:(NSDictionary *)headerFields success:(YRDCallback)success fail:(YRDCallback)fail;
//RestfulGET方法
- (NSInteger)callRestfulGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName httpHeaderFields:(NSDictionary *)headerFields success:(YRDCallback)success fail:(YRDCallback)fail;
//RestfulPOST方法
- (NSInteger)callRestfulPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName httpHeaderFields:(NSDictionary *)headerFields success:(YRDCallback)success fail:(YRDCallback)fail;
//RestfulPUT方法
- (NSInteger)callRestfulPUTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName httpHeaderFields:(NSDictionary *)headerFields success:(YRDCallback)success fail:(YRDCallback)fail;
//RestfulDELETE方法
- (NSInteger)callRestfulDELETEWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName httpHeaderFields:(NSDictionary *)headerFields success:(YRDCallback)success fail:(YRDCallback)fail;



- (void)cancelRequestWithRequestID:(NSNumber *)requestID;

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;


- (NSInteger)downloadTaskWithRequest:(NSURLRequest *)request
                                             progress:( void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                          destination:( NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                    completionHandler:( void (^)(NSURLResponse *response, NSURL * filePath, NSError * error))completionHandler;

- (NSInteger)uploadTaskWithRequest:(NSString *)request
                        parameters:(id)parameters
                        httpHeaderFields:(NSDictionary *)headerFields
         constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                          progress:(void (^)(NSProgress *progress))upProgress
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

@end
