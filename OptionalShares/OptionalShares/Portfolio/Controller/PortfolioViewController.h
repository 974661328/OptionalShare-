//
//  PortfolioViewController.h
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "BaseViewController.h"

@class ChooseTableView;
@interface PortfolioViewController : BaseViewController


@property (weak, nonatomic) IBOutlet ChooseTableView *tableView;

@property(nonatomic,strong)NSMutableArray *data;


@end
