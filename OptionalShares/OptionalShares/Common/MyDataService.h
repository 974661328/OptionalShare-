//
//  MyDataService.h
//  01 NavigationTask
//
//  Created by seven on 14-9-6.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyDataService : NSObject

+ (void)requestURL:(NSString *)urlstring
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)params
       complection:(void(^)(id result))block;

+ (void)requestURL:(NSString *)urlstring
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)params
              data:(NSMutableDictionary *)datas
       complection:(void (^)(id result))block;

@end
