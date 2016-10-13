//
//  NewsTableView.h
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "BaseTableView.h"

@interface NewsTableView : BaseTableView {
    BOOL isShow[20];
}

//存储主界面的自选新闻
@property (strong, nonatomic) NSMutableArray *myData;

//存储每一种类型新闻的所有ID（自选新闻除外）
@property (strong, nonatomic) NSMutableArray *allNewsID;

@end
