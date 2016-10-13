//
//  MoreDataViewController.m
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "MoreDataViewController.h"
#import "MoreDataTableView.h"
#import "MyDataService.h"
#import "ChooseModel.h"


@interface MoreDataViewController ()

@end

@implementation MoreDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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
    __weak MoreDataViewController *weakSelf = self;
    [self.tableView setPullBlock:^{
        __strong MoreDataViewController *strongSelf = weakSelf;
        
        [strongSelf _loadData];
    }];
  
}

- (void)_crreatTabelView {
    
    self.tableView = [[MoreDataTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    if (self.isSub) {
        self.tableView.top = 64;
        self.tableView.height -= 64;
    }

    //数据未加载，隐藏tabelView
    self.tableView.hidden = YES;
    //提示加载
    [super showLoading:YES];

    [self.view addSubview:self.tableView];

}

- (void)_loadData {
    
    NSString *urlstring = nil;
    if (self.isHS) {
        //沪深数据
        
        if (self.isHotCell) {
            
            urlstring = [HSHOTCELLURL stringByAppendingString:self.tString];
        } else {
            
            urlstring = [HSBASEURL stringByAppendingString:self.tString];
        }
        
        if (self.isAsc) {
            urlstring = [urlstring stringByAppendingFormat:@"&o=1"];
        } else {
            urlstring = [urlstring stringByAppendingFormat:@"&o=0"];
        }
        
        if ([self.tString isEqualToString:@"&t=ranka/trunr"]) {
            self.isHsl = YES;
        }

    } else if (self.isHK) {
        //港股数据
        if (self.isHotCell) {
            
            urlstring = [HKHOTCELLURL stringByAppendingString:self.tString];
            
            if (self.isAsc) {
                
                urlstring = [urlstring stringByAppendingFormat:@"&s=asc"];
            } else {
                urlstring = [urlstring stringByAppendingFormat:@"&s=desc"];
            }
        } else {
            urlstring = [HKBASEURL stringByAppendingString:self.tString];
            
            if (self.isAsc) {
                
                urlstring = [urlstring stringByAppendingFormat:@"&order=asc"];
            } else {
                urlstring = [urlstring stringByAppendingFormat:@"&order=desc"];
            }
        }
 
    } else if (self.isUS) {
        
        //美股数据
        urlstring = [USBASEURL stringByAppendingString:self.tString];
        
        if (self.isAsc) {
            
            urlstring = [urlstring stringByAppendingFormat:@"&order=asc"];
        } else {
            urlstring = [urlstring stringByAppendingFormat:@"&order=desc"];
        }

    }
    
    
    [MyDataService requestURL:urlstring httpMethod:@"GET" params:nil complection:^(id result) {
        
        
        NSArray *datas = result[@"data"];
        
        NSMutableArray *csDatas = [NSMutableArray arrayWithCapacity:datas.count];
        for (NSDictionary *dic in datas) {
            
            ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
            
            [csDatas addObject:csModel];
        }
        
        //数据加载完毕，显示tableView
        self.tableView.hidden = NO;
        //隐藏加载提示
        [super showLoading:NO];
        
        [self.tableView doneLoadingTableViewData];
        
        self.tableView.isColor = self.isColor;
        self.tableView.data = csDatas;
        self.tableView.isHsl = self.isHsl;
        self.tableView.isHS = self.isHS;
        self.tableView.isHK = self.isHK;
        self.tableView.isUS = self.isUS;
        [self.tableView reloadData];
    }];
    
    
}

@end
