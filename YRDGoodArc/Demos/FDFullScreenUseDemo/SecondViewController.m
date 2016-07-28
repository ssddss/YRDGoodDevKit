//
//  SecondViewController.m
//  YRDGoodArc
//
//  Created by yurongde on 16/3/14.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (nonatomic) UIScrollView *scrollView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fd_prefersNavigationBarHidden = YES;
//    self.fd_interactivePopDisabled = YES;
    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 100;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.scrollView];


}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 375, 400)];
        _scrollView.backgroundColor = [UIColor greenColor];
        _scrollView.contentSize = CGSizeMake(500, 400);
        _scrollView.bounces = NO;
    }
    return _scrollView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
