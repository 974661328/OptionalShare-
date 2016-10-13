//
//  SelectedModel.m
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
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
