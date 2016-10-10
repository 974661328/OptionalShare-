//
//  NewsTableView.m
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "NewsTableView.h"
#import "NewsCell.h"
#import "NewsModel.h"
#import "SelectedModel.h"
#import "NewsDetailViewController.h"
#import "UIView+UIViewController.h"
#import "WebViewController.h"

@implementation NewsTableView {
    NSString *identify;
    NSArray *headerNames;
}


- (void)setMyData:(NSArray *)myData {
    if (_myData != myData) {
        _myData = [myData mutableCopy];
        
        [self reloadData];
    }
}

- (void)_createView {
    [super _createView];
    
    //1.去掉父类的上拉加载功能
    self.tableFooterView = nil;
    
    //2.设置组头名称
    headerNames = @[@"要闻",@"自选股新闻",@"沪深市场",@"港股市场",@"美股市场",@"科技行业",@"金融行业",@"地产行业",@"hehe",@"haha"];
    
    //3.从xib加载单元格
    identify = @"NewsCell";
    UINib *nib = [UINib nibWithNibName:@"NewsCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:identify];

}


#pragma mark - UITableView delegate
//1.返回tableView组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.data.count/5+1;
}

//2.返回每组的单元格字数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (isShow[section]) {

        return 5;
    }
    return 0;
}

//3.创建并返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    
    if (indexPath.section == 0) {
       cell.newsModel = self.data[indexPath.row];
    }
    else if (indexPath.section == 1) {
        cell.myModel = self.myData[indexPath.row];
    }
    else {
        
        cell.newsModel = self.data[(indexPath.section-1)*5+indexPath.row];
    }
    
    return cell;
}

//4.设置组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //1.创建组头视图
    UIControl *headerView = [[UIControl alloc] initWithFrame:CGRectZero];
    
//    UIImage *image = [UIImage imageNamed:@"finance_report_head.png"];
    headerView.backgroundColor = [UIColor colorWithRed:32/255.0 green:34/255.0 blue:38/255.0 alpha:1];
    headerView.contentMode = UIViewContentModeScaleAspectFit;
    headerView.tag = section;
    [headerView addTarget: self action:@selector(isShowActions:) forControlEvents:UIControlEventTouchUpInside];
    
    //2.创建展开/收缩标志视图
    UIImageView *switchView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 13, 13)];
    if (isShow[section]) {
        
        switchView.image = [UIImage imageNamed:@"newslist_btn_switch_on.png"];
    } else {
        switchView.image = [UIImage imageNamed:@"newslist_btn_switch_off.png"];
    }
    switchView.contentMode = UIViewContentModeScaleAspectFit;
    switchView.tag = 200;
    [headerView addSubview:switchView];
    
    //3.创建显示标题的Label
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(switchView.right, 0, 200, 35)];
    titleLable.font = [UIFont systemFontOfSize:16.0f];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.tag = 300;

    titleLable.text = headerNames[section];
    [headerView addSubview:titleLable];
    
    //4.创建更多按钮
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.tag = section+10;
    moreButton.frame = CGRectMake(kScreenWidth-50, 0, 50, 35);
    [moreButton setImage:[UIImage imageNamed:@"newslist_btn_enter.png"] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    if (isShow[section]) {
        moreButton.hidden = NO;
    } else {
        moreButton.hidden = YES;
    }
    [headerView addSubview:moreButton];
    
    //5.创建组头分割线
    UIImageView *seperateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 2)];
    seperateView.image = [UIImage imageNamed:@"finance_report_sectionhead.png"];
    [headerView addSubview:seperateView];

    
    return headerView;
}

//5.返回组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 35;
}

//6.返回单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.section == 0&& indexPath.row==0) {
//        return 100;
//    }
    return 60;
}

//7.单元格的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *url = nil;
    NSString *title = nil;
    if (indexPath.section == 0) {
        NewsModel *newsModel = self.data[indexPath.row];
        url = newsModel.url;
        title = newsModel.title;
    }
    else if (indexPath.section == 1) {
         SelectedModel *myModel = self.myData[indexPath.row];
        url = myModel.url;
        title = myModel.title;
    }
    else {
        NewsModel *newsModel = self.data[(indexPath.section-1)*5+indexPath.row];
        url = newsModel.url;
        title = newsModel.title;
    }
    

    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.url = url;
    webVC.title = title;
    [self.navigationViewController pushViewController:webVC animated:YES];
    
    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - 按钮事件
//展开收缩事件
- (void)isShowActions:(UIControl *)control {
    
    NSInteger index = control.tag;
    isShow[index] = !isShow[index];
    
    //刷新指定组
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
    
    
    [self reloadSections:indexSet
              withRowAnimation:UITableViewRowAnimationFade];
    
    if (isShow[index]) {
        
        NSIndexPath *indextPath = [NSIndexPath indexPathForItem:0 inSection:index];
        [self scrollToRowAtIndexPath:indextPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
}

//点击加载更多数据
- (void)moreAction:(UIControl *)control {

    NewsDetailViewController *newsVC = [[NewsDetailViewController alloc] init];
    if (control.tag == 10) {
       newsVC.newsID = self.allNewsID[control.tag-10];
    }
    else if (control.tag == 11) {
        
        newsVC.isZX = YES;
    } else {
        newsVC.newsID = self.allNewsID[control.tag-10-1];
    }
    
    newsVC.title = headerNames[control.tag-10];
    [self.navigationViewController pushViewController:newsVC animated:YES];
}





@end
