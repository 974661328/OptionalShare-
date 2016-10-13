//
//  HuShenViewController.h
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "BaseViewController.h"

@class MarketsTableView;
@interface HuShenViewController : BaseViewController

@property(nonatomic,strong)MarketsTableView *tableView;

@property(nonatomic,assign)BOOL isRefresh;


@end
