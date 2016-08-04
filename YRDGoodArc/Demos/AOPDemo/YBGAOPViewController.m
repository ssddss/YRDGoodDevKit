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
    [self doApiRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setText:(NSString *)text withCount:(NSInteger)count {
    NSLog(@"text:%@ and count:%ld",text,count);
}
- (void)doApiRequest {
    NSLog(@"doApiRequest");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}
- (IBAction)LoginAction:(UIButton *)sender {
    NSLog(@"登录");
}

- (IBAction)playGameAction:(UIButton *)sender {
    NSLog(@"打游戏");
}

- (IBAction)walkMyDogAction:(UIButton *)sender {
    NSLog(@"溜狗");
}
@end
