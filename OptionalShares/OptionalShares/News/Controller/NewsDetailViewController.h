//
//  NewsDetailViewController.h
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "BaseViewController.h"

@class NewsDetailTableView;
@interface NewsDetailViewController : BaseViewController

@property(nonatomic,strong)NewsDetailTableView *tableView;

//存储某一组的所有ID
@property (strong, nonatomic) NSMutableArray *newsID;

@property (assign, nonatomic) BOOL isZX;

@end
