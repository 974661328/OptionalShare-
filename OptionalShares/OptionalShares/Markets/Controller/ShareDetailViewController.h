//
//  ShareDetailViewController.h
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "BaseViewController.h"

@class SharesModel;
@interface ShareDetailViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@property(nonatomic,assign)BOOL isHS;
@property(nonatomic,assign)BOOL isHK;
@property(nonatomic,assign)BOOL isUS;
@property(nonatomic,assign)BOOL isHead;

@property(nonatomic,strong)UICollectionView *collectionView;

//记录当前位置
@property(nonatomic,assign)NSInteger currentIndex;

//用于构建URL
@property(nonatomic,copy)NSString *code;

//接受数据
@property(nonatomic,strong)NSMutableArray *data;
//接受新闻信息
@property(nonatomic,strong)NSMutableArray *newsData;

//接受日、周、月K数据
@property(nonatomic,strong)NSArray *dayData;

@property(nonatomic,strong)SharesModel *sharesModel;

//接受一组数据
@property(nonatomic,strong)NSArray *itemData;

@property(nonatomic,assign)BOOL isHD;


@end
