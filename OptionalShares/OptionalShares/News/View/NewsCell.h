//
//  NewsCell.h
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;
@class SelectedModel;
@interface NewsCell : UITableViewCell {
    BOOL isSelf;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property(nonatomic,strong)NewsModel *newsModel;
@property(nonatomic,strong)SelectedModel *myModel;

@end
