//
//  HeaderView.m
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "HeaderView.h"
#import "SharesModel.h"

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)setData:(NSArray *)data {
    
    if (_data != data) {
        _data = data;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"nihao" object:self userInfo:nil];
        
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    

    self.zxjLabel.text = self.data[3];
    self.zdLabel.text = self.data[31];
    self.zdfLabel.text = self.data[32];
    
    if ([self.zdLabel.text floatValue] > 0) {
        
        self.zdLabel.text = [NSString stringWithFormat:@"+%@%%",self.zdLabel.text];
        self.zdfLabel.text = [NSString stringWithFormat:@"+%@%%",self.zdfLabel.text];
        
        self.zxjLabel.textColor = [UIColor greenColor];
        self.zdLabel.textColor = [UIColor greenColor];
        self.zdfLabel.textColor = [UIColor greenColor];
    } else if ([self.zdLabel.text floatValue] < 0) {
        
        self.zdLabel.text = [NSString stringWithFormat:@"%@%%",self.zdLabel.text];
        self.zdfLabel.text = [NSString stringWithFormat:@"%@%%",self.zdfLabel.text];
        
        self.zxjLabel.textColor = [UIColor redColor];
        self.zdLabel.textColor = [UIColor redColor];
        self.zdfLabel.textColor = [UIColor redColor];
    } else {
        
        self.zdLabel.text = [NSString stringWithFormat:@"%@%%",self.zdLabel.text];
        self.zdfLabel.text = [NSString stringWithFormat:@"%@%%",self.zdfLabel.text];
        
        self.zxjLabel.textColor = [UIColor grayColor];
        self.zdLabel.textColor = [UIColor grayColor];
        self.zdfLabel.textColor = [UIColor grayColor];
    }
    
    
    
    //今开
    self.jkLabel.text = self.data[5];
    //昨收
    self.zsLabel.text = self.data[4];
    
    //成交量默认为个
    CGFloat cjl = [self.data[36] floatValue];
    if (cjl/10000 > 1) {
        self.cjlLabel.text = [NSString stringWithFormat:@"%.2f万手",cjl/10000];
    } else {
        self.cjlLabel.text = [self.data[36] stringByAppendingString:@"手"];
    }
    //换手率
    self.hslLabel.text = [self.data[38] stringByAppendingString:@"%"];
    
    //最高值
    self.zgjLabel.text = self.data[33];
    //最低值
    self.zdjLabel.text = self.data[34];
    //成交额默认为万
    self.cjeLabel.text = self.data[37];
    CGFloat cje = [self.data[37] floatValue];
    if (cje/10000 > 1) {
        self.cjeLabel.text = [NSString stringWithFormat:@"%.2f亿",cje/10000];
    } else {
        self.cjeLabel.text = [self.data[37] stringByAppendingString:@"万"];
    }
    
    
    //内盘外盘默认为个
    CGFloat neipan = [self.data[8] floatValue];
    CGFloat waipan = [self.data[7] floatValue];
    if (neipan/10000 > 1) {
        self.npLabel.text = [NSString stringWithFormat:@"%.2f万",neipan/10000];
    } else {
        self.npLabel.text = self.data[8];
    }
    if (waipan/10000 > 1) {
        self.npLabel.text = [NSString stringWithFormat:@"%.2f万",waipan/10000];
    } else {
        self.wpLabel.text = self.data[7];
    }
    //市值默认为亿
    CGFloat shizhi = [self.data[45] floatValue];
    self.szLabel.text = [NSString stringWithFormat:@"%.1f亿",shizhi];

    //市盈率
    self.sylLabel.text = self.data[39];
    //振幅
    self.zfLabel.text = [self.data[43] stringByAppendingString:@"%"];
    //流通市值默认为亿
    CGFloat liutong = [self.data[44] floatValue];
    self.ltszLabel.text = [NSString stringWithFormat:@"%.1f亿",liutong];
    
}

@end
