//
//  MyDataService.h
//  01 NavigationTask
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
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
