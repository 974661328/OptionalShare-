//
//  ChooseCell.h
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChooseModel;
@interface ChooseCell : UITableViewCell

@property (assign, nonatomic) BOOL isChoose;
@property (assign, nonatomic) BOOL isRound;
@property (assign, nonatomic) BOOL isHK;
@property (assign, nonatomic) BOOL isUS;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *symbolLabel;
@property (weak, nonatomic) IBOutlet UILabel *zxjLabel;
@property (weak, nonatomic) IBOutlet UILabel *zdfLabel;
@property (weak, nonatomic) IBOutlet UIImageView *markLabel;

@property (strong, nonatomic) ChooseModel *chooseModel;

@end
