//
//  YBGAOPViewController.h
//  YRDGoodArc
//
//  Created by yurongde on 16/7/28.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBGAOPViewController : UIViewController
- (void)setText:(NSString *)text withCount:(NSInteger)count;
- (void)doApiRequest;

- (IBAction)LoginAction:(UIButton *)sender;
- (IBAction)playGameAction:(UIButton *)sender;
- (IBAction)walkMyDogAction:(UIButton *)sender;

@end
