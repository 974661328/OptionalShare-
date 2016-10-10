//
//  MyDataService.m
//  01 NavigationTask
//
//  Created by seven on 14-9-6.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MyDataService.h"
#import "AFNetworking.h"

//#define BASE_URL @"https://api.weibo.com"

@implementation MyDataService

+ (void)requestURL:(NSString *)urlstring
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)params
       complection:(void(^)(id result))block {
    
    //1.构造URL
//    urlstring = [BASE_URL stringByAppendingString:urlstring];
    NSURL *url = [NSURL URLWithString:urlstring];
    
    //2.构造request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:method];
    
    //1>拼接请求参数:username=wxhl&password=123456&key=value&....
    NSMutableString *paramsString = [NSMutableString string];
    NSArray *allKeys = [params allKeys];
    for (int i=0; i<allKeys.count; i++) {
        NSString *key = allKeys[i];
        NSString *value = params[key];
        
        [paramsString appendFormat:@"%@=%@",key,value];
        
        if (i < params.count-1) {
            [paramsString appendString:@"&"];
        }
    }
    
    //2>添加请求参数
    /*
     请求参数的格式1：username=wxhl&password=123456&key=value&....
     请求参数的格式2：JSON：{username:wxhl,password:12345,....}
     */
    //将字典 ---> JSON字符串
    //JSONKit
//    NSString *jsonString = [params JSONString];
//    NSLog(@"%@", jsonString);

    
    //3>请求方式
    /*
     GET： 参数拼接在URL后面
     POST：参数拼接到请求体中
     */
    if ([method isEqualToString:@"GET"]) {
        //http://wxhl.com/search?q=tttt&
        
        NSString *separe = url.query?@"&":@"?";
        NSString *paramsURL = [NSString stringWithFormat:@"%@%@%@",urlstring,separe,paramsString];
        
        request.URL = [NSURL URLWithString:paramsURL];
        
    } else if ([method isEqualToString:@"POST"]) {
        
        NSData *bodyData = [paramsString dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodyData];
    }
    
    //3.构造链结对象
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
        if (connectionError != nil) {
            NSLog(@"网络请求失败：%@", connectionError);
            return ;
        }
        
        //1.解析JSON
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //2.回到主线程
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            //回调block
            block(result);
        });
    }];
    
}

+ (void)requestURL:(NSString *)urlstring
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)params
              data:(NSMutableDictionary *)datas
       complection:(void (^)(id result))block {
    
//    urlstring = [BASE_URL stringByAppendingString:urlstring];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    if ([method isEqualToString:@"GET"]) {
        
        [manager GET:urlstring parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            block(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"网络请求失败:%@",error);
        }];
    }
    else if ([method isEqualToString:@"POST"]) {
        
        if (datas != nil) {     //判断文件是否需要上传
            
            //上传文件的POST请求
            AFHTTPRequestOperation *operation = [manager POST:urlstring parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                //将需要上传的文件数据添加到formData中
                
                //循环遍历需要上传的文件数据
                for (NSString *name in datas) {
                    
                    NSData *data = datas[name];
                    
                    [formData appendPartWithFileData:data name:name fileName:name mimeType:@"image/jpeg"];
                }
                
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                block(responseObject);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"网络请求失败:%@",error);
            }];
            
            //设置上传的进度监听
            /**
             *
             *  @param bytesWritten              一个数据包的大小
             *  @param totalBytesWritten         已经上传的数据大小
             *  @param totalBytesExpectedToWrite 文件总大小
             *
             *  @return <#return value description#>
             */
            [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
               
                CGFloat progress = totalBytesWritten/(CGFloat)totalBytesExpectedToWrite;
                NSLog(@"进度：%.1f",progress);
            }];

        } else {
            
            
            [manager POST:urlstring parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                block(responseObject);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                 NSLog(@"网络请求失败:%@",error);
            }];
            
        }
    }
}


@end
