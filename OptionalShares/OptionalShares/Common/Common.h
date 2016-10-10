//
//  Common.h
//  WXWeibo
//
//  Created by seven on 14-9-16.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#ifndef WXWeibo_Common_h
#define WXWeibo_Common_h


//获取屏幕的宽和高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


#define ios7 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)

//适配IOS6与IOS7
#define kNavigationHeight (ios7?0:64)


#define kNvgAndTabHeight (64+49)

//请求更多股份数据的URL
#define HSBASEURL @"http://ifzq.gtimg.cn/appstock/app/mktHs/rank?l=100&p=1&_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350"

#define HKBASEURL @"http://ifzq.gtimg.cn/appstock/app/mktHk/rank?l=20&p=1&_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350"

#define USBASEURL @"http://ifzq.gtimg.cn/appstock/app/mktUs/rank?lmt=100&order=desc&p=1&_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350"

#define HSHOTCELLURL @"http://ifzq.gtimg.cn/appstock/app/mktHs/industry?p=1&_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350"

#define HKHOTCELLURL @"http://ifzq.gtimg.cn/appstock/app/mktHk/industry?p=1&l=100&t=FNS4&s=desc&_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350"

//股份详情新闻URL
#define kNEWSURL @"http://ifzq.gtimg.cn/appstock/news/info/search?type=2&page=1&_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350"
#define kHEADLISTURL @"http://ifzq.gtimg.cn/appstock/app/StockRank/hs?l=10&p=1&e=chr&o=0&r=8326"
#define kHEADHKLISTURL @"http://ifzq.gtimg.cn/appstock/app/StockRank/hk?metric=change_rate&pageSize=20&reqPage=0&order=asc&var_name=a&r=8862"

//股份详情URL
#define kHSDETAILURL @"http://ifzq.gtimg.cn/appstock/app/minute/query?_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350"
#define kHKDETAILURL @"http://ifzq.gtimg.cn/appstock/app/HkMinute/query?p=1&_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350"
#define kUSDETAILURL @"http://ifzq.gtimg.cn/appstock/app/UsMinute/query?p=1&_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350"

//日K链接
#define kHEADKLINE @"http://ifzq.gtimg.cn/appstock/app/kline/kline?p=1&_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350"
#define kHSKLINE @"http://ifzq.gtimg.cn/appstock/app/fqkline/get?p=1&_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350"
#define kHKKLINE @"http://ifzq.gtimg.cn/appstock/app/hkfqkline/get?p=1&_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350"

//自选页面的新闻URL
#define NEWROOTSURL @"http://ifzq.gtimg.cn/appstock/support/remote/comp?notice=4&splashAD=115&banner=2&recommend=29&news=14&vipact=0&type=1&width=480&_appver=3.4.0&_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350"

#define NEWSELECTURL @"http://istock.qq.com/getQQNewsIndexMulti?_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350"

#define NEWDETAILURL @"http://istock.qq.com/getQQNewsListItems?_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_screenW=480&_screenH=800&_osVer=4.1.2&_uin=956013350"

#endif
