//
//  AmericaViewController.m
//  OptionalShares
//
//  Created by seven on 14-10-11.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "AmericaViewController.h"
#import "MarketsTableView.h"
#import "MyDataService.h"
#import "ChooseModel.h"

@interface AmericaViewController ()

@end

@implementation AmericaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.创建tableView
    [self _createView];
    
    //2.加载数据
    [self _loadData];
    
    //3.下拉刷新
    __weak AmericaViewController *weakSelf = self;
    [self.tableView setPullBlock:^{
        __strong AmericaViewController *strongSelf = weakSelf;
        
        [strongSelf _loadData];
    }];
    
}


- (void)_createView {
    
    self.tableView = [[MarketsTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    //数据未加载，隐藏tabelView
    self.tableView.hidden = YES;
    //提示加载
    [super showLoading:YES locationOfHeight:100];
 
    [self.view addSubview:self.tableView];
}

- (void)_loadData {
    
    NSString *urlstring = @"http://ifzq.gtimg.cn/appstock/app/mktUs/index?_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350";
    
    
    [MyDataService requestURL:urlstring httpMethod:@"GET" params:nil complection:^(id result) {
        
        
        NSDictionary *dic = result[@"data"];

        
        //指数
        NSArray *data0 = dic[@"zs"];
        NSMutableArray *arrays0 = [NSMutableArray arrayWithCapacity:data0.count];
        for (NSDictionary *dic in data0) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            
            [arrays0 addObject:csModel];
        }

        //中概股
        NSArray *data1 = dic[@"zgg"];
        NSMutableArray *arrays1 = [NSMutableArray arrayWithCapacity:data1.count];
        for (NSDictionary *dic in data1) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            csModel.isColor = YES;
            [arrays1 addObject:csModel];
        }
        
        //科技股
        NSArray *data2 = dic[@"ustec"];
        NSMutableArray *arrays2 = [NSMutableArray arrayWithCapacity:data2.count];
        for (NSDictionary *dic in data2) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            csModel.isColor = YES;
            [arrays2 addObject:csModel];
        }
        
        //每组数据
        NSMutableArray *data = [NSMutableArray arrayWithObjects:arrays0,arrays1,arrays2, nil];
        //组头名称
        NSArray *titles = [NSArray arrayWithObjects:@"中概股",@"科技股", nil];
        
        self.tableView.data = data;
        self.tableView.titles = titles;
        self.tableView.isHead = YES;
        self.tableView.isHot = NO;
        self.tableView.isUS = YES;
        
        //数据加载完毕，显示tableView
        self.tableView.hidden = NO;
        //隐藏加载提示
        [super showLoading:NO];

        [self.tableView doneLoadingTableViewData];
        
        [self.tableView reloadData];
        
    }];
    
}


@end
