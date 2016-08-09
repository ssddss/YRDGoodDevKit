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
#import "YBGDownloadApiManager.h"
#define CacheFolderName @"DownloadFiles"

@interface YBGRestfulViewController ()
@property (nonatomic) YBGRestfulGetApiManager *getApiManager;
@property (nonatomic) YBGRestfulPostApiManager *postApiManager;
@property (nonatomic) YBGRestfulPutApiManager *putApiManager;
@property (nonatomic) YBGRestfulDeleteApiManager *deleteApiManager;
@property (weak, nonatomic) IBOutlet UIProgressView *downLoadProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *uploadProgress;
@property (nonatomic) YBGDownloadApiManager *downloadApiManager;
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
- (IBAction)downLoadAction:(id)sender {
    
    NSFileManager *fileManager1 = [[NSFileManager alloc] init];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath = [NSString stringWithFormat:@"%@/%@", pathDocuments,CacheFolderName];
    
    // 判断文件夹是否存在，如果存在，则删除
    if ([[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
//        [fileManager1 removeItemAtPath:createPath error:nil];
    }
    
    NSString *samllFile = @"http://192.168.151.107:8080/mobileapi/open/test/download?fileName=1.png";
    NSString *bigFile = @"http://192.168.151.107:8080/mobileapi/open/test/download?fileName=sqldeveloper.zip";
    NSString *middleFile = @"http://192.168.151.107:8080/mobileapi/open/test/download?fileName=Xshell5.exe";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:samllFile]];
    @weakify(self);
    [self.downloadApiManager startDownloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        @strongify(self);
//        得不到完整的大小这个block不会跑，但是还是在下载
        NSLog(@"progress: %lld/%lld",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.downLoadProgress setProgress:(float)downloadProgress.completedUnitCount / (float)downloadProgress.totalUnitCount];

        });
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *createPath = [NSString stringWithFormat:@"%@/%@", pathDocuments,CacheFolderName];
        
        // 判断文件夹是否存在，如果不存在，则创建
        if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
            [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
        } else {
            DLog(@"FileDir is exists.");
        }
        NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:createPath];
        NSURL *finalFilePathURL = [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        if ([[NSFileManager defaultManager]fileExistsAtPath:finalFilePathURL.path]) {
            [fileManager removeItemAtURL:finalFilePathURL error:nil];
        }
        return finalFilePathURL;

    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"下载失败");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.downLoadProgress setProgress:0.0f];

            });
        }
        else {
            NSLog(@"下载完成:%@",filePath);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.downLoadProgress setProgress:1.0f];

            });
        }
    }];
}
- (IBAction)cancelDownLoadAction:(id)sender {
    [self.downLoadProgress setProgress:0.0f];
    [self.downloadApiManager cancelAllRequests];
}
- (IBAction)uploadAction:(id)sender {
}
- (IBAction)cancelUploadAction:(id)sender {
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
- (YBGDownloadApiManager *)downloadApiManager {
    if (!_downloadApiManager) {
        _downloadApiManager = [[YBGDownloadApiManager alloc]init];
    }
    return _downloadApiManager;
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
