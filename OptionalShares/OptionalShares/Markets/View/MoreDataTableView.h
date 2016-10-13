//
//  MoreDataTableView.h
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "BaseTableView.h"

@interface MoreDataTableView : BaseTableView

@property(nonatomic,assign)BOOL isHS;
@property(nonatomic,assign)BOOL isHK;
@property(nonatomic,assign)BOOL isUS;

//倒序
@property(nonatomic,assign)BOOL isReverse;

//字体颜色
@property(nonatomic,assign)BOOL isColor;

//判断换手率
@property(nonatomic,assign)BOOL isHsl;

//存所有数据的code
@property(nonatomic,strong)NSMutableArray *itemData;

@end
