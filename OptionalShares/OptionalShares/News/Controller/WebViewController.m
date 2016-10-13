//
//  WebViewController.m
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController {
    
    UIWebView *webView;
    UIActivityIndicatorView *activityIndicator;
    UIView *blackView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-0)];
    [self.view addSubview:webView];
    [webView setDelegate:self];
    webView.tag = 107;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    [webView loadRequest:request];
}


#pragma mark - WebView delegate
- (void) webViewDidStartLoad:(UIWebView *)webView {
    
    //创建UIActivityIndicatorView背底半透明View
    if (blackView == nil) {
        
        blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [blackView setBackgroundColor:[UIColor blackColor]];
        [blackView setAlpha:0.5];
        [self.view addSubview:blackView];
        
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
        [activityIndicator setCenter:blackView.center];
        [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
        [blackView addSubview:activityIndicator];
        
        [activityIndicator startAnimating];
    }
}
- (void) webViewDidFinishLoad:(UIWebView *)webView {
    
    [activityIndicator stopAnimating];

    [blackView removeFromSuperview];
}


@end
