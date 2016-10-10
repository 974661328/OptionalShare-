//
//  HuShenViewController.m
//  OptionalShares
//
//  Created by seven on 14-10-11.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//
 

#import "HuShenViewController.h"
#import "MarketsTableView.h"
#import "MyDataService.h"
#import "ChooseModel.h"
#import "HotModel.h"

@interface HuShenViewController ()

@end

@implementation HuShenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.edgesForExtendedLayout = UIRectEdgeNone;
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
    __weak HuShenViewController *weakSelf = self;
    [self.tableView setPullBlock:^{
        __strong HuShenViewController *strongSelf = weakSelf;
        
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
    
    NSString *urlstring = @"http://ifzq.gtimg.cn/appstock/app/mktHs/index?_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350";
    
    
    [MyDataService requestURL:urlstring httpMethod:@"GET" params:nil complection:^(id result) {
        

        NSDictionary *dic = result[@"data"];
        
        
        //指数
        NSArray *data0 = dic[@"zs"];
        
        NSMutableArray *arrays0 = [NSMutableArray arrayWithCapacity:data0.count];
        for (NSDictionary *dic in data0) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            csModel.isColor = YES;
            [arrays0 addObject:csModel];
        }
        
        //热门行业
        NSArray *data1 = dic[@"01\/averatio\/0"];
        NSMutableArray *arrays1 = [NSMutableArray arrayWithCapacity:data1.count];
        for (NSDictionary *dic in data1) {
            HotModel *hotModel = [[HotModel alloc] initWithDataDic:dic];

            [arrays1 addObject:hotModel];
        }
        
        //涨幅榜
        NSArray *data2 = dic[@"ranka\/chr\/0"];
        NSMutableArray *arrays2 = [NSMutableArray arrayWithCapacity:data2.count];
        for (NSDictionary *dic in data2) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            csModel.isColor = YES;
            [arrays2 addObject:csModel];
        }
        //跌幅榜
        NSArray *data3 = dic[@"ranka\/chr\/1"];
        NSMutableArray *arrays3 = [NSMutableArray arrayWithCapacity:data3.count];
        for (NSDictionary *dic in data3) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            csModel.isColor = YES;
            [arrays3 addObject:csModel];
        }
        //换手率榜
        NSArray *data4 = dic[@"ranka\/trunrl\/0"];
        NSMutableArray *arrays4 = [NSMutableArray arrayWithCapacity:data4.count];
        for (NSDictionary *dic in data4) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            csModel.isColor = YES;
            [arrays4 addObject:csModel];
        }
        //振幅榜
        NSArray *data5 = dic[@"ranka\/dtzf\/0"];
        NSMutableArray *arrays5 = [NSMutableArray arrayWithCapacity:data5.count];
        for (NSDictionary *dic in data5) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            csModel.isColor = YES;
            [arrays5 addObject:csModel];
        }
        
        //每组数据
        NSMutableArray *data = [NSMutableArray arrayWithObjects:arrays0,arrays1,arrays2,arrays3,arrays4,arrays5, nil];
        //组头
        NSArray *titles = [NSArray arrayWithObjects:@"热门行业",@"涨幅榜",@"跌幅榜",@"换手率榜",@"振幅榜", nil];
        
        //数据加载完毕，显示tableView
        self.tableView.hidden = NO;
        //隐藏加载提示
        [super showLoading:NO];
        
        
        [self.tableView doneLoadingTableViewData];
     
        self.isRefresh = YES;
        self.tableView.data = data;
        self.tableView.titles = titles;
        self.tableView.isHead = YES;
        self.tableView.isHot = YES;
        
        [self.tableView reloadData];

    }];
    
}


@end
