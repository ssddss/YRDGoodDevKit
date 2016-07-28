//
//  YBGAOPViewController.m
//  YRDGoodArc
//
//  Created by yurongde on 16/7/28.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGAOPViewController.h"

@interface YBGAOPViewController ()

@end

@implementation YBGAOPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setText:@"haha" withCount:4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setText:(NSString *)text withCount:(NSInteger)count {
    NSLog(@"text:%@ and count:%ld",text,count);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
