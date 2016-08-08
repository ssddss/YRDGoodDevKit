//
//  YBGRestfulViewController.m
//  YRDGoodArc
//
//  Created by yurongde on 16/8/8.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGRestfulViewController.h"
#import "YBGRestfulGetApiManager.h"
#import "YBGRestfulPostApiManager.h"
#import "YBGRestfulPutApiManager.h"
#import "YBGRestfulDeleteApiManager.h"

@interface YBGRestfulViewController ()
@property (nonatomic) YBGRestfulGetApiManager *getApiManager;
@property (nonatomic) YBGRestfulPostApiManager *postApiManager;
@property (nonatomic) YBGRestfulPutApiManager *putApiManager;
@property (nonatomic) YBGRestfulDeleteApiManager *deleteApiManager;
@end

@implementation YBGRestfulViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}
- (IBAction)getAction:(UIButton *)sender {
    [self.getApiManager startWithCompletionBlockWithSuccess:^(YRDAPIBaseManager *manager) {
        NSLog(@"get success");
    } failure:^(YRDAPIBaseManager *manager) {
        NSLog(@"get failed %@",manager.errorMessage);
    }];
}
- (IBAction)postAction:(id)sender {
    [self.postApiManager startWithCompletionBlockWithSuccess:^(YRDAPIBaseManager *manager) {
        NSLog(@"post success");

    } failure:^(YRDAPIBaseManager *manager) {
        NSLog(@"post failed");
    }];
}
- (IBAction)putAction:(id)sender {
    [self.putApiManager startWithCompletionBlockWithSuccess:^(YRDAPIBaseManager *manager) {
        NSLog(@"put success");
        
    } failure:^(YRDAPIBaseManager *manager) {
        NSLog(@"put failed");
    }];

}
- (IBAction)deleteAction:(id)sender {
    [self.deleteApiManager startWithCompletionBlockWithSuccess:^(YRDAPIBaseManager *manager) {
        NSLog(@"delete success");
        
    } failure:^(YRDAPIBaseManager *manager) {
        NSLog(@"delete failed");
    }];

}
#pragma mark - getters and setters
- (YBGRestfulGetApiManager *)getApiManager {
    if (!_getApiManager) {
        _getApiManager = [[YBGRestfulGetApiManager alloc]init];
    }
    return _getApiManager;
}
- (YBGRestfulPostApiManager *)postApiManager {
    if (!_postApiManager) {
        _postApiManager = [[YBGRestfulPostApiManager alloc]init];
    }
    return _postApiManager;
}
- (YBGRestfulPutApiManager *)putApiManager {
    if (!_putApiManager) {
        _putApiManager = [[YBGRestfulPutApiManager alloc]init];
    }
    return _putApiManager;
}
- (YBGRestfulDeleteApiManager *)deleteApiManager {
    if (!_deleteApiManager) {
        _deleteApiManager = [[YBGRestfulDeleteApiManager alloc]init];
    }
    return _deleteApiManager;
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
