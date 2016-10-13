//
//  KMapView.h
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KMapView : UIView

//接受日、周、月K数据
@property(nonatomic,strong)NSArray *dayData;
@property(nonatomic,strong)NSArray *weekData;
@property(nonatomic,strong)NSArray *monthData;

@property(nonatomic,copy)NSString *code;
@property(nonatomic,assign)BOOL isHS;
@property(nonatomic,assign)BOOL isHK;
@property(nonatomic,assign)BOOL isUS;
@property(nonatomic,assign)BOOL isHead;

@end
