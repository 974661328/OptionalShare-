//
//  NewsCell.h
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
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
