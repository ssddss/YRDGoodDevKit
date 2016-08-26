//
//  YBGEncryptionViewController.m
//  YRDGoodArc
//
//  Created by yurongde on 16/8/24.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGEncryptionViewController.h"
#import "NSString+Encryption.h"
#import "RSA.h"
#import "YBGRequestParamsTool.h"

@interface YBGEncryptionViewController ()

@end

@implementation YBGEncryptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self aesECBTest];
    [self rsaTest];

    [[YBGRequestParamsTool sharedRequestParamsTool] refreshRequestParams];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)aesECBTest {
    NSString *plainText = @"1000";
    
    NSString *key128 = [YBGRequestParamsTool sharedRequestParamsTool].AESEncryptionKey;
    
    NSString *aesBase64 = [plainText aesECBEncryptWithKey:key128];
    NSLog(@"加密：%@ --- %@",aesBase64, key128);
    
    // 解密
    NSString *decStr = [aesBase64 aesECBBase64StringDecryptWithKey:key128];
    NSLog(@"解密：%@---",decStr);
    
}
- (void)rsaTest {
    NSString *plainText = @"1234";


    NSString *publicKey = @"\
    MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAYYAF5a/+WuXTf3COIrH/Rtxy5qN3fr5hIlIAo3KpfudqooJuG4KpCjscpvmUvIelpbL88qPvqZn4yswnGPQqCyUKCzvaQ4LwxvyyMiGBhITYH2oELV4rZm9IJplbU7gqpkz/5o/Ysqe/qYaMUblxjt4f3X+FBFVBOCHRJ+m6YQIDAQAB\
    ";
    
    NSString *encWithPubKey = [RSA encryptString:plainText publicKey:publicKey];
    
    NSLog(@"RSA:%@ ---",encWithPubKey);

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
