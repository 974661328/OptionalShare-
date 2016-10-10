//
//  NewsViewController.h
//  OptionalShares
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "BaseViewController.h"

@class NewsTableView;
@interface NewsViewController : BaseViewController

@property (weak, nonatomic) IBOutlet NewsTableView *tableView;

//存储主界面的新闻
@property (strong, nonatomic) NSMutableArray *allData;
//存储主界面的自选新闻
@property (strong, nonatomic) NSMutableArray *myData;

//存储新闻所有的种类
@property (strong, nonatomic) NSMutableArray *allList;
//存储选择的新闻的种类
@property (strong, nonatomic) NSMutableArray *selectList;

//存储每一种类型新闻的所有ID
@property (strong, nonatomic) NSMutableArray *allNewsID;
//存储每一种类型新闻的前5条ID
@property (strong, nonatomic) NSMutableArray *fiveIDs;


@end
