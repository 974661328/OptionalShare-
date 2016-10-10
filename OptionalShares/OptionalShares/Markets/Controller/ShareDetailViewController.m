//
//  ShareDetailViewController.m
//  OptionalShares
//
//  Created by seven on 14-10-14.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "ShareDetailViewController.h"
#import "SharesTableView.h"
#import "MyDataService.h"
#import "SharesModel.h"
#import "HeaderView.h"
#import "SelectedModel.h"
#import "ChooseModel.h"
#import <ShareSDK/ShareSDK.h>


@interface ShareDetailViewController ()

@end

@implementation ShareDetailViewController {
    NSString *identifyOne;
    NSString *identifyTwo;
    
    BOOL isLoad;
}

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"nihao" object:nil];

    //1.创建collectionView
    [self _createCollectionView];
    
    //2.创建分享视图
    [self _createShareView];
    
    //3.加载数据
    [self _loadData];
    
    //4.滚动到collection当前位置
    [self scrollToRow];
    
//    [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(_loadData) userInfo:nil repeats:YES];

}

//通知方法
- (void)notificationAction:(NSNotification *)notification {
    
    HeaderView *headView = notification.object;
    NSString *title = headView.data[1];
    
    self.title = title;

}

- (void)_createCollectionView {
    
    //1.创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.width, self.view.height);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    //2.初始collectionView对象
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView .backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    [self.view addSubview:_collectionView];
    
    //3.注册collectionView单元格
    identifyOne = @"CollectionCellOne";
    identifyTwo = @"CollectionCellTwo";
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifyOne];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifyTwo];
    
    //未加载数据，隐藏collectionView
    self.collectionView.hidden = YES;
    //提示加载
    [super showLoading:YES];
}

