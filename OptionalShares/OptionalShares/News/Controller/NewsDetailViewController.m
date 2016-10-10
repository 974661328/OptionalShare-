//
//  NewsDetailViewController.m
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsDetailTableView.h"
#import "MyDataService.h"
#import "NewsModel.h"
#import "SelectedModel.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.edgesForExtendedLayout = UIRectEdgeBottom;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //1.创建tableView
    [self _loadTableView];
    
    //2.加载数据
    
    if (self.isZX) {
        
        [self _loadMyData];
    } else {
        
        [self _loadData];
    }
    
}

//创建tableView
- (void)_loadTableView {
    
    self.tableView = [[NewsDetailTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];

    //数据未加载，隐藏tabelView
    self.tableView.hidden = YES;
    //提示加载
    [super showLoading:YES];

    [self.view addSubview:self.tableView];
}

//加载数据
- (void)_loadData {
    
    NSMutableArray *array = [NSMutableArray array];
    for (int j=0; j<self.newsID.count; j++) {
        //从字典里取出每个ID
        NSDictionary *dic = self.newsID[j];
        NSString *idStr = dic[@"id"];
        
        [array addObject:idStr];
    }
  
    NSString *paramsStr = [array componentsJoinedByString:@"%2C"];
    
    NSDictionary *params = @{
                             @"ids":[paramsStr stringByAppendingFormat:@"%%2C"]
                             };
    
    
    [MyDataService requestURL:NEWDETAILURL httpMethod:@"POST" params:[params mutableCopy] complection:^(id result) {
        
        NSArray *newslist = result[@"newslist"];
        
        self.newsID = [NSMutableArray arrayWithCapacity:newslist.count];
        for (NSDictionary *dataDic in newslist) {
            
            NewsModel *newsModel = [[NewsModel alloc] initWithDataDic:dataDic];
            [self.newsID addObject:newsModel];
        }
        
        self.tableView.data = self.newsID;
        
        //数据加载完毕，显示tableView
        self.tableView.hidden = NO;
        //隐藏加载提示
        [super showLoading:NO];
        //如果是下拉刷新，收起下拉
        [self.tableView doneLoadingTableViewData];

        [self.tableView reloadData];
        
    }];
}

- (void)_loadMyData {
    NSString *urlstring = @"http://ifzq.gtimg.cn/appstock/news/info/search?type=3&page=1&n=20&_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350";
    
    NSDictionary *params = @{
                             @"symbol":@"sz002007%2Csz002155%2Csz002142%2Csz002202%2Csz002024%2Csh600002%2Csh600036%2Csh600016%2Csh600050%2Csh600028%2Cjj000600%2Chk00600%2Csz000600%2Csh600600%2C"
                             };
    
    [MyDataService requestURL:urlstring httpMethod:@"POST" params:[params mutableCopy] complection:^(id result) {
        
        
        NSDictionary *dic = result[@"data"];
        NSArray *data = dic[@"data"];
        
        NSMutableArray *myData = [NSMutableArray arrayWithCapacity:data.count];
        
        for (NSDictionary *dataDic in data) {
            
            SelectedModel *myModel = [[SelectedModel alloc] initWithDataDic:dataDic];
            
            [myData addObject:myModel];
        }
        
        self.tableView.data = myData;
        self.tableView.isZX = YES;
        
        //数据加载完毕，显示tableView
        self.tableView.hidden = NO;
        //隐藏加载提示
        [super showLoading:NO];
        
        
        [self.tableView reloadData];

        
    }];

}

@end
