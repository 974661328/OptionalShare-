//
//  SharesTableView.m
//  OptionalShares
//
//  Created by mac on 16/2/8.
//  Copyright © 2016年 xjw. All rights reserved.
//

#import "SharesTableView.h"
#import "HeaderView.h"
#import "KMapView.h"
#import "SharesModel.h"
#import "UIView+UIViewController.h"
#import "ShareDetailViewController.h"
#import "SelectedModel.h"
#import "ChooseModel.h"
#import "WebViewController.h"
#import "NewsModel.h"

@implementation SharesTableView

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
    
    self.itemData = [NSMutableArray array];
   
}

#pragma mark - set方法
- (void)setSharesModel:(SharesModel *)sharesModel {
    if (_sharesModel != sharesModel) {
        _sharesModel = sharesModel;
        
        [self _createHeaderView];
    }
    
}

- (void)setCode:(NSString *)code {
    
    if (_code != code) {
        _code = code;
        [self _createHeaderView];
    }
}

- (void)setDayData:(NSArray *)dayData {
    
    if (_dayData != dayData) {
        _dayData = dayData;
        
        [self _createHeaderView];
    }
}

- (void)setNewsData:(NSArray *)newsData {
    if (_newsData != newsData) {
        _newsData = newsData;
        
        [self reloadData];
    }
}


#pragma mark - 创建头视图
//创建头视图
- (void)_createHeaderView {
    
    if (self.sharesModel == nil || self.code == nil || self.dayData.count==0) {
        return;
    }
    
    //创建头视图上得子视图
    HeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] lastObject];
    KMapView *kMapView = [[KMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    
    if (self.sharesModel != nil && self.code != nil && self.dayData.count>0) {
        
        //将数据传给headerView
        NSDictionary *qtDic = self.sharesModel.qt;
        NSArray *headData = qtDic[self.code];
        headerView.data = headData;
        
        //将数据传给kMapView
        kMapView.code = self.code;
        kMapView.dayData = [self changeData:self.dayData];
        kMapView.isHead = self.isHead;
        kMapView.isUS = self.isUS;
        kMapView.isHS = self.isHS;
        kMapView.isHK = self.isHK;
        
        [self reloadData];
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, headerView.height + 300)];
    view.backgroundColor = [UIColor clearColor];

    headerView.backgroundColor = [UIColor colorWithRed:50/255.0 green:52/255.0 blue:53/255.0 alpha:1];
    [view addSubview:headerView];
    
    kMapView.top = headerView.bottom+10;
    [view addSubview:kMapView];

    self.tableHeaderView = view;
    self.height -= 40;

    [self reloadData];
}

//将数组转换成字符串
- (NSArray *)changeData:(NSArray *)array {
    
    NSMutableArray *allData = [NSMutableArray array];
    
    for (int i=0; i<array.count; i++) {
        
        NSString *mstring = nil;
        NSArray *strArray = array[i];
    
        mstring = [strArray componentsJoinedByString:@","];
        mstring = [mstring stringByAppendingFormat:@",%@",strArray[4]];
        [allData addObject:mstring];
    }
    
    allData = (NSMutableArray *)[[allData reverseObjectEnumerator] allObjects];
    
    return allData;
    
}

#pragma mark - UITableView delegate
//1.返回组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.isUS && self.isHead) {
        return 0;
    }
    return 1;
}

//2.返回每组单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //获取所有数据的code
    if (!self.isHD) {
    
        if (self.newsData.count != 0) {
            
            for (int i=0; i<self.newsData.count; i++) {
                
                NSString *code = nil;
                if (self.isHead) {
                    
                    ChooseModel *csModel = self.newsData[i];
                    code = csModel.code;
                    
                } else {
                    
                    SelectedModel *csModel = self.newsData[i];
                    code = csModel.symbol;
                }
                
                [self.itemData addObject:code];
            }
        }
    }
    
    
    return self.newsData.count;
}

//3.创建并返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"nihao"];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = nil;

    if (self.newsData.count > 0) {
        
        //初始化单元格内容
        if (self.isHead) {
            
            cell = [self createCell:cell indexPath:indexPath];
        } else {
            
            cell = [self _createCell:cell indethPath:indexPath];
        }
    }
    
    return cell;
}

