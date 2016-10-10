//
//  HotTabelView.m
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "HotTabelView.h"
#import "HotModel.h"
#import "UIView+UIViewController.h"
#import "HotDataViewController.h"
#import "MoreDataViewController.h"

@implementation HotTabelView {
    NSString *identify;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _createView];
    }
    return self;
}

- (void)_createView {
    [super _createView];
    
    //1.创建头视图
    [self _createHeaderView];
    
    self.tableFooterView = nil;
    
    //2.给单元格一个ID
    identify = @"HotCell";
  
    
}

//创建头视图
- (void)_createHeaderView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UIImage *image = [UIImage imageNamed:@"portfolio_header_bg.png"];
    view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth/3, 30)];
    nameLabel.text = @"行业名称";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:14.0f];
    [view addSubview:nameLabel];
    
    UIButton *fuButton = [[UIButton alloc] initWithFrame:CGRectMake(nameLabel.right, 0, kScreenWidth/3-20, 30)];
    if (!self.isReverse) {
        
        [fuButton setTitle:@"涨幅" forState:UIControlStateNormal];
        [fuButton setImage:[UIImage imageNamed:@"sort_angle_down.png"] forState:UIControlStateNormal];
    } else {
        [fuButton setTitle:@"跌幅" forState:UIControlStateNormal];
        [fuButton setImage:[UIImage imageNamed:@"sort_angle_up.png"] forState:UIControlStateNormal];
    }
    [fuButton setTitleColor:[UIColor colorWithRed:82/255.0 green:147/255.0 blue:250/255.0 alpha:1] forState:UIControlStateNormal];
    
    UIEdgeInsets imgEdg = UIEdgeInsetsMake(0, 50, 0, 0);
    UIEdgeInsets titleEdg = UIEdgeInsetsMake(0, 0, 0, 50);
    [fuButton setTintColor:[UIColor blueColor]];
    [fuButton setImageEdgeInsets:imgEdg];
    [fuButton setTitleEdgeInsets:titleEdg];
    fuButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [fuButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:fuButton];


    UILabel *lzgLabel = [[UILabel alloc] initWithFrame:CGRectMake(fuButton.right+10, 0, kScreenWidth/3, 30)];
    lzgLabel.text = @"领涨股";
    lzgLabel.textColor = [UIColor whiteColor];
    lzgLabel.textAlignment = NSTextAlignmentLeft;
    lzgLabel.font = [UIFont systemFontOfSize:14.0f];
    [view addSubview:lzgLabel];
    
    self.tableHeaderView = view;
    
}

//数据倒叙
- (void)switchAction:(UIButton *)button {
    
    self.isReverse = !self.isReverse;
    
    [self _createHeaderView];
    //倒叙
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.data];
    
    array = (NSMutableArray *)[[array reverseObjectEnumerator] allObjects];
    
    self.data = array;
    
    [self reloadData];
}


#pragma mark - UITableView delegate
//返回单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}

//创建并返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = nil;
    
    cell = [self createCell:cell indexPath:indexPath];
    
    return cell;
}

//设置单元格的内容
- (UITableViewCell *)createCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    HotModel *hotModel = self.data[indexPath.row];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth/3.0-20, 30)];
    nameLabel.text = hotModel.bd_name;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [cell.contentView addSubview:nameLabel];
    
    UILabel *zdfLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.right, 0, kScreenWidth/3.0, 30)];
    if ([hotModel.bd_zdf floatValue] > 0) {
        zdfLabel.text = [NSString stringWithFormat:@"+%@%%",hotModel.bd_zdf];
        zdfLabel.textColor = [UIColor greenColor];
    } else {
        zdfLabel.text = [NSString stringWithFormat:@"%@%%",hotModel.bd_zdf];
        zdfLabel.textColor = [UIColor redColor];
    }
    zdfLabel.textAlignment = NSTextAlignmentCenter;
    zdfLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [cell.contentView addSubview:zdfLabel];

    UILabel *lzgLabel = [[UILabel alloc] initWithFrame:CGRectMake(zdfLabel.right, 0, kScreenWidth/3.0, 30)];
    lzgLabel.text = hotModel.nzg_name;
    lzgLabel.textColor = [UIColor whiteColor];
    lzgLabel.textAlignment = NSTextAlignmentLeft;
    lzgLabel.adjustsFontSizeToFitWidth = YES;
    lzgLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [cell.contentView addSubview:lzgLabel];
    
    return cell;
}

//返回单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

//点击单元格导航到下一个页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HotModel *hotModel = self.data[indexPath.row];
    
    NSString *tString = hotModel.bd_code;
    
    MoreDataViewController *moreVC = [[MoreDataViewController alloc] init];
    moreVC.isColor = YES;
    moreVC.isHS = self.isHS;
    moreVC.isHK = self.isHK;
    moreVC.isHotCell = YES;
    moreVC.title = hotModel.bd_name;
    moreVC.isSub = YES;
    moreVC.tString = [NSString stringWithFormat:@"&t=%@",tString];
    
    [self.navigationViewController pushViewController:moreVC animated:YES];
    
    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
