//
//  ChooseTableView.m
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "ChooseTableView.h"
#import "ChooseModel.h"
#import "ChooseCell.h"
#import "ShareDetailViewController.h"
#import "UIView+UIViewController.h"

@implementation ChooseTableView {
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
    
    //2.创建尾视图
    [self _createFooterView];
    
    //3.注册单元格
    identify = @"ChooseCell";
    UINib *nib = [UINib nibWithNibName:@"ChooseCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:identify];
    
    self.itemData = [NSMutableArray array];
    self.selectedRows = [NSMutableArray array];
}

//创建头视图
- (void)_createHeaderView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UIImage *image = [UIImage imageNamed:@"portfolio_header_bg.png"];
    view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth/3, 30)];
    nameLabel.text = @"名称代码";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:14.0f];
    [view addSubview:nameLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.right, 0, kScreenWidth/3, 30)];
    priceLabel.text = @"最新价";
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.font = [UIFont systemFontOfSize:14.0f];
    [view addSubview:priceLabel];
    
    UILabel *zdfLabel = [[UILabel alloc] initWithFrame:CGRectMake(priceLabel.right, 0, kScreenWidth/3, 30)];
    zdfLabel.text = @"涨跌幅";
    zdfLabel.textColor = [UIColor whiteColor];
    zdfLabel.textAlignment = NSTextAlignmentCenter;
    zdfLabel.font = [UIFont systemFontOfSize:14.0f];
    [view addSubview:zdfLabel];
    
    self.tableHeaderView = view;
    
}

//创建tableView尾部视图
- (void)_createFooterView {
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    label.text = @"实时提供沪深、港股、美股报价信息";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textColor = [UIColor whiteColor];
    [footerView addSubview:label];
    
    self.tableFooterView = footerView;
}


#pragma mark - UITableView delegate
//返回创建单元格个数
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
    
    ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    cell.isChoose = YES;
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.chooseModel = self.data[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;

    return cell;
}

//单元格选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.editing) {    //编辑状态
        
        [self.selectedRows addObject:indexPath];

    } else {        //非编辑状态
        
        ShareDetailViewController *shareVC = [[ShareDetailViewController alloc] init];
        
        shareVC.itemData = self.itemData;
        shareVC.isHS = YES;
        ChooseModel *chooseModel = self.data[indexPath.row];
        
        shareVC.code = chooseModel.code;
        
        [self.navigationViewController pushViewController:shareVC animated:YES];
        
        //取消选中效果
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    

}

#pragma mark - UITableView 编辑单元格的协议方法

//单元格上面的删除、插入被点击调用的协议方法
//此协议方法实现后，单元格左滑会出现删除按钮
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //1.删除数组中的消息对象
        [self.data removeObjectAtIndex:indexPath.row];
        
        //2.从tableView 中删除一个单元格
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

//此协议方实现后，tableView处于编辑模式，单元格便可以移动了
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    //调换数组中的消息对象位置
    [self.data exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    
}


@end
