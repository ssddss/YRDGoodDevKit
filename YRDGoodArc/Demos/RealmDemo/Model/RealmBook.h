//
//  RealmBook.h
//  YRDGoodArc
//
//  Created by yurongde on 16/6/21.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <Realm/Realm.h>

@interface RealmBook : RLMObject
@property NSString *name;
@property NSInteger bookId;
@property float price;
@property NSString *publish;
@end
