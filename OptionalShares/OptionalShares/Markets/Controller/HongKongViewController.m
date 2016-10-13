//
//  HongKongViewController.m
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "HongKongViewController.h"
#import "MarketsTableView.h"
#import "MyDataService.h"
#import "ChooseModel.h"
#import "HotModel.h"

@interface HongKongViewController ()

@end

@implementation HongKongViewController

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
    __weak HongKongViewController *weakSelf = self;
    [self.tableView setPullBlock:^{
        __strong HongKongViewController *strongSelf = weakSelf;
        
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
    
    NSString *urlstring = @"http://ifzq.gtimg.cn/appstock/app/mktHk/index?_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350";
    
    
    [MyDataService requestURL:urlstring httpMethod:@"GET" params:nil complection:^(id result) {
        
        
        NSDictionary *dic = result[@"data"];
        
        
        //指数
        NSArray *data0 = dic[@"zs"];
        
        NSMutableArray *arrays0 = [NSMutableArray arrayWithCapacity:data0.count];
        for (NSDictionary *dic in data0) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            
            [arrays0 addObject:csModel];
        }
        
        //热门行业
        NSArray *data1 = dic[@"hk_industry_list"];
        NSMutableArray *arrays1 = [NSMutableArray arrayWithCapacity:data1.count];
        for (NSDictionary *dic in data1) {
            HotModel *hotModel = [[HotModel alloc] initWithDataDic:dic];
            
            [arrays1 addObject:hotModel];
        }
        
        //主板涨幅榜
        NSArray *data2 = dic[@"main_all_desc"];
        NSMutableArray *arrays2 = [NSMutableArray arrayWithCapacity:data2.count];
        for (NSDictionary *dic in data2) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            csModel.isColor = YES;
            [arrays2 addObject:csModel];
        }
        //主板跌幅榜
        NSArray *data3 = dic[@"main_all_asc"];
        NSMutableArray *arrays3 = [NSMutableArray arrayWithCapacity:data3.count];
        for (NSDictionary *dic in data3) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            csModel.isColor = YES;
            [arrays3 addObject:csModel];
        }
        //主板成交
        NSArray *data4 = dic[@"main_all_amount_desc"];
        NSMutableArray *arrays4 = [NSMutableArray arrayWithCapacity:data4.count];
        for (NSDictionary *dic in data4) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            
            [arrays4 addObject:csModel];
        }
        //创业板涨幅榜
        NSArray *data5 = dic[@"gem_all_desc"];
        NSMutableArray *arrays5 = [NSMutableArray arrayWithCapacity:data5.count];
        for (NSDictionary *dic in data5) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            csModel.isColor = YES;
            [arrays5 addObject:csModel];
        }
        //创业板跌幅榜
        NSArray *data6 = dic[@"gem_all_asc"];
        NSMutableArray *arrays6 = [NSMutableArray arrayWithCapacity:data6.count];
        for (NSDictionary *dic in data6) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            csModel.isColor = YES;
            [arrays6 addObject:csModel];
        }
        //创业板成交额
        NSArray *data7 = dic[@"gem_all_amount_desc"];
        NSMutableArray *arrays7 = [NSMutableArray arrayWithCapacity:data7.count];
        for (NSDictionary *dic in data7) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];

            [arrays7 addObject:csModel];
        }
        //认股
        NSArray *data8 = dic[@"warrant_all_desc"];
        NSMutableArray *arrays8 = [NSMutableArray arrayWithCapacity:data8.count];
        for (NSDictionary *dic in data8) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            
            [arrays8 addObject:csModel];
        }
        //牛熊
        NSArray *data9 = dic[@"niuxiong_all_desc"];
        NSMutableArray *arrays9 = [NSMutableArray arrayWithCapacity:data9.count];
        for (NSDictionary *dic in data9) {
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            
            [arrays9 addObject:csModel];
        }
        
        //每组的数据
        NSMutableArray *data = [NSMutableArray arrayWithObjects:arrays0,arrays1,arrays2,arrays3,arrays4,arrays5,arrays6,arrays7,arrays8,arrays9, nil];
        //组头名称
        NSArray *titles = [NSArray arrayWithObjects:@"热门行业",@"主板涨幅榜",@"主板跌幅榜",@"主板成交额榜",@"创业板涨幅榜",@"创业板跌幅榜",@"创业板成交额榜",@"认股证成交额榜",@"牛熊证成交额榜", nil];
        
        self.tableView.data = data;
        self.tableView.titles = titles;
        self.tableView.isHead = YES;
        self.tableView.isHot = YES;
        self.tableView.isHK = YES;
        
        //数据加载完毕，显示tableView
        self.tableView.hidden = NO;
        //隐藏加载提示
        [super showLoading:NO];

        [self.tableView doneLoadingTableViewData];
        
        [self.tableView reloadData];
        
    }];
    
}


@end
