//
//  NewsModel.h
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "BaseModel.h"

/*
 {
 "ret": 0,
 "newslist": [{
 "id": "FIN2014100903560719",
 "uinnick": "\u817e\u8baf\u65b0\u95fb",
 "uinname": "qqnews",
 "title": "\u8d44\u672c\u5e02\u573a\u5f00\u653e\u4e0b\u4e00\u6b65\uff1a\u8bd5\u70b9RQDII",
 "surl": "http:\/\/finance.qq.com\/a\/20141009\/035607.htm",
 "weiboid": "",
 "commentid": "1015608529",
 "url": "http:\/\/finance.qq.com\/a\/20141009\/035607.htm",
 "time": "2014-10-09 15:02:00",
 "timestamp": 1412838120,
 "articletype": "0",
 "thumbnails": ["http:\/\/inews.gtimg.com\/newsapp_ls\/0\/25370765_640330\/0"],
 "qishu": "",
 "source": "\u4e00\u8d22\u7f51",
 "imagecount": 0,
 "comment": "",
 "flag": "0",
 "thumbnails_qqnews": ["http:\/\/inews.gtimg.com\/newsapp_ls\/0\/25370765_150110\/0"],
 "voteId": "",
 "voteNum": "",
 "abstract": "\u672a\u6765\u5c06\u5141\u8bb8\u56fd\u5185\u5c45\u6c11\u6295\u6d77\u5916\u80a1\u5e02\uff0c\u5141\u8bb8\u4e2d\u4f01\u8d74\u5883\u5916\u53d1\u884c\u4eba\u6c11\u5e01\u80a1\u7968\u3002"
 }
 */

@interface NewsModel :BaseModel

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

@end
