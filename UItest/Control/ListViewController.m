//
//  ListViewController.m
//  UItest
//
//  Created by lanou3g on 15/8/30.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "ListViewController.h"
#import "RootViewController.h"
#import "SignatrueEncryption.h"
#import "AFNetworking.h"
#import "Urls.h"
#import "Detail.h"

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray * allDataArray;
@property(nonatomic,strong)NSString * categoryName;

@property(nonatomic,strong)UITableView * tableView;

- (void)loadDataAndShow;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分类切换" style:UIBarButtonItemStylePlain target:self action:@selector(goToChose)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
    

    
    
}

#pragma mark---- myMethoed----
//分类切换
- (void)goToChose{
    
    RootViewController * rootVC = [[RootViewController alloc]init];

    [self.navigationController pushViewController:rootVC animated:YES];
    
}


- (void)loadDataAndShow{
    self.allDataArray = [NSMutableArray array];
    __block typeof(self) weakSelf = self;
    
    NSMutableDictionary * paramsMutableDict = [NSMutableDictionary dictionary];
    [paramsMutableDict setObject:@"上海" forKey:@"city"];
    [paramsMutableDict setObject:_categoryName forKey:@"category"];
    [paramsMutableDict setObject:@30 forKey:@"limit"];//????
     [paramsMutableDict setObject:@1 forKey:@"page"];
    //加密
    paramsMutableDict = [SignatrueEncryption  encryptedParamsWithBaseParams:paramsMutableDict];
    NSLog(@"%@",paramsMutableDict);
    //拼接接口,以及数据
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [ manager GET:kGoodsListURLStr parameters:paramsMutableDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 拆解数据
        NSLog(@"%@", responseObject);
        for (NSDictionary * item in responseObject[@"deals"]) {
            @autoreleasepool {
                
 
            Detail * detail = [Detail new];
            [detail setValuesForKeysWithDictionary:item];
            [weakSelf.allDataArray addObject:detail];
        }
            [weakSelf.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedFailureReason);
        
    }];
    
    
}

//刷新
- (void)refresh{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ---delegate datasouse----

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allDataArray.count;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
