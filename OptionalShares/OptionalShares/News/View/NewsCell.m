//
//  NewsCell.m
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "NewsCell.h"
#import "NewsModel.h"
#import "SelectedModel.h"

@implementation NewsCell

- (void)awakeFromNib
{
 
    self.backgroundColor = [UIColor clearColor];
    self.backgroundColor = nil;
}

- (void)setNewsModel:(NewsModel *)newsModel {
    
    if (_newsModel != newsModel) {
        _newsModel = newsModel;
        
        isSelf = NO;
        [self setNeedsLayout];
    }
}

- (void)setMyModel:(SelectedModel *)myModel {
    if (_myModel != myModel) {
        _myModel = myModel;
        
        isSelf = YES;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    _detailLabel.textColor = [UIColor groupTableViewBackgroundColor];
    _detailLabel.font = [UIFont systemFontOfSize:14.0f];
    
    if (isSelf) {
        
        _titleLabel.text = self.myModel.title;
        
        NSString *detailText = self.myModel.symbol;
        if (detailText.length > 30) {
            
            NSRange range = NSMakeRange(0, 30);
            _detailLabel.text = [[detailText substringWithRange:range] stringByAppendingFormat:@"..."];
        } else {
            
            _detailLabel.text = detailText;
        }

        
    } else {
        
        _titleLabel.text = self.newsModel.title;
        NSString *detailText = self.newsModel.abstract;
        
        if (detailText.length > 30) {
            
            NSRange range = NSMakeRange(0, 30);
            _detailLabel.text = [[detailText substringWithRange:range] stringByAppendingFormat:@"..."];
        } else {
            _detailLabel.text = detailText;
        }
    }
    
}

@end
