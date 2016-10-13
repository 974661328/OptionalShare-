//
//  HotDataViewController.h
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
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