//4.创建组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (self.isUS && self.isHead) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    CGFloat width = kScreenWidth/3.0;
    NSArray *array = [NSArray array];
    if (self.isHead) {
        array = @[@"涨幅榜",@"跌幅榜",@"换手率榜"];
    } else {
        array = @[@"新闻",@"公告",@"研报"];
    }
    for (int i=0; i<3; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*width, 5, width, 30);
        button.tag = i+10;
        
        button.layer.borderWidth = 0.4;
        button.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1].CGColor;
        
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitle:array[i] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        UIImage *image = [UIImage imageNamed:@"stock_news_comment_section_title.png"];
        image = [image stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [button setBackgroundImage:image forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            button.selected = YES;
            button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
            self.selectedButton = button;
        }
        [view addSubview:button];
    }
    
    return view;
}

//5.返回组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.isHead && self.isUS) {
        return 0;
    }
    return 40;
}

//6.返回单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

//7.点击单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.isHead) {
        
        ShareDetailViewController *shareVC = [[ShareDetailViewController alloc] init];
        shareVC.isHD = YES;
        shareVC.isHead = NO;
        shareVC.itemData = self.itemData;
        shareVC.isHS = self.isHS;
        shareVC.isHK = self.isHK;
        shareVC.isUS = self.isUS;

        ChooseModel *chooseModel = self.newsData[indexPath.row];
        shareVC.code = chooseModel.code;
        
        [self.navigationViewController pushViewController:shareVC animated:YES];
    } else {
        
        NewsModel *newsModel = self.newsData[indexPath.row];
        NSString *url = newsModel.url;
        NSString *title = newsModel.title;
        
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.url = url;
        webVC.title = title;
        [self.navigationViewController pushViewController:webVC animated:YES];
    }
    
    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//8.设置单元格内容-新闻内容
- (UITableViewCell *)_createCell:(UITableViewCell *)cell indethPath:(NSIndexPath *)indexPath {
    
    SelectedModel *selectModel = self.newsData[indexPath.row];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-50, 40)];
    label.numberOfLines = 2;
    label.text = selectModel.title;
    label.font = [UIFont boldSystemFontOfSize:14.0f];
    label.textColor = [UIColor whiteColor];
    [cell.contentView addSubview:label];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-40, 20, 40, 15)];
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.font = [UIFont systemFontOfSize:14.0f];
    NSRange range = NSMakeRange(11, 5);
    timeLabel.text = [selectModel.time substringWithRange:range];
    [cell.contentView addSubview:timeLabel];
    
    return cell;
}
//9.设置单元格内容-涨跌榜内容
- (UITableViewCell *)createCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    ChooseModel *csModel = self.newsData[indexPath.row];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth/3.0+20, 25)];
    nameLabel.text = csModel.name;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [cell.contentView addSubview:nameLabel];
    
    UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, nameLabel.bottom, kScreenWidth/3.0+20, 15)];
    tagLabel.text = csModel.code;
    tagLabel.textAlignment = NSTextAlignmentLeft;
    tagLabel.textColor = [UIColor whiteColor];
    tagLabel.font = [UIFont systemFontOfSize:13.0f];
    [cell.contentView addSubview:tagLabel];
    
    UILabel *zxjLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.right, 0, kScreenWidth/3.0-20, 40)];
    zxjLabel.text = csModel.zxj;
    zxjLabel.textColor = [UIColor whiteColor];
    zxjLabel.textAlignment = NSTextAlignmentLeft;
    zxjLabel.adjustsFontSizeToFitWidth = YES;
    zxjLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [cell.contentView addSubview:zxjLabel];
    
    
    UILabel *zdfLabel = [[UILabel alloc] initWithFrame:CGRectMake(zxjLabel.right, 0, kScreenWidth/3.0-20, 40)];
        
    if ([csModel.zdf floatValue] > 0) {
        zdfLabel.text = [NSString stringWithFormat:@"+%@%%",csModel.zdf];
        zdfLabel.textColor = [UIColor greenColor];
    } else {
        zdfLabel.text = [NSString stringWithFormat:@"%@%%",csModel.zdf];
        zdfLabel.textColor = [UIColor redColor];
    }
    
    zdfLabel.textAlignment = NSTextAlignmentCenter;
    zdfLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [cell.contentView addSubview:zdfLabel];
    
    return cell;
}

#pragma mark - 按钮操作
//组头视图的按钮事件
- (void)buttonAction:(UIButton *)button {
    if (self.selectedButton.tag == button.tag) {
        self.selectedButton = button;
        return;
    }
    
    self.selectedButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    self.selectedButton.selected = NO;
    button.selected = YES;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    self.selectedButton = button;
}

@end
