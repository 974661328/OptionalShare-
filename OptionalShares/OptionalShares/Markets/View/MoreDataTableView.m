//
//  MoreDataTableView.m
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "MoreDataTableView.h"
#import "MyDataService.h"
#import "ChooseModel.h"
#import "UIView+UIViewController.h"
#import "ShareDetailViewController.h"

@implementation MoreDataTableView{
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

//- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
//    self= [super initWithFrame:frame style:style];
//    if (self) {
//        
//        //创建tableView
//        [self _createView];
//    }
//    
//    return self;
//}

- (void)_createView {
    [super _createView];
    
    
    //1.创建头视图
    [self _createHeaderView];
    
    self.tableFooterView = nil;
    
    //2.给单元格一个ID
    identify = @"MoreCell";
    
    self.itemData = [NSMutableArray array];
}

//创建头视图
- (void)_createHeaderView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UIImage *image = [UIImage imageNamed:@"portfolio_header_bg.png"];
    view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth/3-20, 30)];
    nameLabel.text = @"行业名称";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:14.0f];
    [view addSubview:nameLabel];
    
    
    UILabel *zxjLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.right, 0, kScreenWidth/3+10, 30)];
    zxjLabel.text = @"领涨股";
    zxjLabel.textColor = [UIColor whiteColor];
    zxjLabel.textAlignment = NSTextAlignmentCenter;
    zxjLabel.font = [UIFont systemFontOfSize:14.0f];
    [view addSubview:zxjLabel];
    
    UIButton *fuButton = [[UIButton alloc] initWithFrame:CGRectMake(zxjLabel.right, 0, kScreenWidth/3, 30)];
    if (!self.isReverse) {
        
        [fuButton setTitle:@"涨幅" forState:UIControlStateNormal];
        [fuButton setImage:[UIImage imageNamed:@"sort_angle_down.png"] forState:UIControlStateNormal];
    } else {
        [fuButton setTitle:@"跌幅" forState:UIControlStateNormal];
        [fuButton setImage:[UIImage imageNamed:@"sort_angle_up.png"] forState:UIControlStateNormal];
    }
    [fuButton setTintColor:[UIColor greenColor]];
    
    UIEdgeInsets imgEdg = UIEdgeInsetsMake(0, 50, 0, 0);
    UIEdgeInsets titleEdg = UIEdgeInsetsMake(0, 0, 0, 50);
    [fuButton setTintColor:[UIColor blueColor]];
    [fuButton setImageEdgeInsets:imgEdg];
    [fuButton setTitleEdgeInsets:titleEdg];
    fuButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [fuButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:fuButton];
    
    
    
    self.tableHeaderView = view;
    
}

- (void)switchAction:(UIButton *)button {
    
    self.isReverse = !self.isReverse;
    //倒叙
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.data];
    
    array = (NSMutableArray *)[[array reverseObjectEnumerator] allObjects];
    
    self.data = array;
    
    [self reloadData];
}


#pragma mark - UITableView delegate
//返回单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //获取所有数据的code
    if (self.data.count != 0) {
       
        for (int i=0; i<self.data.count; i++) {
            
            ChooseModel *csModel = self.data[i];
            NSString *code = csModel.code;

            [self.itemData addObject:code];
        }
        
    }
    
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

//创建单元格的子视图
- (UITableViewCell *)createCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    ChooseModel *csModel = self.data[indexPath.row];
    //1.创建显示股票名称的Label
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth/3.0+20, 25)];
    nameLabel.text = csModel.name;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [cell.contentView addSubview:nameLabel];
    
    //2.创建显示标志名称的Label
    UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, nameLabel.bottom, kScreenWidth/3.0+20, 15)];
    tagLabel.text = csModel.code;
    tagLabel.textAlignment = NSTextAlignmentLeft;
    tagLabel.textColor = [UIColor whiteColor];
    tagLabel.font = [UIFont systemFontOfSize:13.0f];
    [cell.contentView addSubview:tagLabel];
    
    //3.创建显示最新价Label
    UILabel *zxjLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.right, 0, kScreenWidth/3.0-20, 40)];
    zxjLabel.text = csModel.zxj;
    zxjLabel.textColor = [UIColor whiteColor];
    zxjLabel.textAlignment = NSTextAlignmentLeft;
    zxjLabel.adjustsFontSizeToFitWidth = YES;
    zxjLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [cell.contentView addSubview:zxjLabel];
    
    //4.创建显示増度幅的Label
    UILabel *zdfLabel = [[UILabel alloc] initWithFrame:CGRectMake(zxjLabel.right, 0, kScreenWidth/3.0-20, 40)];
    if (self.isColor) {
        
        if ([csModel.zdf floatValue] > 0) {
            zdfLabel.text = [NSString stringWithFormat:@"+%@%%",csModel.zdf];
            zdfLabel.textColor = [UIColor greenColor];
        } else {
            zdfLabel.text = [NSString stringWithFormat:@"%@%%",csModel.zdf];
            zdfLabel.textColor = [UIColor redColor];
        }
    } else {
        
        if (self.isHS) {
            if(self.isHsl) {
                
                zdfLabel.text = [NSString stringWithFormat:@"+%@%%",csModel.hsl];
            }
            else if(!self.isHsl) {
                
                zdfLabel.text = [NSString stringWithFormat:@"+%@%%",csModel.zf];
            }
        }
        else {
            CGFloat acount = [csModel.cje floatValue];
            if (acount/100000000 >= 1) {
                
                CGFloat zjeAcout = acount/100000000;
                zdfLabel.text = [NSString stringWithFormat:@"%.1f亿",zjeAcout];
            } else {
                CGFloat zjeAcout = acount/10000;
                zdfLabel.text = [NSString stringWithFormat:@"%.1f万",zjeAcout];
            }
        }
        
        zdfLabel.textColor = [UIColor whiteColor];
    }
    
    zdfLabel.textAlignment = NSTextAlignmentCenter;
    zdfLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [cell.contentView addSubview:zdfLabel];
    

    
    return cell;
}

//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

//点击单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //PUSH到下一个界面-股票详情
    ShareDetailViewController *shareVC = [[ShareDetailViewController alloc] init];
    shareVC.itemData = self.itemData;
    shareVC.isHS = self.isHS;
    shareVC.isHK = self.isHK;
    shareVC.isUS = self.isUS;
    ChooseModel *chooseModel = self.data[indexPath.row];
    
    shareVC.code = chooseModel.code;
    
    [self.navigationViewController pushViewController:shareVC animated:YES];
    
    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