- (void)_createShareView {
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-40, kScreenWidth, 40)];
    myView.backgroundColor = [UIColor colorWithRed:50/255.0 green:52/255.0 blue:53/255.0 alpha:1];

    [self.view insertSubview:myView aboveSubview:self.collectionView];
    
    
    UIButton *goodButton = [UIButton buttonWithType:UIButtonTypeCustom];
    goodButton.frame = CGRectMake(0, 5, kScreenWidth/3, 30);
    [goodButton setTitle:@"我看好" forState:UIControlStateNormal];
    goodButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [goodButton setTitleColor:[UIColor colorWithRed:40/255.0 green:120/255.0 blue:240/255.0 alpha:1] forState:UIControlStateNormal];
    [myView addSubview:goodButton];
    
    UIButton *badButton = [UIButton buttonWithType:UIButtonTypeCustom];
    badButton.frame = CGRectMake(goodButton.right, 5, kScreenWidth/3, 30);
    [badButton setTitle:@"我不看好" forState:UIControlStateNormal];
    badButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [badButton setTitleColor:[UIColor colorWithRed:40/255.0 green:120/255.0 blue:240/255.0 alpha:1] forState:UIControlStateNormal];
    [myView addSubview:badButton];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(badButton.right, 0, kScreenWidth/3, 40)];
    [button setImage:[UIImage imageNamed:@"toolBarShare.png"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [myView addSubview:button];
}

//加载数据
- (void)_loadData {
    
    //1.加载股票数据
    [self loadSharesData];
    
 
}

//1.加载股票数据
- (void)loadSharesData {
    
    //1>构建URL
    NSString *urlString = nil;
    NSString *newsUrl = nil;
    
    if (self.isHS) {        //沪深
        
        urlString = [NSString stringWithFormat:@"%@&code=%@",kHSDETAILURL,self.code];
        if (self.isHead) {
            
            newsUrl = [NSString stringWithFormat:@"%@&t=%@",kHEADLISTURL,self.code];
        
        } else {
            
            newsUrl = [NSString stringWithFormat:@"%@&symbol=%@&n=6",kNEWSURL,self.code];
        }
    } else if (self.isHK) {     //港股
        
        urlString = [NSString stringWithFormat:@"%@&code=%@",kHKDETAILURL,self.code];
        if (self.isHead) {   
            //http://ifzq.gtimg.cn/appstock/app/StockRank/hk?board=hkHSI&metric=change_rate&pageSize=20&reqPage=0&order=asc&var_name=a&r=8662
            newsUrl = [NSString stringWithFormat:@"%@&board=%@",kHEADHKLISTURL,self.code];
        } else {
            
            newsUrl = [NSString stringWithFormat:@"%@&symbol=%@&n=6",kNEWSURL,self.code];
        }
    } else if (self.isUS) {     //美股
        
        urlString = [NSString stringWithFormat:@"%@&code=%@",kUSDETAILURL,self.code];
        NSArray *array = [self.code componentsSeparatedByString:@"."];
        if (array.count == 0) {
            return;
        }
        NSString *usCode = array[0];
        newsUrl = [NSString stringWithFormat:@"%@&symbol=%@&n=20",kNEWSURL,usCode];
    }
    
    //2.请求股票数据
    [self loadDetailSharesData:urlString newsString:newsUrl];
    
}

//2.请求股票数据
- (void)loadDetailSharesData:(NSString *)urlString newsString:(NSString *)newsUrl {
    
    [MyDataService requestURL:urlString httpMethod:@"GET" params:nil complection:^(id result) {
        
        NSDictionary *data = result[@"data"];
        NSDictionary *detail = data[self.code];
        
        self.sharesModel = [[SharesModel alloc] initWithDataDic:detail];
        
        //3.请求涨跌幅数据/请求新闻数据
        [self loadSharesNewsData:newsUrl];
    }];

}

//3.请求涨跌幅数据/请求新闻数据
- (void)loadSharesNewsData:(NSString *)newsUrl {
    
    if (self.isUS && self.isHead) { //美股头视图的股票详情中无其他数据
        
    }
    else if (self.isHead) {          //在其他头视图的股票详情中有涨跌幅数据
        
        //请求涨跌幅数据
        [MyDataService requestURL:newsUrl httpMethod:@"GET" params:nil complection:^(id result) {
            
            NSArray *datas = result[@"data"];
            
            self.newsData = [NSMutableArray arrayWithCapacity:datas.count];
            
            for (NSDictionary *dic in datas) {
                
                ChooseModel *csModel = [[ChooseModel alloc] initWithDataDic:dic];
                
                [self.newsData addObject:csModel];
            }
            
            //4.加载K线图数据
            [self loadKlinesData];
            
        }];
        
    }
    else {                  //一般股份的详情中有新闻信息
        
        //请求新闻数据
        [MyDataService requestURL:newsUrl httpMethod:@"GET" params:nil complection:^(id result) {
            
            NSDictionary *dic = result[@"data"];
            NSArray *data = dic[@"data"];
            
            self.newsData = [NSMutableArray arrayWithCapacity:data.count];
            
            for (NSDictionary *dataDic in data) {
                
                SelectedModel *newsModel = [[SelectedModel alloc] initWithDataDic:dataDic];
                
                [self.newsData addObject:newsModel];
                
            }
            
            //4.加载K线图数据
            [self loadKlinesData];
            
        }];
        
    }
}

//4.加载K线图数据
- (void)loadKlinesData {

    NSString *klineString = nil;
    
    //1.组头和美股日K线图数据 &param=sh00001,day,,,320
    if (self.isHead || self.isUS) {
        
        klineString = [kHEADKLINE stringByAppendingFormat:@"&param=%@,day,,,320",self.code];
    }
    //2.香港日K线图数据 &param=hk01318,day,,,320,qfq
    else if (self.isHK) {
        
        klineString = [kHKKLINE stringByAppendingFormat:@"&param=%@,day,,,320,qfq",self.code];
    }
    //3.自选项、沪深日K线图数据 &param=sz002259,day,,,320,qfq
    else {
       
        klineString = [kHSKLINE stringByAppendingFormat:@"&param=%@,day,,,320,qfq",self.code];
    }
    
    [MyDataService requestURL:klineString httpMethod:@"GET" params:nil complection:^(id result) {
        
        NSDictionary *data = result[@"data"];
        NSDictionary *detail = data[self.code];
        
//        if (self.isHead || self.isUS) {
//            
//            self.dayData = [detail objectForKey:@"day"];
//        } else {
//            
//            self.dayData = [detail objectForKey:@"qfqday"];
//        }
        self.dayData = [detail objectForKey:@"day"];
        if (self.dayData == nil) {
            
            self.dayData = [detail objectForKey:@"qfqday"];
        }

        
        //加载完成，显示collectionView
        self.collectionView.hidden = NO;
        //隐藏加载提示
        [super showLoading:NO];
        
        [self.collectionView reloadData];
        
        //移除加载提示
        if (isLoad) {
            UIActivityIndicatorView *activity = (UIActivityIndicatorView *)[self.view viewWithTag:123];
            [activity stopAnimating];
            [activity removeFromSuperview];
        }
        
        //下载完毕
        isLoad = NO;
        
    }];
}


//移动到当前的位置
- (void)scrollToRow {
    
    if (self.code != nil) {
        NSInteger index = [self.itemData indexOfObject:self.code];
        
        self.currentIndex = index;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

//分享按钮
- (void)shareAction:(UIButton *)button {
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"默认分享内容，没内容时显示"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.sharesdk.cn"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}


#pragma mark - UICollectionView delegate
//1.指定单元格的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.itemData.count;
    
}

//2.获取单元格对象
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = nil;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifyOne forIndexPath:indexPath];
    
    SharesTableView *tableView = [[SharesTableView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight-30) style:UITableViewStylePlain];
    
    [tableView doneLoadingTableViewData];
    
    __weak ShareDetailViewController *weakSelf = self;
    [tableView setPullBlock:^{
       
        [weakSelf _loadData];
    }];
    
    tableView.tag = indexPath.row+10;
    
    
    if (self.isHD) {
        tableView.isHD = self.isHD;
        tableView.itemData = [self.itemData mutableCopy];
    }
    if (self.isHead) {
        tableView.isHead = self.isHead;
        tableView.itemData = [self.itemData mutableCopy];
    }
    
    tableView.sharesModel = self.sharesModel;
    tableView.code = self.code;
    tableView.newsData = self.newsData;
    tableView.dayData = self.dayData;
    tableView.isUS = self.isUS;
    tableView.isHS = self.isHS;
    tableView.isHK = self.isHK;
    
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundColor = nil;
    [cell.contentView addSubview:tableView];
    
    return cell;
}

//3.解决复用
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
   
    
    UITableView *tableView = (UITableView *)[cell.contentView viewWithTag:indexPath.row+10];
    
    [tableView removeFromSuperview];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x/kScreenWidth;
    if (index != self.currentIndex) {
        if (!isLoad) {
            
            //加载提示
            [self blackLoadingView];
            //标志正在加载
            isLoad = YES;
            
            self.code = self.itemData[index];
            [self _loadData];
            self.currentIndex = index;
        }
    }
    
}

- (void)blackLoadingView {
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicator setCenter:self.view.center];
    activityIndicator.tag = 123;
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
}

@end
