//
//  PortfolioViewController.h
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "BaseViewController.h"

@class ChooseTableView;
@interface PortfolioViewController : BaseViewController


@property (weak, nonatomic) IBOutlet ChooseTableView *tableView;

@property(nonatomic,strong)NSMutableArray *data;


@end
