//
//  RealmDemoViewController.m
//  YRDGoodArc
//
//  Created by yurongde on 16/6/21.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "RealmDemoViewController.h"
#import "RealmDog.h"
#import "RealmBook.h"
#import "JSONCity.h"

@interface RealmDemoViewController ()
@property RLMNotificationToken *token;
@end

@implementation RealmDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RealmDog *myDog = [[RealmDog alloc]init];
    myDog.name = @"Alex";
    myDog.age = 10;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    //添加
    [realm beginWriteTransaction];
    [realm addObject:myDog];
    [realm commitWriteTransaction];
    
    
    
    RealmBook *book = [[RealmBook alloc]init];
    book.name = @"围城";
    book.bookId = 1;
    book.price = 50.5f;
    book.publish = @"BB";
    
    RealmBook *book2 = [[RealmBook alloc]init];
    book2.name = @"天亮";
    book2.bookId = 3;
    book2.price = 60.5f;
    book2.publish = @"BB";

    RealmBook *book3 = [[RealmBook alloc]init];
    book3.name = @"老人与海";
    book3.bookId = 2;
    book3.price = 40.5f;
    book3.publish = @"BB";

    RealmBook *book4 = [[RealmBook alloc]initWithValue:@[@"庄子",@4,@50.6f,@"BBA"]];
    //前提条件有主键,添加或者更新，主键相同的时候替换object
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:book];
    [realm addOrUpdateObject:book2];
    [realm addOrUpdateObject:book3];
    [realm addOrUpdateObject:book4];

    [realm commitWriteTransaction];
    
    //删除
    [realm beginWriteTransaction];
//    [realm deleteObject:myDog];
//    [realm deleteAllObjects];
    [realm commitWriteTransaction];

    //监听每一次事务提交
    self.token = [realm addNotificationBlock:^(NSString * _Nonnull notification, RLMRealm * _Nonnull realm) {
        NSLog(@"updated");
    }];
   
    [self queryOperation];
    [self saveJSONData];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.token stop];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)queryOperation {
   
//    Using a Realm Across Threads
    /*
    Sharing Realm instances across threads is not supported. Realm instances accessing the same Realm file must also all use the same RLMRealmConfiguration.
    */
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @autoreleasepool {
            
        
    NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL);
    RLMRealm *realm = [RLMRealm defaultRealm];
    //查询
    RLMResults<RealmBook *> *books = [RealmBook objectsWhere:@"name = '围城'"];
    NSLog(@"count:%lu",(unsigned long)books.count);
    for (RealmBook *bookTemp in books) {
        NSLog(@"name:%@,price:%f",bookTemp.name,bookTemp.price);
    }

       [realm transactionWithBlock:^{
           books.firstObject.name = @"abc";
       } error:nil];
    //谓词查询
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name = %@ AND bookId = %@",@"围城",@1];
    books = [RealmBook objectsWithPredicate:pred];
    NSLog(@"count:%lu",(unsigned long)books.count);
    for (RealmBook *bookTemp in books) {
        NSLog(@"name:%@,price:%f",bookTemp.name,bookTemp.price);
    }
    
//    sort
    RLMResults<RealmBook *> *newBooks = [[RealmBook objectsWhere:@"publish BEGINSWITH 'B'"]sortedResultsUsingProperty:@"bookId" ascending:YES];
    NSLog(@"count:%lu",(unsigned long)newBooks.count);
    for (RealmBook *bookTemp in newBooks) {
        NSLog(@"name:%@,price:%f",bookTemp.name,bookTemp.price);
    }
    
//    chaining
    RLMResults<RealmBook *> *chainBooks = [newBooks objectsWhere:[NSString stringWithFormat:@"bookId = %@",@1]];
    NSLog(@"count:%lu",chainBooks.count);
    for (RealmBook *bookTemp in chainBooks) {
        NSLog(@"name:%@,price:%f",bookTemp.name,bookTemp.price);
    }
    
//    Auto-Updating Results
    RLMResults<RealmDog *> *puppies = [RealmDog objectsInRealm:realm where:@"age < 2"];
    NSLog(@"dogCount:%lu",puppies.count);// => 0
            [realm beginWriteTransaction];
    for (int i = 0; i < 400; i++) {
       
            [RealmDog createInRealm:realm withValue:@{@"name": @"Fido", @"age": @1}];
                    
       

    }
            [realm commitWriteTransaction];
    NSLog(@"dogCountLast:%lu",puppies.count);// => 2
        }
    });
    
}
- (void)saveJSONData {
    NSData *data = [@"{\"name\": \"San Francisco\", \"cityId\": 123}" dataUsingEncoding: NSUTF8StringEncoding];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        [JSONCity createInRealm:realm withValue:json];
    }];
    
    RLMResults<JSONCity *> *results = [JSONCity allObjects];
    for (JSONCity *city in results) {
        NSLog(@"cityName:%@",city.name);
    }
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
