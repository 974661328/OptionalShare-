//
//  MainTarBarController.m
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "MainTarBarController.h"
#import "MarketsViewController.h"

@interface MainTarBarController ()

@end

@implementation MainTarBarController {
    
    UIButton *_selectedButton;
}

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
    
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //创建tabbar子按钮，覆盖原有按钮
    [self _cleateTabbarItems];
}


//创建tabbar子按钮，覆盖原有按钮
- (void)_cleateTabbarItems {
    
    //1.移除原有tabbar子按钮控件
    for (UIView *view in self.tabBar.subviews) {
        
        Class subClass = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:subClass]) {
            
            [view removeFromSuperview];
        }
    }

    NSArray *imgDownNames = @[
                              @"stock_tabbar_1_down.png",
                              @"stock_tabbar_2_down.png",
                              @"stock_tabbar_3_down.png",
                              @"stock_tabbar_4_down.png"
                            ];
    NSArray *imgUpNames = @[
                              @"stock_tabbar_1_up.png",
                              @"stock_tabbar_2_up.png",
                              @"stock_tabbar_3_up.png",
                              @"stock_tabbar_4_up.png"
                              ];
    
    //2.设置tabbar背景颜色
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_background.png"]];
    
    
    //4.添加自定义按钮
    for (int i=0; i<imgDownNames.count; i++) {
        NSString *imgDownName = imgDownNames[i];
        NSString *imgUpName = imgUpNames[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 10 + i;
        CGFloat width = kScreenWidth/(CGFloat)imgDownNames.count;
        button.frame = CGRectMake(i*width, 0, width, 49);
        [button setImage:[UIImage imageNamed:imgDownName] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imgUpName] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:imgUpName] forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        if (button.tag == 10) {
            _selectedButton = button;
            button.selected = YES;
        }
        
        [self.tabBar addSubview:button];
    }
    
}

//按钮事件
- (void)buttonAction:(UIButton *)button {
    //若点击的是当前的button，返回
    if ([button isEqual:_selectedButton]) {
        
        return;
    }
    
    
    //将前一个按钮选择设为NO
    _selectedButton.selected = NO;
    
    self.selectedIndex = button.tag-10;
    button.selected = YES;
    
    //将当前点击的按钮设为当前选择按钮
    _selectedButton = button;
    
}



@end
