//
//  NewsModel.m
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

/*
 @property(nonatomic,copy)NSString *newsId;
 @property(nonatomic,copy)NSString *uinnick;
 @property(nonatomic,copy)NSString *uinname;
 @property(nonatomic,copy)NSString *title;
 @property(nonatomic,copy)NSString *surl;
 @property(nonatomic,copy)NSString *commentid;
 @property(nonatomic,copy)NSString *url;
 @property(nonatomic,copy)NSString *time;
 @property(nonatomic,copy)NSString *timestamp;
 @property(nonatomic,copy)NSString *articletype;
 @property(nonatomic,strong)NSArray *thumbnails;
 @property(nonatomic,copy)NSString *qishu;
 @property(nonatomic,copy)NSString *source;
 @property(nonatomic,copy)NSString *imagecount;
 @property(nonatomic,copy)NSString *flag;
 @property(nonatomic,strong)NSArray *thumbnails_qqnews;
 @property(nonatomic,copy)NSString *abstract;
 */


- (NSDictionary *)attributeMapDictionary{
    
    
    NSDictionary *mapAtt = @{
                             @"newsId":@"id",
                             @"uinnick":@"uinnick",
                             @"uinname":@"uinname",
                             @"title":@"title",
                             @"surl":@"surl",
                             @"commentid":@"commentid",
                             @"url":@"url",
                             @"time":@"time",
                             @"timestamp":@"timestamp",
                             @"articletype":@"articletype",
                             @"thumbnails":@"thumbnails",
                             @"qishu":@"qishu",
                             @"source":@"source",
                             @"imagecount":@"imagecount",
                             @"flag":@"flag",
                             @"thumbnails_qqnews":@"thumbnails_qqnews",
                             @"abstract":@"abstract",
                             };
    
    
    return mapAtt;
}

@end
