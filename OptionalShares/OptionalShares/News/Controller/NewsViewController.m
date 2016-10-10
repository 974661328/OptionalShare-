//
//  NewsViewController.m
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "NewsViewController.h"
#import "MyDataService.h"
#import "SelectedModel.h"
#import "NewsModel.h"
#import "NewsTableView.h"


@interface NewsViewController ()

@end

@implementation NewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.allList = [NSMutableArray array];
    self.selectList = [NSMutableArray array];
    self.fiveIDs = [NSMutableArray array];
    self.allNewsID = [NSMutableArray array];
    
    
    //1.数据未加载，隐藏tabelView
    self.tableView.hidden = YES;
    //提示加载
    [super showLoading:YES];
    
    //2.刷新数据
    [self _loadRootData];
    
    //3.下拉刷新
    __weak NewsViewController *weakSelf = self;
    [self.tableView setPullBlock:^{
        __strong NewsViewController *strong = weakSelf;
        
        [strong _loadRootData];
    }];
    
    
}

//加载根数据
- (void)_loadRootData {
    
    [MyDataService requestURL:NEWROOTSURL httpMethod:@"GET" params:nil complection:^(id result) {
        
        NSDictionary *data = result[@"data"];
        NSDictionary *news = data[@"news"];
        NSDictionary *mylist = news[@"newslist"];
        
        self.allList = mylist[@"alllist"];
        self.selectList = mylist[@"selectlist"];
        
        [self _loadNewsID];
    }];
}

//加载各个模块ID数据
- (void)_loadNewsID {
    
    NSString *url =NEWSELECTURL;
    
    NSString *idString = [self.selectList componentsJoinedByString:@","];
    
    //chlids=stock_yaowen,stock_hssc,stock_ggsc,stock_mgsc,stock_kjbk,stock_jrbk,stock_dcbk,&
    url = [NEWSELECTURL stringByAppendingFormat:@"&chlids=%@",idString];
    
    [MyDataService requestURL:url httpMethod:@"GET" params:nil complection:^(id result) {
        
        /*
         "ids": {
            "stock_yaowen": [{
                "id": "FIN2014101702334515",
                "exist": 0,
                "comments": 0
            }, {
             "id": "FIN2014101704659918",
             "exist": 0,
             "comments": 0
             }
         */
        
        NSDictionary *newslist = result[@"ids"];
        //取ID
        for (int i=0; i<self.selectList.count; i++) {
 
            if ([self.selectList[i] isEqualToString:@"stock_zixuan"]
                || [self.selectList[i] isEqualToString:@"stock_hotnews"]) {
                continue;
            }
            
            //取得除自选新闻的其他每组新闻的ID个数
            NSString *newID = self.selectList[i];
            NSArray *newsID = newslist[newID];
            
            for (int j=0; j<newsID.count; j++) {
                //从字典里取出每个ID
                NSDictionary *dic = newsID[j];
                NSString *idStr = dic[@"id"];
                
                if (j <= 4) {
                    [self.fiveIDs addObject:idStr];
                } else {
                    break;
                }
            }
            [self.allNewsID addObject:newsID];
        }
        
        //加载自选股新闻
        [self loadMyData];
        
    }];
}

//自选股新闻
- (void)loadMyData {
    
    NSString *urlstring = @"http://ifzq.gtimg.cn/appstock/news/info/search?type=3&page=1&n=20&_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350";
    
    NSDictionary *params = @{
                             @"symbol":@"sz002007%2Csz002155%2Csz002142%2Csz002202%2Csz002024%2Csh600002%2Csh600036%2Csh600016%2Csh600050%2Csh600028%2Cjj000600%2Chk00600%2Csz000600%2Csh600600%2C"
                             };
    
    [MyDataService requestURL:urlstring httpMethod:@"POST" params:[params mutableCopy] complection:^(id result) {
        
        
        NSDictionary *dic = result[@"data"];
        NSArray *data = dic[@"data"];
        
        self.myData = [NSMutableArray arrayWithCapacity:data.count];
        
        for (NSDictionary *dataDic in data) {
            
            SelectedModel *myModel = [[SelectedModel alloc] initWithDataDic:dataDic];
            
            [self.myData addObject:myModel];
        }
        
        self.tableView.myData = self.myData;
        self.tableView.allNewsID = self.allNewsID;
        
        
        //加载主界面的所有新闻
        [self loadAllData];
    }];
    
}

//主界面上的所有新闻
- (void)loadAllData {
    
    NSString *paramsStr = [self.fiveIDs componentsJoinedByString:@"%2C"];
    
    NSDictionary *params = @{
                                @"ids":[paramsStr stringByAppendingFormat:@"%%2C"]
                             };
    
    
    [MyDataService requestURL:NEWDETAILURL httpMethod:@"POST" params:[params mutableCopy] complection:^(id result) {
        
        NSArray *newslist = result[@"newslist"];
        
        self.allData = [NSMutableArray arrayWithCapacity:newslist.count];
        for (NSDictionary *dataDic in newslist) {
            
            NewsModel *newsModel = [[NewsModel alloc] initWithDataDic:dataDic];
            [self.allData addObject:newsModel];
        }
        
        self.tableView.data = self.allData;
        

        //数据加载完毕，显示tableView
        self.tableView.hidden = NO;
        //隐藏加载提示
        [super showLoading:NO];
        
        
        //如果是下拉刷新，收起下拉
        [self.tableView doneLoadingTableViewData];
        
        //刷新
        [self.tableView reloadData];

    }];
    
}



@end
