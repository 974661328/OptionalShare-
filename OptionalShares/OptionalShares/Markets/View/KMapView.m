//
//  KMapView.m
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "KMapView.h"
#import "lineView.h"
#import "UIColor+helper.h"
#import "MyDataService.h"

@implementation KMapView {
    lineView *lineview;
    UIButton *btnDay;
    UIButton *btnWeek;
    UIButton *btnMonth;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
    }
    return self;
}

- (void)setDayData:(NSArray *)dayData {
    if (_dayData != dayData) {
        _dayData = dayData;
        
        
        //创建按钮视图
        [self _creatView];
    }
}

- (void)_creatView {
    
    
    // 日k按钮
    btnDay = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, 50, 30)];
    [btnDay setTitle:@"日K" forState:UIControlStateNormal];
    [btnDay addTarget:self action:@selector(kDayLine) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonAttr:btnDay];
    [self addSubview:btnDay];
    // 周k按钮
    btnWeek = [[UIButton alloc] initWithFrame:CGRectMake(75, 0, 50, 30)];
    [btnWeek setTitle:@"周K" forState:UIControlStateNormal];
    [btnWeek addTarget:self action:@selector(kWeekLine) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonAttr:btnWeek];
    [self addSubview:btnWeek];
    // 月k按钮
    btnMonth = [[UIButton alloc] initWithFrame:CGRectMake(130, 0, 50, 30)];
    [btnMonth setTitle:@"月K" forState:UIControlStateNormal];
    [btnMonth addTarget:self action:@selector(kMonthLine) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonAttr:btnMonth];
    [self addSubview:btnMonth];
    
    // 放大
    UIButton *btnBig = [[UIButton alloc] initWithFrame:CGRectMake(185, 0, 50, 30)];
    [btnBig setTitle:@"+" forState:UIControlStateNormal];
    [btnBig addTarget:self action:@selector(kBigLine) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonAttr:btnBig];
    [self addSubview:btnBig];
    
    // 缩小
    UIButton *btnSmall = [[UIButton alloc] initWithFrame:CGRectMake(240, 0, 50, 30)];
    [btnSmall setTitle:@"-" forState:UIControlStateNormal];
    [btnSmall addTarget:self action:@selector(kSmallLine) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonAttr:btnSmall];
    [self addSubview:btnSmall];
    
    self.backgroundColor = [UIColor colorWithHexString:@"#111111" withAlpha:1];
    // 添加k线图
    lineview = [[lineView alloc] init];
    CGRect frame = self.frame;
    frame.origin = CGPointMake(0, 40);
    frame.size = CGSizeMake(310, 200);
    lineview.frame = frame;
    //lineview.backgroundColor = [UIColor blueColor];
    lineview.req_type = @"d";
    lineview.req_freq = @"601888.SS";
    lineview.kLineWidth = 5;
    lineview.kLinePadding = 0.5;
    [self addSubview:lineview];
    lineview.mydata = self.dayData;
    [lineview start]; // k线图运行
    [self setButtonAttrWithClick:btnDay];
    
}

//加载图标
- (void)blackLoadingView {
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    activityIndicator.center = self.center;
    activityIndicator.top -= 150;
    activityIndicator.tag = 123;
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
}

//加载周K数据
- (void)_loadWeekData {
    NSString *klineString = nil;
    
    //1.组头和美股日K线图数据 &param=sh00001,week,,,320
    if (self.isHead || self.isUS) {
        
        klineString = [kHEADKLINE stringByAppendingFormat:@"&param=%@,week,,,320",self.code];
    }
    //2.香港日K线图数据 &param=hk01318,week,,,320,qfq
    else if (self.isHK) {
        
        klineString = [kHKKLINE stringByAppendingFormat:@"&param=%@,week,,,320,qfq",self.code];
    }
    //3.自选项、沪深日K线图数据 &param=sz002259,week,,,320,qfq
    else {
        
        klineString = [kHSKLINE stringByAppendingFormat:@"&param=%@,week,,,320,qfq",self.code];
    }
    
    [MyDataService requestURL:klineString httpMethod:@"GET" params:nil complection:^(id result) {
        
        NSDictionary *data = result[@"data"];
        NSDictionary *detail = data[self.code];
        
        NSArray *mydata = [detail objectForKey:@"week"];
        if (mydata == nil) {
            
            mydata = [detail objectForKey:@"qfqweek"];
        }
        
        if (mydata == nil) {
            return ;
        }
        
        lineview.mydata = [self changeData:mydata];
        
        [self kUpdate];
        
        UIActivityIndicatorView *activity = (UIActivityIndicatorView *)[self viewWithTag:123];
        [activity stopAnimating];
        [activity removeFromSuperview];
     
    }];

}

