//
//  YBGPullToRefreshDemoViewController.m
//  YRDGoodArc
//
//  Created by yurongde on 16/8/1.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGPullToRefreshDemoViewController.h"
#import "MJRefresh.h"
#import "YiBaoGaoApiManager.h"
#import "SchoolListReformer.h"
#import "SchoolItem.h"
static NSString *const kCell_ID = @"cell";
@interface YBGPullToRefreshDemoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableVeiw;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic) YiBaoGaoApiManager *apiManager;
@property (nonatomic) SchoolListReformer *reformer;

@end

@implementation YBGPullToRefreshDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableVeiw registerClass:[UITableViewCell class] forCellReuseIdentifier:kCell_ID];
    self.tableVeiw.backgroundColor = [UIColor yellowColor];
    self.tableVeiw.tableFooterView = [UIView new];
    self.tableVeiw.delegate = self;
    self.tableVeiw.dataSource = self;
    
    self.tableVeiw.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    //注意循环引用，当网络请求延迟的时候还是会延长对象的生命周期
    @weakify(self);
    self.tableVeiw.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
//    这样可以防止如果调用同一个apiManager的时候没响应的问题，在头或者尾判断状态。
        if (self.tableVeiw.mj_footer.isRefreshing) {
            [self.tableVeiw.mj_header endRefreshing];
            return ;
        }
        [self.tableVeiw.mj_footer resetNoMoreData];
        [self.apiManager startWithCompletionBlockWithSuccess:^(YRDAPIBaseManager *manager) {
            NSLog(@"blockChange1");
            NSArray *arr = [manager fetchDataWithReformer:self.reformer];
            [self.dataSource addObjectsFromArray:arr];
            
            [self.tableVeiw reloadData];
            [self.tableVeiw.mj_header endRefreshing];

            
        } failure:^(YRDAPIBaseManager *manager) {
            [self.tableVeiw.mj_header endRefreshing];
        }];
        }];
    self.tableVeiw.mj_header.lastUpdatedTimeKey = @"user_last_UpdateTime";
    self.tableVeiw.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)

        if (self.tableVeiw.mj_header.isRefreshing) {
            [self.tableVeiw.mj_footer endRefreshing];
            return ;
        }
        [self.apiManager startWithCompletionBlockWithSuccess:^(YRDAPIBaseManager *manager) {
            NSLog(@"blockChange1");
            NSArray *arr = [manager fetchDataWithReformer:self.reformer];
            [self.dataSource addObjectsFromArray:arr];
            
            [self.tableVeiw reloadData];
            [self.tableVeiw.mj_footer endRefreshingWithNoMoreData];

            
        } failure:^(YRDAPIBaseManager *manager) {
            [self.tableVeiw.mj_footer endRefreshing];

        }];
    }];
    [self.tableVeiw.mj_header beginRefreshing];
    [self.tableVeiw.mj_footer beginRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}
- (void)loadMoreData {
    for (int i = 0; i < 10; i++) {
        [self.dataSource addObject:@"1"];
    }
    [self.tableVeiw reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell_ID];
    SchoolItem *item = self.dataSource[indexPath.row];
    cell.textLabel.text = item.xxmc;
    return cell;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
- (YiBaoGaoApiManager *)apiManager {
    if (!_apiManager) {
        _apiManager = [[YiBaoGaoApiManager alloc]init];
    }
    return _apiManager;
}
- (SchoolListReformer *)reformer {
    if (!_reformer) {
        _reformer = [[SchoolListReformer alloc]init];
    }
    return _reformer;
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
