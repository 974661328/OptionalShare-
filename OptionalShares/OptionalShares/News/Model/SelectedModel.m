//
//  SelectedModel.m
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "SelectedModel.h"

@implementation SelectedModel

- (NSDictionary *)attributeMapDictionary{
    
    /*
     @property(nonatomic,strong)NSString *time;
     @property(nonatomic,strong)NSString *idStr;
     @property(nonatomic,strong)NSString *type;
     @property(nonatomic,strong)NSString *symbol;
     @property(nonatomic,strong)NSString *title;
     @property(nonatomic,strong)NSString *url;
     */
    NSDictionary *mapAtt = @{
                             @"idStr":@"id",
                             @"title":@"title",
                             @"url":@"url",
                             @"time":@"time",
                             @"type":@"type",
                             @"symbol":@"symbol"
                             };
    
    
    return mapAtt;
}

@end
