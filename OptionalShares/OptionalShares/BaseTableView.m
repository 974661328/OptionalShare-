//
//  BaseTableView.m
//  WXWeibo
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {

        [self _createView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self _createView];
}

- (void)_createView {
    
    [self setDataSource:self];
    [self setDelegate:self];
    
    //清除背景
    self.backgroundColor = [UIColor clearColor];
    self.backgroundColor = nil;
    
    //1.创建下拉刷新的控件
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    _refreshHeaderView.backgroundColor = [UIColor clearColor];
    [self addSubview:_refreshHeaderView];
    
    _refreshHeader = YES;
    
    
    //2.创建上拉加载控件
    _refreshFooterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _refreshFooterButton.frame = CGRectMake(0, 0, self.width, 40);
    _refreshFooterButton.backgroundColor = [UIColor clearColor];
    [_refreshFooterButton setTitle:@"上拉加载更多" forState:UIControlStateNormal];
    [_refreshFooterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _refreshFooterButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [_refreshFooterButton addTarget:self action:@selector(loadMoreAction) forControlEvents:UIControlEventTouchUpInside];
    _refreshFooterButton.hidden = YES;
    
    
    UIActivityIndicatorView *loadView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadView.frame = CGRectMake(90, 10, 20, 20);
    [loadView stopAnimating];
    loadView.tag = 200;
    [_refreshFooterButton addSubview:loadView];
    
    //设置table表尾视图
    self.tableFooterView = _refreshFooterButton;
}

- (void)setRefreshHeader:(BOOL)refreshHeader {
    
    _refreshHeader = refreshHeader;
    
    if (!_refreshHeader) {
        [_refreshHeaderView removeFromSuperview];
    }
}

- (void)setIsLastPage:(BOOL)isLastPage {
    _isLastPage = isLastPage;
    
    if (!isLastPage) {
        [_refreshFooterButton setTitle:@"上拉加载更多" forState:UIControlStateNormal];
        [_refreshFooterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _refreshFooterButton.enabled = YES;
        
    } else {
        [_refreshFooterButton setTitle:@"加载完成" forState:UIControlStateNormal];
        [_refreshFooterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _refreshFooterButton.enabled = NO;
    }
    
    UIActivityIndicatorView *loadView = (UIActivityIndicatorView *)[_refreshFooterButton viewWithTag:200];
    [loadView stopAnimating];
    
    _upLoading = NO;
}

- (void)setData:(NSMutableArray *)data {
    
    if (_data != data) {
        _data = data;
        
        //加载完数据才将‘加载更多’添加到表尾
        if (data.count > 0) {
            _refreshFooterButton.hidden = NO;
        } else {
            _refreshFooterButton.hidden = YES;
        }
    }
}


//加载更多的事件
- (void)loadMoreAction {

    if (_isLastPage) {
        return;
    }
    
    _upLoading = YES;
    
    _refreshFooterButton.enabled = NO;
    [_refreshFooterButton setTitle:@"正在加载..." forState:UIControlStateNormal];
    [_refreshFooterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIActivityIndicatorView *loadView = (UIActivityIndicatorView *)[_refreshFooterButton viewWithTag:200];
    [loadView startAnimating];
    
    //回调block
    if (self.upBlock) {
        
        
        self.upBlock();
    
        
    }
    
    //恢复上拉
//    [self performSelector:@selector(setIsLastPage:) withObject:@NO afterDelay:2];
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}


#pragma mark Data Source Loading / Reloading Methods
- (void)reloadTableViewDataSource{
    
	_reloading = YES;
    

}

- (void)doneLoadingTableViewData {
    if (_reloading) {
        
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
    //视图滑动末尾：偏移量 + 视图的高度 = 内容的高度
    CGFloat h1 = scrollView.contentOffset.y + CGRectGetHeight(scrollView.bounds);
    CGFloat h2 = scrollView.contentSize.height;
    
    if (h1 - h2 > 30 && !_upLoading) {
        
        [self loadMoreAction];
    }
}

#pragma mark - EGORefreshTableHeaderDelegate
//下拉到一定距离，手指放开时调用
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
    
    [self reloadTableViewDataSource];
//    _reloading = YES;
    
    //回调block
    if (self.pullBlock) {
        self.pullBlock();
    }
}

//返回当前刷新的状态
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
    
    return _reloading;
}

//取得下拉刷新的时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
    
    return [NSDate date];
}


@end
