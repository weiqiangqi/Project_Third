//
//  RootViewController.m
//  UItest
//
//  Created by lanou3g on 15/8/30.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "RootViewController.h"
#import "GDataXMLNode.h"
#import "Categories.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.height
#define kScreenHeight [UIScreen mainScreen].bounds.size.width
@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSMutableArray * mutArray;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.contentSize =CGSizeMake(kScreenWidth, 2000);
    
    [self.tableView registerClass:[UITableViewCell class ] forCellReuseIdentifier:@"cellID"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView.backgroundColor = [UIColor greenColor];
    //解析数据
    NSString * path = [[NSBundle mainBundle]pathForResource:@"Categories" ofType:@"xml"];
    
    NSData * data = [NSData dataWithContentsOfFile:path];
    
    GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
    
    GDataXMLElement * rootelement = document.rootElement;
    _mutArray =[[NSMutableArray alloc]initWithCapacity:20];
//    GDataXMLElement * a = rootelement.children[1] ;
    for (GDataXMLElement * subElement in rootelement.children) {
        Categories * cate = [Categories new];
        cate.array = [NSMutableArray array];
        for (GDataXMLElement * elment in subElement.children) {
           
                 [cate setValue:elment.stringValue forKeyPath:elment.name];
        
            NSLog(@"%@",cate);
        }
        [_mutArray addObject:cate];
        
    }
    self.tableView.bounces = NO;
    self.title = @"分类信息";
    //设置左侧按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.tableView.backgroundColor = [UIColor orangeColor];
    [_mutArray removeObjectAtIndex:0];
    [self.view addSubview:self.tableView];
}

#pragma mark --- myMethod(自己定义的一些方法)---

- (void)goBack{

//    self.navigationItem.backBarButtonItem.title = @""
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark ----设置cell  delegate datasouse----
//设置section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _mutArray.count ;
}

//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Categories * cate = _mutArray[section ];
    
    return cate.array.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
     Categories * cate = _mutArray[indexPath.section ];
    cell.textLabel.text =cate.array[indexPath.row];

    return  cell;
}

//设置分区头内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    Categories * cate = _mutArray[section ];
    return cate.category_name;
}
//设置分区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 70;
    
}

//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
//    view.backgroundColor = [UIColor greenColor];
//    return view;
//}





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
