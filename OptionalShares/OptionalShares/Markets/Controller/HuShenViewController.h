//
//  HuShenViewController.h
//  OptionalShares
//
//  Created by seven on 14-10-11.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "BaseViewController.h"

@class MarketsTableView;
@interface HuShenViewController : BaseViewController

@property(nonatomic,strong)MarketsTableView *tableView;

@property(nonatomic,assign)BOOL isRefresh;


@end
