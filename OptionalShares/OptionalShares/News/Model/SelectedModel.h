//
//  SelectedModel.h
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "BaseModel.h"

/*
 "data": {
 "total_num": 2905,
 "total_page": 146,
 "data": [{
 "time": "2014-10-09 10:42:58",
 "id": "nesfinance-20141009019758",
 "type": "2",
 "symbol": "sh600028",
 "title": "\u745e\u94f6\u964d\u4e2d\u56fd\u77f3\u5316\u76ee\u6807\u4ef7\u81f38.9\u5143 \u7ef4\u6301\u201c\u4e70\u5165\u201d",
 "url": "http:\/\/finance.qq.com\/a\/20141009\/019758.htm"
 }
 */
@interface SelectedModel : BaseModel

@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *idStr;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *symbol;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *url;

@end
