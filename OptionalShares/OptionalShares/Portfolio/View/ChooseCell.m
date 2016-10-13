//
//  ChooseCell.m
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "ChooseCell.h"
#import "ChooseModel.h"

@implementation ChooseCell

- (void)awakeFromNib
{

    self.backgroundColor = [UIColor clearColor];
    self.backgroundColor = nil;
}

- (void)setChooseModel:(ChooseModel *)chooseModel {
    if (_chooseModel != chooseModel) {
        _chooseModel = chooseModel;
        
        
        [self setNeedsLayout];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    self.markLabel.hidden = YES;
    
    self.nameLabel.textColor = [UIColor whiteColor];
    self.symbolLabel.textColor = [UIColor whiteColor];
    self.zxjLabel.textColor = [UIColor whiteColor];
    self.zdfLabel.textColor = [UIColor whiteColor];
    
    self.nameLabel.text = self.chooseModel.name;
    self.zxjLabel.text = self.chooseModel.zxj;
    
    
    //处理标志图片
    if (self.isUS && !self.isHK) {
        self.markLabel.hidden = NO;
        
        UIImage *image = [UIImage imageNamed:@"market_type_us.png"];
        self.markLabel.image = image;
    }
    else if (self.isHK && !self.isUS){
        self.markLabel.hidden = NO;
        
        UIImage *image = [UIImage imageNamed:@"market_type_hk.png"];
        self.markLabel.image = image;

    }
    else {
        self.markLabel.hidden = YES;
    }
    
    //处理编号
    if (self.isRound) {
        
        self.symbolLabel.text = self.chooseModel.code;
    } else {
        
        self.symbolLabel.text = [self.chooseModel.code substringFromIndex:2];
    }

    
    NSString *zdf = self.chooseModel.zdf;;
    
    //处理数据问题
    if (!self.isChoose && !self.chooseModel.isColor && !self.isRound) {
        //1.港股、美股：销售额
        CGFloat acount = [self.chooseModel.cje floatValue];
        if (acount/100000000 >= 1) {
            
            CGFloat zjeAcout = acount/100000000;
            self.zdfLabel.text = [NSString stringWithFormat:@"%.1f亿",zjeAcout];
        } else {
            CGFloat zjeAcout = acount/10000;
            self.zdfLabel.text = [NSString stringWithFormat:@"%.1f万",zjeAcout];
        }
    } else if(!self.isChoose && !self.chooseModel.isColor && self.isRound) {
        //2.环球榜：人民币买入价
        self.zxjLabel.text = self.chooseModel.hbuy;
        self.zdfLabel.text = self.chooseModel.cbuy;
        
    } else {
        //3.增长率与跌幅率
        
        //增长率
        if ([zdf floatValue] > 0) {
            
            self.zdfLabel.text = [NSString stringWithFormat:@"+%.2f%%",[zdf floatValue]];
            
            //自选页，设置背景颜色
            if (self.isChoose) {
                UIImage *image = [UIImage imageNamed:@"portfolio_list_green.png"];
                self.zdfLabel.backgroundColor = [UIColor colorWithPatternImage:image];
            } else if(self.chooseModel.isColor) {    //设置字体颜色
                self.zdfLabel.textColor = [UIColor greenColor];
            }
            
        }
        //跌幅率
        else  if([zdf floatValue] < 0) {
            
            self.zdfLabel.text = [@"" stringByAppendingFormat:@"%.2f%%",[zdf floatValue]];
            
            //自选页，设置背景颜色
            if (self.isChoose) {
                UIImage *image = [UIImage imageNamed:@"portfolio_list_red.png"];
                self.zdfLabel.backgroundColor = [UIColor colorWithPatternImage:image];
            } else if(self.chooseModel.isColor) {    //设置字体颜色
                self.zdfLabel.textColor = [UIColor redColor];
            }
            
        }
        //不增不跌、退市
        else if ([self.chooseModel.zdf floatValue] == 0) {
            
            self.zdfLabel.textColor = [UIColor groupTableViewBackgroundColor];
            
            if ([self.chooseModel.zxj floatValue] == 0 && self.isChoose) {
                self.zdfLabel.text = @"退市";
            }
            
            else if (zdf.length == 0) {
                self.zdfLabel.text = @"--";
            } else {
                
                self.zdfLabel.text = [NSString stringWithFormat:@"%@%%",zdf];
            }
            
            //自选页，设置背景颜色
            if (self.isChoose) {
                
                UIImage *image = [UIImage imageNamed:@"portfolio_list_grey.png"];
                self.zdfLabel.backgroundColor = [UIColor colorWithPatternImage:image];
            }
        }
    }
    
    
}

@end
