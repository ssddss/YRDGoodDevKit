//
//  YBGHomeViewController.m
//  YRDGoodArc
//
//  Created by yurongde on 16/7/21.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGHomeViewController.h"
#import "SDSubjectsView.h"
#import "YBGHomeDataController.h"
#import "SDHomeSubjectsViewModel.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
#import "SDHomeSubjectsCollectionCellViewModel.h"
@interface YBGHomeViewController ()<SDHomeSubjectsViewDelegate>
@property (nonatomic, strong, nullable) UIScrollView *scrollView;/**<  容器*/
@property (nonatomic, strong, nullable) UIView *contentView;/**< 内容*/

@property (nonatomic, strong, nullable) SDSubjectsView *subjectsView;/**< 底部*/
@property (nonatomic, strong, nonnull) YBGHomeDataController *dataController;/**< 数据获取*/

@end

@implementation YBGHomeViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpContentView];
    
    [self fetchSubjectData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    NSLog(@"dealloc %s",__FUNCTION__);
}
#pragma mark - delegates
#pragma mark - SDHomeSubjectsViewDelegate
- (void)homeSubjectsView:(SDSubjectsView *)subjectView didPressItemAtIndex:(NSInteger)index {
    NSLog(@"%ld",(long)index);
    NSLog(@"%@",subjectView.viewModel.cellViewModels[index]);
    SDSubject *subject = self.dataController.subjects[index];
    subject.xxmc = @"change";
  
    [self renderSubjectView];
}
#pragma mark - Notifications

#pragma mark - event response

#pragma mark - public methods

#pragma mark - private methods
- (void)setUpContentView {
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.subjectsView];
    
    [self layoutPageSubviews];
}
- (void)layoutPageSubviews {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView.mas_width);
    }];
    [self.subjectsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.and.right.equalTo(self.contentView);
        make.height.equalTo(@450);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.subjectsView.mas_bottom);
    }];
}
- (void)fetchSubjectData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak  typeof(self) weakSelf = self;
    [self.dataController requestSubjectDatcWithCallBack:^(NSError * _Nullable error) {
        __strong typeof(self) strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
        if (!error) {
            [strongSelf renderSubjectView];
        }
    }];
}
- (void)renderSubjectView {
    SDHomeSubjectsViewModel *subjectsViewModel = [SDHomeSubjectsViewModel viewModelWithSubjects:self.dataController.subjects];
    [self.subjectsView bindDataWithViewModel:subjectsViewModel];
}

#pragma mark - getters and setters
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
    }
    return _scrollView;
}
- (SDSubjectsView *)subjectsView {
    if (!_subjectsView) {
        _subjectsView = [SDSubjectsView new];
        _subjectsView.delegate = self;
        _subjectsView.backgroundColor = [UIColor blueColor];
    }
    return _subjectsView;
}
- (YBGHomeDataController *)dataController {
    if (!_dataController) {
        _dataController = [[YBGHomeDataController alloc]init];
    }
    return _dataController;
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
