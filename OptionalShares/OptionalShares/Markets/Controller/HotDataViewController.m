//
//  HotDataViewController.m
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "HotDataViewController.h"
#import "HotTabelView.h"
#import "MyDataService.h"
#import "HotModel.h"


@interface HotDataViewController ()

@end

@implementation HotDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //1.创建tableView
    [self _crreatTabelView];
    
    //2.加载数据
    [self _loadData];
    
    //3.下拉刷新
    __weak HotDataViewController *weakSelf = self;
    [self.tableView setPullBlock:^{
        
        [weakSelf _loadData];
    }];
}

- (void)_crreatTabelView {
    
    self.tableView = [[HotTabelView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //数据未加载，隐藏tabelView
    self.tableView.hidden = YES;
    //提示加载
    [super showLoading:YES];
 
    [self.view addSubview:self.tableView];
}

- (void)_loadData {
    
    NSString *urlstring = nil;
    if (!self.isHK) {
        //沪深数据
        urlstring = @"http://ifzq.gtimg.cn/appstock/app/mktHs/rank?l=100&p=1&t=01/averatio&_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350";
        
        if (self.isAsc) {
            urlstring = [urlstring stringByAppendingFormat:@"&o=1"];
        } else {
            urlstring = [urlstring stringByAppendingFormat:@"&o=0"];
        }
    } else {
        //港股数据
        urlstring = @"http://ifzq.gtimg.cn/appstock/app/mktHk/industrylist?l=100&p=1&o=bd_zdf&_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350";

        if (self.isAsc) {
            
            urlstring = [urlstring stringByAppendingFormat:@"&s=asc"];
        } else {
            urlstring = [urlstring stringByAppendingFormat:@"&s=desc"];
        }
    }
    
    
    [MyDataService requestURL:urlstring httpMethod:@"GET" params:nil complection:^(id result) {
        
    
        NSArray *datas = result[@"data"];
        
        NSMutableArray *hotDatas = [NSMutableArray arrayWithCapacity:datas.count];
        for (NSDictionary *dic in datas) {
            
            HotModel *hotModel = [[HotModel alloc] initWithDataDic:dic];
            
            [hotDatas addObject:hotModel];
        }
        
        //数据加载完毕，显示tableView
        self.tableView.hidden = NO;
        //隐藏加载提示
        [super showLoading:NO];
        
        self.tableView.data = hotDatas;
        self.tableView.isHS = self.isHS;
        self.tableView.isHK = self.isHK;
        [self.tableView reloadData];
    }];
        
    
}

@end
