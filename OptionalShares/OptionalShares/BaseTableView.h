//
//  BaseTableView.h
//  WXWeibo
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

typedef void(^PullDownFinish)(void);

@interface BaseTableView : UITableView<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate> {
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
    UIButton *_refreshFooterButton;
    BOOL _upLoading;

}

@property(nonatomic,copy)PullDownFinish pullBlock;
@property(nonatomic,copy)PullDownFinish upBlock;

//数据
@property(nonatomic,strong)NSMutableArray *data;

//是否显示下拉刷新
@property(nonatomic,assign)BOOL refreshHeader;

//是否是最后一页
@property(nonatomic,assign)BOOL isLastPage;

- (void)_createView;

//结束(收起)下拉刷新
- (void)doneLoadingTableViewData;

@end
