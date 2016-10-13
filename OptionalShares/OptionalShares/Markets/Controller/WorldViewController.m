//
//  WorldViewController.m
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "WorldViewController.h"
#import "MyDataService.h"
#import "ChooseModel.h"
#import "MarketsTableView.h"

@interface WorldViewController ()

@end

@implementation WorldViewController

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
    __weak WorldViewController *weakSelf = self;
    [self.tableView setPullBlock:^{
        __strong WorldViewController *strongSelf = weakSelf;
        
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
    
    NSString *urlstring = @"http://ifzq.gtimg.cn/appstock/app/rank/world?_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350";
    
    
    [MyDataService requestURL:urlstring httpMethod:@"GET" params:nil complection:^(id result) {
        
        
        NSDictionary *dic = result[@"data"];
        
        //常用
        NSArray *data0 = dic[@"common"];
        NSMutableArray *arrays0 = [NSMutableArray arrayWithCapacity:data0.count];
        for (NSDictionary *dic in data0) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            csModel.isColor = YES;
            [arrays0 addObject:csModel];
        }
        
        //欧美指数
        NSArray *data1 = dic[@"zsom"];
        NSMutableArray *arrays1 = [NSMutableArray arrayWithCapacity:data1.count];
        for (NSDictionary *dic in data1) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            csModel.isColor = YES;
            [arrays1 addObject:csModel];
        }
        
        //亚太指数
        NSArray *data2 = dic[@"zsyt"];
        NSMutableArray *arrays2 = [NSMutableArray arrayWithCapacity:data2.count];
        for (NSDictionary *dic in data2) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            csModel.isColor = YES;
            [arrays2 addObject:csModel];
        }
        
        //大宗商品
        NSArray *data3 = dic[@"zsdz"];
        NSMutableArray *arrays3 = [NSMutableArray arrayWithCapacity:data3.count];
        for (NSDictionary *dic in data3) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            csModel.isColor = YES;
            [arrays3 addObject:csModel];
        }
        
        //外汇市场
        NSArray *data4 = dic[@"wh"];
        NSMutableArray *arrays4 = [NSMutableArray arrayWithCapacity:data4.count];
        for (NSDictionary *dic in data4) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            csModel.isColor = YES;
            [arrays4 addObject:csModel];
        }
        
        //人民币
        NSArray *data5 = dic[@"rmbpj"];
        NSMutableArray *arrays5 = [NSMutableArray arrayWithCapacity:data5.count];
        for (NSDictionary *dic in data5) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            
            [arrays5 addObject:csModel];
        }
        
        //每组数据
        NSMutableArray *data = [NSMutableArray arrayWithObjects:arrays0,arrays1,arrays2,arrays3,arrays4,arrays5, nil];
        //组头名称
        NSArray *titles = [NSArray arrayWithObjects:@"常用",@"欧美指数",@"亚太指数",@"大宗商品",@"外汇市场",@[@"人命币牌价",@"现汇买入价",@"现钞买入价"],nil];
        
        self.tableView.data = data;
        self.tableView.titles = titles;
        self.tableView.isRound = YES;
        self.tableView.isHead = NO;
        self.tableView.isHot = NO;
        
        //数据加载完毕，显示tableView
        self.tableView.hidden = NO;
        //隐藏加载提示
        [super showLoading:NO];
        
        [self.tableView doneLoadingTableViewData];

        [self.tableView reloadData];
    }];
    
}


@end
