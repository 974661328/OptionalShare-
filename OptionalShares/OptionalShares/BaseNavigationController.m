//
//  BaseNavigationController.m
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

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

    //1.获取导航栏背景图片
    UIImage *navImg = [UIImage imageNamed:@"portfolio_nav_bar.png"];
    
    //2.设置导航栏背景图片
    [self.navigationBar setBackgroundImage:navImg forBarMetrics:UIBarMetricsDefault];
    
    //3.设置导航栏标题颜色
    NSDictionary *titleTextAttributes = @{
                                          NSForegroundColorAttributeName: [UIColor whiteColor]
                                          };
    
    self.navigationBar.titleTextAttributes = titleTextAttributes;
    
    
    

}

//设置状态栏字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}



@end
