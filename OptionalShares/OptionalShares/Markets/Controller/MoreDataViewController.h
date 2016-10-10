//
//  MoreDataViewController.h
//  OptionalShares
//
//  Created by seven on 14-10-13.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "BaseViewController.h"

@class MoreDataTableView;
@interface MoreDataViewController : BaseViewController

@property(nonatomic,strong)MoreDataTableView *tableView;


//用于判断是沪深、港股和美股
@property(nonatomic,assign)BOOL isHS;
@property(nonatomic,assign)BOOL isHK;
@property(nonatomic,assign)BOOL isUS;

//判断升序降序
@property(nonatomic,assign)BOOL isAsc;
//字体颜色
@property(nonatomic,assign)BOOL isColor;
//热门单元格
@property(nonatomic,assign)BOOL isHotCell;
//判断换手率
@property(nonatomic,assign)BOOL isHsl;

//tableView高度减64
@property(nonatomic,assign)BOOL isSub;

//URL的一个请求参数
@property(nonatomic,strong)NSString *tString;

- (void)_loadData;

@end
