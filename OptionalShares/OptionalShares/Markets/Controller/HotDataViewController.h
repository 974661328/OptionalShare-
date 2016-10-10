//
//  HotDataViewController.h
//  OptionalShares
//
//  Created by seven on 14-10-13.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "BaseViewController.h"

@class HotTabelView;
@interface HotDataViewController : BaseViewController

@property(nonatomic,strong)HotTabelView *tableView;

@property(nonatomic,assign)BOOL isHK;
@property(nonatomic,assign)BOOL isHS;
@property(nonatomic,assign)BOOL isAsc;

- (void)_loadData;

@end
