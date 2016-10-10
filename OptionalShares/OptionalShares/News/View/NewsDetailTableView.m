//
//  NewsDetailTableView.m
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "NewsDetailTableView.h"
#import "NewsCell.h"
#import "SelectedModel.h"
#import "NewsModel.h"
#import "WebViewController.h"
#import "UIView+UIViewController.h"

#define TABBARHEIGHT 55;
#define SUBHEIGHT 30;

@implementation NewsDetailTableView {
    NSString *identify;
}


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
        [self _createView];
    }
    return self;
}

- (void)_createView {
    [super _createView];
    
//    self.top += SUBHEIGHT;
    self.height -= TABBARHEIGHT;
    
    //1.去掉父类的上拉加载功能
    self.tableFooterView = nil;
    
    
    //2.从xib加载单元格
    identify = @"NewsCell";
    UINib *nib = [UINib nibWithNibName:@"NewsCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:identify];
    
}

#pragma mark - UITableView delegate
//1.返回每组的单元格字数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}

//2.创建并返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    if (self.isZX) {
        cell.myModel = self.data[indexPath.row];
    } else {
        cell.newsModel = self.data[indexPath.row];
    }
    
    return cell;
}

//3.返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isZX) {
        return 50;
    }
    return 65;
}

//4.选中单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *url = nil;
    NSString *title = nil;
    if (self.isZX) {
        SelectedModel *myModel = self.data[indexPath.row];
        url = myModel.url;
        title = myModel.title;
    }
    else {
        NewsModel *newsModel = self.data[indexPath.row];
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

@end
