//
//  BaseViewController.m
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"
#import "UIProgressView+AFNetworking.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;

    UIImage *imagebg = [UIImage imageNamed:@"loginViewBG.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:imagebg]];
}

- (void)showLoading:(BOOL)show {
    
    if (_tipView == nil) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight/2-30, kScreenWidth, 20)];
        _tipView.backgroundColor = [UIColor clearColor];
        
        
        //1.loading视图
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [activityView startAnimating];
        
        [_tipView addSubview:activityView];
        
        //2.加载提示的Label
        UILabel *loadLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        loadLabel.backgroundColor = [UIColor clearColor];
        loadLabel.text = @"正在加载...";
        loadLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        loadLabel.textColor = [UIColor whiteColor];
        [loadLabel sizeToFit];
        
        [_tipView addSubview:loadLabel];
        
        loadLabel.left = (kScreenWidth-loadLabel.width)/2;
        activityView.right = loadLabel.left - 5;
    }
    
    if (show) {
        [self.view addSubview:_tipView];
    } else {
        if (_tipView.superview) {
            [_tipView removeFromSuperview];
        }
    }
    
}

- (void)showLoading:(BOOL)show locationOfHeight:(NSInteger)height {
    
    if (_tipView == nil) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight/2-30-height, kScreenWidth, 20)];
        _tipView.backgroundColor = [UIColor clearColor];
        
        
        //1.loading视图
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [activityView startAnimating];
        [_tipView addSubview:activityView];
        
        //2.加载提示的Label
        UILabel *loadLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        loadLabel.backgroundColor = [UIColor clearColor];
        loadLabel.text = @"正在加载...";
        loadLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        loadLabel.textColor = [UIColor whiteColor];
        [loadLabel sizeToFit];
        [_tipView addSubview:loadLabel];
        
        loadLabel.left = (kScreenWidth-loadLabel.width)/2;
        activityView.right = loadLabel.left - 5;
    }
    
    if (show) {
        [self.view addSubview:_tipView];
    } else {
        if (_tipView.superview) {
            [_tipView removeFromSuperview];
        }
    }
    
}


//显示hud提示
- (void)showHUD:(NSString *)title {
    if (_hud == nil) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view
                                    animated:YES];
    }
    
    [_hud show:YES];
    _hud.labelText = title;
    //    _hud.detailsLabelText  //子标题
    
    //灰色的背景盖住其他视图
    _hud.dimBackground = YES;
}

- (void)hideHUD {
    
    //延迟隐藏
    //    [_hud hide:YES afterDelay:(NSTimeInterval)]
    
    [_hud hide:YES];
}

//完成的提示
- (void)completeHUD:(NSString *)title {
    
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    //显示模式改为：自定义视图模式
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.labelText = title;
    
    //延迟隐藏
    [_hud hide:YES afterDelay:1.5];
}

//状态栏提示
- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
            operation:(AFURLConnectionOperation *)operation {
    
    if (_tipWindow == nil) {
        //创建window用于盖在状态栏上
        _tipWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        _tipWindow.windowLevel = UIWindowLevelStatusBar;
        _tipWindow.backgroundColor = [UIColor blackColor];
        
        //创建Label
        UILabel *tpLabel = [[UILabel alloc] initWithFrame:_tipWindow.bounds];
        tpLabel.backgroundColor = [UIColor clearColor];
        tpLabel.textAlignment = NSTextAlignmentCenter;
        tpLabel.font = [UIFont systemFontOfSize:13.0f];
        tpLabel.textColor = [UIColor whiteColor];
        tpLabel.tag = 2013;
        [_tipWindow addSubview:tpLabel];
        
        //创建光标图片视图
        //        UIImageView *progress = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"queue_statusbar_progress.png"]];
        //        progress.frame = CGRectMake(0, 20-6, 100, 6);
        //        progress.tag = 2014;
        //        [_tipWindow addSubview:progress];
        
        UIProgressView *progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progress.frame = CGRectMake(0, 20-3, kScreenWidth, 5);
        progress.tag = 2014;
        progress.progress = 0.0;
        [_tipWindow addSubview:progress];
        
    }
    
    UILabel *tpLabel = (UILabel *)[_tipWindow viewWithTag:2013];
    //    UIImageView *progress = (UIImageView *)[_tipWindow viewWithTag:2014];
    UIProgressView *progress = (UIProgressView *)[_tipWindow viewWithTag:2014];
    //显示提示的window
    _tipWindow.hidden = NO;
    
    tpLabel.text = title;
    
    //判断是否隐藏提示
    if (show) {
        
        //        [UIView animateWithDuration:2 animations:^{
        //            //设置动画重复执行
        //            [UIView setAnimationRepeatCount:1000];
        //            //设置加速方式：均匀移动
        //            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        //
        //            progress.left = kScreenWidth;
        //
        //        }];
        
        //设置上传的进度
        if (operation != nil) {
            [progress setProgressWithUploadProgressOfOperation:operation animated:YES];
        } else {
            progress.hidden = YES;
        }
        
    } else {
        progress.hidden = YES;
        
        //提示完之后，延迟隐藏、移除提示的window
        //延迟移除tipWindow
        [self performSelector:@selector(removeTipWindow) withObject:nil afterDelay:2];
        
    }
}

- (void)removeTipWindow {
    
    _tipWindow.hidden = YES;
    _tipWindow = nil;
    
}



@end
