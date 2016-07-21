//
//  SDSubject.h
//  MVVMWithDataController
//
//  Created by yurongde on 16/1/26.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBGBaseModel.h"
@interface SDSubject : YBGBaseModel
@property (nonatomic, strong, nullable) NSString *subjectId;
@property (nonatomic, strong, nullable) NSString *subjectName;
@property (nonatomic, copy, nullable) NSString *xxmc;

@end
