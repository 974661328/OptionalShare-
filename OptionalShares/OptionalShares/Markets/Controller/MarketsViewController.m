//
//  MarketsViewController.m
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "MarketsViewController.h"
#import "HuShenViewController.h"
#import "HongKongViewController.h"
#import "AmericaViewController.h"
#import "WorldViewController.h"


@interface MarketsViewController ()

@end

@implementation MarketsViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    NSArray *titleNames = @[
                      @"沪深",
                      @"港股",
                      @"美股",
                      @"环球",
                      ];
    
    //创建四个子控制器
    HuShenViewController *hsVC = [[HuShenViewController alloc] init];
    hsVC.title = [NSString stringWithString:titleNames[0]];
    
    HongKongViewController *hkVC = [[HongKongViewController alloc] init];
    hkVC.title = [NSString stringWithString:titleNames[1]];
    
    AmericaViewController *amVC = [[AmericaViewController alloc] init];
    amVC.title = [NSString stringWithString:titleNames[2]];
    
    WorldViewController *wdVC = [[WorldViewController alloc] init];
    wdVC.title = [NSString stringWithString:titleNames[3]];

    NSArray *vcs = [NSArray arrayWithObjects:hsVC,hkVC,amVC,wdVC, nil];
    
    //父类不支持从storyboard加载，故而手动调用父类的初始化方法
    self =  [super initWithViewControllers:vcs];
    self.title = @"市场行情";
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}


@end
