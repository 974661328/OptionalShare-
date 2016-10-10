//
//  NewsDetailViewController.h
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "BaseViewController.h"

@class NewsDetailTableView;
@interface NewsDetailViewController : BaseViewController

@property(nonatomic,strong)NewsDetailTableView *tableView;

//存储某一组的所有ID
@property (strong, nonatomic) NSMutableArray *newsID;

@property (assign, nonatomic) BOOL isZX;

@end
