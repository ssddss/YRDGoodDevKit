//
//  YRDUpLoadFileObject.m
//  YRDGoodArc
//
//  Created by yurongde on 16/8/22.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YRDUpLoadFileObject.h"
@interface YRDUpLoadFileObject()
@property (nonatomic) NSDictionary *memeTypes;
@end
@implementation YRDUpLoadFileObject
- (NSString *)getMemeTypeStr {
    return self.memeTypes[@(self.fileMemeType)];
}
- (NSDictionary *)memeTypes {
    return @{@(YRDUploadFileTypePNGImage):@"image/png",@(YRDUploadFileTypeTXT):@"txt",@(YRDUploadFileTypeStream):@"application/octet-stream"};
}
@end