//加载月K数据
- (void)_loadMonthData {
    NSString *klineString = nil;
    
    //1.组头和美股日K线图数据 &param=sh00001,month,,,320
    if (self.isHead || self.isUS) {
        
        klineString = [kHEADKLINE stringByAppendingFormat:@"&param=%@,month,,,320",self.code];
    }
    //2.香港日K线图数据 &param=hk01318,month,,,320,qfq
    else if (self.isHK) {
        
        klineString = [kHKKLINE stringByAppendingFormat:@"&param=%@,month,,,320,qfq",self.code];
    }
    //3.自选项、沪深日K线图数据 &param=sz002259,month,,,320,qfq
    else {
        
        klineString = [kHSKLINE stringByAppendingFormat:@"&param=%@,month,,,320,qfq",self.code];
    }
    
    [MyDataService requestURL:klineString httpMethod:@"GET" params:nil complection:^(id result) {
        
        NSDictionary *data = result[@"data"];
        NSDictionary *detail = data[self.code];
        
        NSArray *mydata = [detail objectForKey:@"month"];
        if (mydata == nil) {
            
            mydata = [detail objectForKey:@"qfqmonth"];
        }
        
        if (mydata == nil) {
            return ;
        }
        
        lineview.mydata = [self changeData:mydata];
        [self kUpdate];
        
        UIActivityIndicatorView *activity = (UIActivityIndicatorView *)[self viewWithTag:123];
        [activity stopAnimating];
        [activity removeFromSuperview];
        
    }];
    
}

//将数组转换成字符串
- (NSArray *)changeData:(NSArray *)array {
    
    NSMutableArray *allData = [NSMutableArray array];
    
    for (int i=0; i<array.count; i++) {
        
        NSString *mstring = nil;
        NSArray *strArray = array[i];
        
        mstring = [strArray componentsJoinedByString:@","];
        mstring = [mstring stringByAppendingFormat:@",%@",strArray[4]];
        [allData addObject:mstring];
    }
    allData = (NSMutableArray *)[[allData reverseObjectEnumerator] allObjects];
    return allData;
    
}

//加载周K数据，重绘
-(void)kDayLine{
    [self setButtonAttrWithClick:btnDay];
    [self setButtonAttr:btnMonth];
    [self setButtonAttr:btnWeek];
    lineview.req_type = @"d";
    lineview.mydata = self.dayData;
    [self kUpdate];
}

//加载月K数据，重绘
-(void)kWeekLine{
    [self blackLoadingView];
    [self setButtonAttrWithClick:btnWeek];
    [self setButtonAttr:btnMonth];
    [self setButtonAttr:btnDay];
    lineview.req_type = @"w";
    [self _loadWeekData];
    
}

-(void)kMonthLine{
    [self blackLoadingView];
    [self setButtonAttrWithClick:btnMonth];
    [self setButtonAttr:btnWeek];
    [self setButtonAttr:btnDay];
    lineview.req_type = @"m";
    [self _loadMonthData];
}

-(void)kBigLine{
    lineview.kLineWidth += 1;
    [self kUpdate];
}

-(void)kSmallLine{
    lineview.kLineWidth -= 1;
    if (lineview.kLineWidth<=1) {
        lineview.kLineWidth = 1;
    }
    [self kUpdate];
}

-(void)kUpdate{
    [lineview update];
}

-(void)setButtonAttr:(UIButton*)button{
    button.backgroundColor = [UIColor blackColor];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}
-(void)setButtonAttrWithClick:(UIButton*)button{
//    button.backgroundColor = [UIColor colorWithHexString:@"cccccc" withAlpha:1];
    button.backgroundColor = [UIColor colorWithRed:38/255.0 green:39/255.0 blue:40/255.0 alpha:1];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end
