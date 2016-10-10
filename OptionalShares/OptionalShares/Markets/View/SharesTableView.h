//
//  SharesTableView.h
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "BaseTableView.h"

@class SharesModel;
@interface SharesTableView : BaseTableView

@property(nonatomic,assign)BOOL isYes;

@property(nonatomic,assign)BOOL isHS;
@property(nonatomic,assign)BOOL isHK;
@property(nonatomic,assign)BOOL isUS;
@property(nonatomic,assign)BOOL isHead;

@property(nonatomic,copy)NSString *code;
@property(nonatomic,strong)NSArray *newsData;

@property(nonatomic,strong)NSMutableArray *itemData;

//接受日、周、月K数据
@property(nonatomic,strong)NSArray *dayData;


@property(nonatomic,strong)SharesModel *sharesModel;

@property(nonatomic,assign)UIButton *selectedButton;

//判断是否是点击的是头数据里的股票列表
@property(nonatomic,assign)BOOL isHD;

@end
