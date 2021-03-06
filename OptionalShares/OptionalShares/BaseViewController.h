//
//  BaseViewController.h
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDataService.h"

@class MBProgressHUD;
@class AFURLConnectionOperation;
@interface BaseViewController : UIViewController{
    
    UIView *_tipView;
    
    MBProgressHUD *_hud;
    UIWindow *_tipWindow;
}

//显示加载提示
- (void)showLoading:(BOOL)show;
- (void)showLoading:(BOOL)show locationOfHeight:(NSInteger)height;

//显示hud提示
- (void)showHUD:(NSString *)title;
- (void)hideHUD;

//完成的提示
- (void)completeHUD:(NSString *)title;

//状态栏提示
- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
            operation:(AFURLConnectionOperation *)operation;

@end
