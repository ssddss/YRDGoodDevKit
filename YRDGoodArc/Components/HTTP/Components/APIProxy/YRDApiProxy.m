//
//  YRDApiProxy.m
//  YRDGoodArc
//
//  Created by yurongde on 16/5/23.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YRDApiProxy.h"
#import "YRDServiceFactory.h"
#import "YRDRequestGenerator.h"
#import "YRDLogger.h"
#import "NSURLRequest+YRDNetworkingMethods.h"
#import "NSDictionary+YRDNetworkingMethods.h"

static NSString * const kYRDApiProxyDispatchItemKeyCallbackSuccess = @"kYRDApiProxyDispatchItemCallbackSuccess";
static NSString * const kYRDApiProxyDispatchItemKeyCallbackFail = @"kYRDApiProxyDispatchItemCallbackFail";
@interface YRDApiProxy ()

@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@property (nonatomic, strong) NSNumber *recordedRequestId;

//AFNetworking stuff
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end
@implementation YRDApiProxy
#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static YRDApiProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YRDApiProxy alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (NSInteger)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName httpHeaderFields:(NSDictionary *)headerFields success:(YRDCallback)success fail:(YRDCallback)fail
{
    NSURLRequest *request = [[YRDRequestGenerator sharedInstance] generateGETRequestWithServiceIdentifier:servieIdentifier requestParams:params httpHeaderFields:headerFields methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName httpHeaderFields:(NSDictionary *)headerFields success:(YRDCallback)success fail:(YRDCallback)fail
{
    NSURLRequest *request = [[YRDRequestGenerator sharedInstance] generatePOSTRequestWithServiceIdentifier:servieIdentifier requestParams:params httpHeaderFields:headerFields methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callRestfulGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName httpHeaderFields:(NSDictionary *)headerFields success:(YRDCallback)success fail:(YRDCallback)fail
{
    NSURLRequest *request = [[YRDRequestGenerator sharedInstance] generateRestfulGETRequestWithServiceIdentifier:servieIdentifier requestParams:params httpHeaderFields:headerFields methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callRestfulPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName httpHeaderFields:(NSDictionary *)headerFields success:(YRDCallback)success fail:(YRDCallback)fail
{
    NSURLRequest *request = [[YRDRequestGenerator sharedInstance] generateRestfulPOSTRequestWithServiceIdentifier:servieIdentifier requestParams:params httpHeaderFields:headerFields methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}
- (NSInteger)callRestfulPUTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName httpHeaderFields:(NSDictionary *)headerFields success:(YRDCallback)success fail:(YRDCallback)fail
{
    NSURLRequest *request = [[YRDRequestGenerator sharedInstance] generateRestfulPUTRequestWithServiceIdentifier:servieIdentifier requestParams:params httpHeaderFields:headerFields methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}
- (NSInteger)callRestfulDELETEWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName httpHeaderFields:(NSDictionary *)headerFields success:(YRDCallback)success fail:(YRDCallback)fail
{
    NSURLRequest *request = [[YRDRequestGenerator sharedInstance] generateRestfulDELETERequestWithServiceIdentifier:servieIdentifier requestParams:params httpHeaderFields:headerFields methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}
- (void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    NSURLSessionTask *task = self.dispatchTable[requestID];

    [task cancel];

    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList
{
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}

#pragma mark - private methods
/** 这个函数存在的意义在于，如果将来要把AFNetworking换掉，只要修改这个函数的实现即可。 */
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(YRDCallback)success fail:(YRDCallback)fail
{
    NSLog(@"\n==================================\n\nRequest Start: \n\n %@\n\n==================================", request.URL);
    
    // 跑到这里的block的时候，就已经是主线程了。
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSNumber *requestID = @([dataTask taskIdentifier]);

        NSURLSessionDataTask *storedTask = self.dispatchTable[requestID];
        if (storedTask == nil) {
            // 如果这个operation是被cancel的，那就不用处理回调了。
            NSLog(@"\n==================================\n\nRequest Cancel: \n\n %@\n\n==================================", request.URL);
            
            return;
        }else{
            [self.dispatchTable removeObjectForKey:requestID];
        }

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSData *responseData = responseObject;
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        if (error) {
            [YRDLogger logDebugInfoWithResponse:httpResponse
                                 resposeString:responseString
                                       request:request
                                         error:error];
            YRDURLResponse *YRDResponse = [[YRDURLResponse alloc] initWithResponseString:responseString requestId:requestID request:request responseData:responseData error:error];
            fail?fail(YRDResponse):nil;
        } else {
            // 检查http response是否成立。
            [YRDLogger logDebugInfoWithResponse:httpResponse
                                 resposeString:responseString
                                       request:request
                                         error:NULL];
            YRDURLResponse *YRDResponse = [[YRDURLResponse alloc] initWithResponseString:responseString requestId:requestID request:request responseData:responseData status:YRDURLResponseStatusSuccess];
            success?success(YRDResponse):nil;
        }
    }];
    
    NSNumber *requestId = @([dataTask taskIdentifier]);
    
    self.dispatchTable[requestId] = dataTask;
    [dataTask resume];
    
    return requestId;

}
- (NSInteger)downloadTaskWithRequest:(NSURLRequest *)request
                            progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                         destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                   completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler {
      NSLog(@"\n==================================\n\nDownloadRequest Start: \n\n %@\n\n==================================", request.URL);
    __block NSURLSessionDownloadTask *downLoadTask = nil;
    downLoadTask = [self.sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"正在下载requestPath:%@ :%lld/%lld",request.URL.absoluteString,downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
        downloadProgressBlock(downloadProgress);
    } destination:destination completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSNumber *requestID = @([downLoadTask taskIdentifier]);
        
        NSURLSessionDownloadTask *storedTask = self.dispatchTable[requestID];
        if (storedTask == nil) {
            // 如果这个operation是被cancel的，那就不用处理回调了。
            NSLog(@"\n==================================\n\nDownloadRequest Cancel: \n\n %@\n\n==================================", request.URL);
            
            return;
        }else{
            [self.dispatchTable removeObjectForKey:requestID];
        }
        NSLog(@"\n==================================\n\nDownloadRequest Finish: \n\n %@\n\n==================================", request.URL);

        completionHandler(response,filePath,error);

    }];
    
    NSNumber *requestId = @([downLoadTask taskIdentifier]);
    self.dispatchTable[requestId] = downLoadTask;
    [downLoadTask resume];
    return  [requestId integerValue];
}
- (NSInteger)uploadTaskWithRequest:(NSString *)request parameters:(id)parameters httpHeaderFields:(NSDictionary *)headerFields constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block progress:(void (^)(NSProgress *))upProgress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSLog(@"\n==================================\n\nUploadRequest Start: \n\n %@\n\n==================================", request);
    
    __block NSURLSessionDataTask *upLoadTask = nil;
    upLoadTask = [self POST:request parameters:parameters httpHeaderFields:(NSDictionary *)headerFields constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        block(formData);
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {

        upProgress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSNumber *requestID = @([upLoadTask taskIdentifier]);
        
        [self.dispatchTable removeObjectForKey:requestID];
        
        NSLog(@"\n==================================\n\nUploadRequest Finish: \n\n %@\n\n==================================", request);
        id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];

        success(task,response);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSNumber *requestID = @([upLoadTask taskIdentifier]);
        
        NSURLSessionDownloadTask *storedTask = self.dispatchTable[requestID];
        if (storedTask == nil) {
            // 如果这个operation是被cancel的，那就不用处理回调了。
            NSLog(@"\n==================================\n\nUploadRequest Cancel: \n\n %@\n\n==================================", request);
            
            return;
        }else{
            [self.dispatchTable removeObjectForKey:requestID];
        }
        
        failure(task,error);

    }];
    
    NSNumber *requestId = @([upLoadTask taskIdentifier]);
    self.dispatchTable[requestId] = upLoadTask;
    return  [requestId integerValue];

}

/**
 *  这个跟AFNetworking里的是一样的，搬了过来，因为我们的接口要对request的http头加字段
 *
 *  @param URLString      <#URLString description#>
 *  @param parameters     <#parameters description#>
 *  @param block          <#block description#>
 *  @param uploadProgress <#uploadProgress description#>
 *  @param success        <#success description#>
 *  @param failure        <#failure description#>
 *
 *  @return <#return value description#>
 */
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                    httpHeaderFields:(NSDictionary *)headerFields
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                      progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSError *serializationError = nil;
    
    NSMutableURLRequest *request = [self.sessionManager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:nil] absoluteString] parameters:parameters constructingBodyWithBlock:block error:&serializationError];
    
    //header参数，以后要往headerfields里填写参数才能访问接口
    NSMutableDictionary *httpHeaderFields = [[[YRDRequestGenerator sharedInstance]requestHeaderTokenParams] mutableCopy];
    [httpHeaderFields addEntriesFromDictionary:headerFields];
    [httpHeaderFields enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    
    
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.sessionManager.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *task = [self.sessionManager uploadTaskWithStreamedRequest:request progress:uploadProgress completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
    
    [task resume];
    
    return task;
}

/**
 *  原来用来生成请求id的，现在用dataTask的taskId
 *
 *  @return <#return value description#>
 */
- (NSNumber *)generateRequestId
{
    if (_recordedRequestId == nil) {
        _recordedRequestId = @(1);
    } else {
        if ([_recordedRequestId integerValue] == NSIntegerMax) {
            _recordedRequestId = @(1);
        } else {
            _recordedRequestId = @([_recordedRequestId integerValue] + 1);
        }
    }
    return _recordedRequestId;
}
#pragma mark - getters and setters
- (NSMutableDictionary *)dispatchTable
{
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _sessionManager;
}

@end
