//
//  MarketsTableView.h
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "BaseTableView.h"


@interface MarketsTableView : BaseTableView {
    //判断组是否展开(环球信息的组需要展开和收缩)
    BOOL isShow[10];
}

//判断是否有头视图
@property(nonatomic,assign)BOOL isHead;
//判断是否有热门数据
@property(nonatomic,assign)BOOL isHot;

//判断是否是环球行情
@property(nonatomic,assign)BOOL isRound;
@property(nonatomic,assign)BOOL isHK;
@property(nonatomic,assign)BOOL isUS;

//用于接收组头名称
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSMutableArray *itemDatas;

@end
