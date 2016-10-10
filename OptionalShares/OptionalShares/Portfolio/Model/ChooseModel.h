//
//  ChooseModel.h
//  OptionalShares
//
//  Created by seven on 14-10-10.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "BaseModel.h"

/*
 
 {
 "code": 0,
 "msg": "ok",
 "data": {
 "market_stat": {
 "hk": "open",
 "sh": "close",
 "sz": "close",
 "us": "close",
 "sq": "close",
 "ds": "close",
 "zs": "close"
 },
 "list": [{
 "tips": "0",
 "code": "sz002007",
 "isdelay": "0",
 "state": "",
 "sclx": "51",
 "name": "\u534e\u5170\u751f\u7269",
 "symbol": "002007",
 "zxj": "31.09",
 "zd": "1.09",
 "zdf": "3.63",
 "volume": "128034",
 "amount": "39538",
 "hsl": "2.22",
 "sz": "180.73",
 "type": "GP-A"
 }
 */

/*
 "name": "\u5357\u901a\u79d1\u6280",
 "code": "sh600862",
 "zxj": "8.64",
 "zd": "0.79",
 "zdf": "10.06",
 "hsl": "0.25",
 "state": "",
 "zf": "0.00"
 
 
 "qtcode": "pjHKD",
 "hbuy": "78.86",
 "cbuy": "78.31"
 */


@interface ChooseModel : BaseModel

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *symbol;
@property(nonatomic,copy)NSString *zxj;
@property(nonatomic,copy)NSString *zdf;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *zd;
@property(nonatomic,copy)NSString *hsl;
@property(nonatomic,copy)NSString *zf;
@property(nonatomic,copy)NSString *cje;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *qtcode;
@property(nonatomic,copy)NSString *hbuy;
@property(nonatomic,copy)NSString *cbuy;

@property(nonatomic,assign)BOOL isColor;

@end
