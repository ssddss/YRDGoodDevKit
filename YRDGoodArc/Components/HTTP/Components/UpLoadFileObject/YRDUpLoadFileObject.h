//
//  YRDUpLoadFileObject.h
//  YRDGoodArc
//
//  Created by yurongde on 16/8/22.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, YRDUploadFileType) {
    YRDUploadFileTypePNGImage,
    YRDUploadFileTypeTXT,
    YRDUploadFileTypeStream
};
@interface YRDUpLoadFileObject : NSObject
@property (nonatomic, copy, nonnull) NSString *fileName;/**< 文件名*/
@property (nonatomic, copy, nonnull) NSString *fileUploadKey;/**< 上传的key值*/
@property (nonatomic, assign) YRDUploadFileType fileMemeType;/**< 文件类型*/
@property (nonatomic, nonnull) NSData *fileData;/**< 文件内容*/

/**
 *  获取meme type
 *
 *  @return 
 */
- (nonnull NSString *)getMemeTypeStr;
@end
