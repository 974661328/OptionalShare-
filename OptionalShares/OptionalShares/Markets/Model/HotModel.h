//
//  HotModel.h
//  OptionalShares
//
//  Created by seven on 14-10-10.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "BaseModel.h"

/*
 "data": {
 "01\/averatio\/0": [{
 "bd_name": "\u4fe1\u6258",
 "bd_code": "pt013400",
 "bd_zxj": "16.773",
 "bd_zd": "0.179",
 "bd_zdf": "1.08",
 "nzg_code": "sh600816",
 "nzg_name": "\u5b89\u4fe1\u4fe1\u6258",
 "nzg_zxj": "24.58",
 "nzg_zd": "0.46",
 "nzg_zdf": "1.91"
 
 "bd_name": "\u623f\u5730\u4ea7",
 "bd_code": "FNS33",
 "bd_zxj": "42.18",
 "bd_zdf": "-1.30",
 "bd_zd": "-0.56",
 "nzg_zdf": "15.19",
 "nzg_zd": "0.02",
 "nzg_zxj": "0.182",
 "nzg_name": "\u8363\u4e30\u56fd\u9645",
 "corps": 152,
 "nzg_code": "hk00063",
 "volume": 837518343,
 "amount": 2917780431.25,
 "sz": 24771.267
 */
@interface HotModel : BaseModel

@property(nonatomic,copy)NSString *bd_name;
@property(nonatomic,copy)NSString *bd_code;
@property(nonatomic,copy)NSString *bd_zxj;
@property(nonatomic,copy)NSString *bd_zd;
@property(nonatomic,copy)NSString *bd_zdf;
@property(nonatomic,copy)NSString *nzg_code;
@property(nonatomic,copy)NSString *nzg_name;
@property(nonatomic,copy)NSString *nzg_zxj;
@property(nonatomic,copy)NSString *nzg_zd;
@property(nonatomic,copy)NSString *nzg_zdf;
@property(nonatomic,assign)NSInteger corps;
@property(nonatomic,assign)NSInteger volume;
@property(nonatomic,assign)CGFloat amount;
@property(nonatomic,assign)CGFloat sz;


@end
