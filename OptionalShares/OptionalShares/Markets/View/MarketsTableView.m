//
//  MarketsTableView.m
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "MarketsTableView.h"
#import "ChooseCell.h"
#import "HotModel.h"
#import "ChooseModel.h"
#import "HotDataViewController.h"
#import "UIView+UIViewController.h"
#import "MoreDataViewController.h"
#import "ShareDetailViewController.h"

#define kHeaderHeight (kScreenWidth/3.0-40)
#define kTableViewOffset 60

@implementation MarketsTableView {
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
    
    //设置tableView的高度
    self.height = kScreenHeight - kNvgAndTabHeight;
    
    //1.设置tableView滑动图标的颜色
    self.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    //2.清除tableView的背景
    self.backgroundColor = [UIColor clearColor];
    self.backgroundColor = nil;
    self.tableFooterView = nil;
    
    //3.设置代理
    self.delegate = self;
    self.dataSource = self;
    
    //4.从xib加载单元格
    identify = @"MyCell";
    UINib *nib = [UINib nibWithNibName:@"ChooseCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:identify];
    
    self.itemDatas = [NSMutableArray array];
    
}


#pragma mark - UITableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    //获取所有数据的code
    if (self.data.count != 0) {
        for (int i=0; i<self.data.count; i++) {
            
            //热门单元格排除
            if (self.isHot && i==1) {
                continue;
            }
            
            NSArray *array = self.data[i];
            NSMutableArray *item = [NSMutableArray array];
            for (int i=0; i<array.count; i++) {
                ChooseModel *csModel = array[i];
                NSString *code = csModel.code;
                [item addObject:code];
            }
            
            [self.itemDatas addObject:item];
        }
    }
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //是否有指数数据
    if (section == 0 && self.isHead) {
        return 0;
    }
    //是否有热门行业数据
    if (section == 1 && self.isHot && isShow[section]) {
        return 1;
    }
    
    //环球信息，组展开或收缩
    if (!isShow[section]) {
        return 0;
    }
    
    NSArray *array = self.data[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.isHot && indexPath.section == 1) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hehe"];
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = nil;
        
        UIImage *imgbg = [UIImage imageNamed:@"stock_market_hot_bg.png"];
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:imgbg];
        
        cell = [self _createFirstCell:cell indexPath:indexPath];
        
        return cell;
    }
    
    ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    NSArray *array = self.data[indexPath.section];
    cell.chooseModel = array[indexPath.row];
    
    cell.isRound = self.isRound;
    cell.isHK = self.isHK;
    cell.isUS = self.isUS;
    
    return cell;
}


//创建组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //1.若第一个组头有数据，单独处理，显示组头数据
    if (self.isHead && section == 0) {
        
        return [self _creatFirstHeader:section];
    }
    //若第一个组头有数据，将组头数组下标减1
    if (self.isHead) {
        section -= 1;
    }
    
    //2.创建组头视图
    UIControl *headerView = [[UIControl alloc] initWithFrame:CGRectZero];
    
//    UIImage *image = [UIImage imageNamed:@"finance_report_head.png"];
    headerView.backgroundColor = [UIColor colorWithRed:50/255.0 green:52/255.0 blue:53/255.0 alpha:1];
    
    headerView.contentMode = UIViewContentModeScaleAspectFit;
    headerView.tag = section+10;
    
    [headerView addTarget: self action:@selector(isShowAction:) forControlEvents:UIControlEventTouchUpInside];

    
    
    //3.显示组头标题的Label
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 35)];
    titleLable.font = [UIFont systemFontOfSize:16.0f];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.tag = 300;
    [headerView addSubview:titleLable];
    
    if (self.isRound && section == self.titles.count-1) {
        
        //一个组头显示三个标题
        NSArray *array = self.titles[section];
        titleLable.width = kScreenWidth/3;
        titleLable.text = array[0];
        
        UILabel *titleLable1 = [[UILabel alloc] initWithFrame:CGRectMake(titleLable.right, 0, 80, 35)];
        titleLable1.text = array[1];
        titleLable1.font = [UIFont systemFontOfSize:16.0f];
        titleLable1.textColor = [UIColor whiteColor];
        titleLable1.textAlignment = NSTextAlignmentLeft;
        [headerView addSubview:titleLable1];
        
        UILabel *titleLable2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-80, 0, 80, 35)];
        titleLable2.text = array[2];
        titleLable2.font = [UIFont systemFontOfSize:16.0f];
        titleLable2.textColor = [UIColor whiteColor];
        titleLable2.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:titleLable2];
        
    } else {
        
        titleLable.text = self.titles[section];
    }
    
    
    //4.展开与收缩视图
    //展开和收缩的标志图片
    UIImageView *switchView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 13, 13)];
    titleLable.left = switchView.right;
    //环球股跟其他股的逻辑相差1
    BOOL show = self.isRound?isShow[section]:isShow[section+1];
    if (show) {
        
        switchView.image = [UIImage imageNamed:@"newslist_btn_switch_on.png"];
    } else {
        switchView.image = [UIImage imageNamed:@"newslist_btn_switch_off.png"];
    }
    
    switchView.contentMode = UIViewContentModeScaleAspectFit;
    switchView.tag = 200;
    [headerView addSubview:switchView];

    if (!self.isRound) {
        
        //5.更多图标
        UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        moreButton.tag = section+10;
        moreButton.frame = CGRectMake(kScreenWidth-80, 0, 80, 35);
        [moreButton setImage:[UIImage imageNamed:@"newslist_btn_enter.png"] forState:UIControlStateNormal];
        
        [moreButton addTarget:self action:@selector(moreDataAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:moreButton];
        
        if (isShow[section+1]) {
            moreButton.hidden = NO;
        } else {
            moreButton.hidden = YES;
        }
    }
    
    //6.分隔符
    UIImageView *seperateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 2)];
    seperateView.image = [UIImage imageNamed:@"finance_report_sectionhead.png"];
    [headerView addSubview:seperateView];
    
    
    return headerView;
}

//设置单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isHot && indexPath.section == 1) {
        return 2*kScreenWidth/3.0;
    }
    
    return 40;
}
//设置组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0 && self.isHead) {
        return kHeaderHeight;
    }
    
    return 30;
}

#pragma mark - 单元格、组头的子视图
//设置热门行业单元格
- (UITableViewCell *)_createFirstCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    
    
    NSArray *sectionData = self.data[indexPath.section];
    for (int i=0; i<sectionData.count; i++) {
        
        HotModel *hotModel = sectionData[i];
        
        UIControl *control = [[UIControl alloc] init];
        //2.创建6个子视图
        if (i >= 3) {
            control.frame = CGRectMake((i-3)*kScreenWidth/3.0, kScreenWidth/3.0, kScreenWidth/3.0, kScreenWidth/3.0);
        } else {
            control.frame = CGRectMake(i*kScreenWidth/3.0, 0, kScreenWidth/3.0, kScreenWidth/3.0);
        }
        control.tag = i+10;
        [control addTarget:self action:@selector(hotDataAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:control];
        
        //3.创建显示名称的Label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, control.width, control.height/5.0)];
        titleLabel.text = hotModel.bd_name;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        [control addSubview:titleLabel];
        
        //4.创建显示最新价的Label
        UILabel *zdfLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.bottom, control.width,control.height/5.0)];
        zdfLabel.text = [hotModel.bd_zdf stringByAppendingString:@"%"];
        zdfLabel.font = [UIFont systemFontOfSize:16.0f];
        zdfLabel.textAlignment = NSTextAlignmentCenter;
        [control addSubview:zdfLabel];
        
        if ([hotModel.bd_zdf floatValue]>0) {
            zdfLabel.text = [NSString stringWithFormat:@"+%@",zdfLabel.text];
            zdfLabel.textColor = [UIColor greenColor];
        } else {
            
            zdfLabel.textColor = [UIColor redColor];
        }
        
        //5.显示企业名
        UILabel *nzgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, zdfLabel.bottom, control.width,control.height/5.0-5)];
        nzgLabel.text = hotModel.nzg_name;
        nzgLabel.textColor = [UIColor whiteColor];
        nzgLabel.font = [UIFont systemFontOfSize:12.0f];
        nzgLabel.textAlignment = NSTextAlignmentCenter;
        [control addSubview:nzgLabel];
        
        
        //6.创建显示最新价的Label
        UILabel *dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, nzgLabel.bottom, control.width, control.height/5.0-5)];
        dataLabel.textColor = [UIColor whiteColor];
        dataLabel.textAlignment = NSTextAlignmentCenter;
        dataLabel.font = [UIFont systemFontOfSize:12.0f];
        [control addSubview:dataLabel];
        
        CGFloat zxj = [hotModel.nzg_zxj floatValue];
        CGFloat zdf = [hotModel.nzg_zdf floatValue];
        
        NSString *zxjStr = [NSString stringWithFormat:@"%.2f",zxj];
        NSString *zdfStr = [NSString stringWithFormat:@"%.2f",zdf];
        if (zdf > 0) {
            
            dataLabel.text = [NSString stringWithFormat:@"%@ +%@%%",zxjStr,zdfStr];
        } else {
            
            dataLabel.text = [NSString stringWithFormat:@"%@ %@%%",zxjStr,zdfStr];
        }
        
    }
    
    return cell;
}

//创建第一个组头视图
- (UIView *)_creatFirstHeader:(NSInteger)section {
    
    //1.创建父视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    
    NSArray *headData = self.data[section];
    for (int i=0; i<headData.count; i++) {
        
        ChooseModel *csModel = headData[i];
        //2.创建3个子视图
        UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(i*kScreenWidth/3.0, 10, kScreenWidth/3.0, kHeaderHeight)];
        [control addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];
        control.tag = i+10;
        [view addSubview:control];
        
        //3.创建显示名称的Label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, control.width, control.height/3.0+6)];
        titleLabel.text = csModel.name;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        [control addSubview:titleLabel];
        
        //4.在子视图上添加增长图标
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, titleLabel.bottom+5, 6, 5)];
        [control addSubview:imgView];
        
        //5.创建显示最新价的Label
        UILabel *zxjLabel = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+5, titleLabel.bottom, control.width-10-imgView.width,control.height/3.0)];
        zxjLabel.text = csModel.zxj;
        zxjLabel.font = [UIFont systemFontOfSize:14.0f];
        [control addSubview:zxjLabel];
        
        if ([csModel.zd floatValue]>0) {
            UIImage *img = [UIImage imageNamed:@"icon_green_up.png"];
            imgView.image = img;
            zxjLabel.textColor = [UIColor greenColor];
        } else {
            UIImage *img = [UIImage imageNamed:@"icon_red_down.png"];
            imgView.image = img;
            zxjLabel.textColor = [UIColor redColor];
        }
        
        //6.创建显示增长额的Label
        UILabel *dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, zxjLabel.bottom, control.width, control.height/3.0-6)];
        dataLabel.textColor = [UIColor whiteColor];
        dataLabel.textAlignment = NSTextAlignmentCenter;
        dataLabel.font = [UIFont systemFontOfSize:12.0f];
        [control addSubview:dataLabel];
        
        CGFloat zd = [csModel.zd floatValue];
        CGFloat zdf = [csModel.zdf floatValue];
        
        NSString *zdStr = [NSString stringWithFormat:@"%.2f",zd];
        NSString *zdfStr = [NSString stringWithFormat:@"%.2f",zdf];
        if (zd > 0) {
            
            dataLabel.text = [NSString stringWithFormat:@"+%@  +%@%%",zdStr,zdfStr];
        } else {
            
            dataLabel.text = [NSString stringWithFormat:@"%@  %@%%",zdStr,zdfStr];
        }
        
    }
    
    return view;
}

//点击单元格事件，查看股票详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.isRound) {
        return;
    }
    
    ShareDetailViewController *shareVC = [[ShareDetailViewController alloc] init];

    if (self.isHot) {
        shareVC.itemData = self.itemDatas[indexPath.section-1];
    } else {
        shareVC.itemData = self.itemDatas[indexPath.section];
    }
    BOOL isHS = (self.isHot && !self.isHK)? YES:NO;
    shareVC.isHS = isHS;
    shareVC.isHK = self.isHK;
    shareVC.isUS = self.isUS;
    
    NSArray *array = self.data[indexPath.section];
    ChooseModel *chooseModel = (ChooseModel *)array[indexPath.row];

    shareVC.code = chooseModel.code;
    
    [self.navigationViewController pushViewController:shareVC animated:YES];
    
}

#pragma mark - 按钮事件
//点击第一个组头上得按钮
- (void)detailAction:(UIControl *)control {
    ShareDetailViewController *shareVC = [[ShareDetailViewController alloc] init];
    
    BOOL isHS = (self.isHot && !self.isHK)? YES:NO;
    shareVC.isHS = isHS;
    shareVC.isHK = self.isHK;
    shareVC.isUS = self.isUS;
    shareVC.isHead = YES;
    shareVC.itemData = self.itemDatas[0];
    NSArray *headData = self.data[0];
    ChooseModel *chooseModel = headData[control.tag-10];
    
    shareVC.code = chooseModel.code;
    
    [self.navigationViewController pushViewController:shareVC animated:YES];
}

//组的展开与收缩
- (void)isShowAction:(UIControl *)control {
    
    control.hidden = !control.hidden;
    NSInteger index = control.tag-10;
    if (self.isHead) {
        index += 1;
    }

    isShow[index] = !isShow[index];
    
    //3.刷新
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
    
    
    [self reloadSections:indexSet
        withRowAnimation:UITableViewRowAnimationFade];
    
    if (isShow[index]) {
        
        NSIndexPath *indextPath = [NSIndexPath indexPathForItem:0 inSection:index];
        [self scrollToRowAtIndexPath:indextPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
}

//点击热门单元格事件
- (void)hotDataAction:(UIControl *)control {
    NSArray *hotDatas = self.data[1];

    if (hotDatas.count <= 0) {
        return;
    }
    
    HotModel *hotModel = hotDatas[control.tag-10];
    
    NSString *tString = hotModel.bd_code;
    
    MoreDataViewController *moreVC = [[MoreDataViewController alloc] init];
    BOOL isHS = (self.isHot && !self.isHK)? YES:NO;
    moreVC.isColor = YES;
    moreVC.isHS = isHS;
    moreVC.isHK = self.isHK;
    moreVC.isHotCell = YES;
    moreVC.title = hotModel.bd_name;
    moreVC.tString = [NSString stringWithFormat:@"&t=%@",tString];

    [self.navigationViewController pushViewController:moreVC animated:YES];
}

//点击组头更多按钮，加载更多数据
- (void)moreDataAction:(UIButton *)button {
    
    if (button.tag == 10 && self.isHot) {   //热门行业
        
        HotDataViewController *hotVC = [[HotDataViewController alloc] init];
        hotVC.isHK = self.isHK;
        hotVC.title = self.titles[button.tag-10];
        BOOL isHS = (self.isHot && !self.isHK)? YES:NO;
        hotVC.isHS = isHS;
        hotVC.isHK = self.isHK;
        
        UINavigationController *navigation = (UINavigationController *)self.navigationViewController;
        [navigation pushViewController:hotVC animated:YES];
    } else {
    
        if (self.isHot && !self.isHK) {     //沪深
           
            NSArray *array = @[@"&t=ranka/chr",@"&t=ranka/chr",@"&t=ranka/trunr",@"&t=ranka/dtzf"];
            MoreDataViewController *moreVC = [[MoreDataViewController alloc] init];
            moreVC.isHS = YES;
            if (button.tag-10 == 2) {
                moreVC.isAsc = YES;
            }
            
            if (button.tag-10 == 3 || button.tag-10 == 4) {
                moreVC.isColor = NO;
            } else {
                moreVC.isColor = YES;
            }
            moreVC.title = self.titles[button.tag-10];
            moreVC.tString = array[button.tag-10-1];
            [self.navigationViewController pushViewController:moreVC animated:YES];
        }
        else if (self.isHK) {       //港股
            
            NSArray *array = @[
                               @"&board=main_all&metric=change_rate",
                               @"&board=main_all&metric=change_rate",
                               @"&board=main_all_amount&metric=amount",
                               @"&board=gem_all&metric=change_rate",
                               @"&board=gem_all&metric=change_rate",
                               @"&board=gem_all_amount&metric=amount",
                               @"&board=warrant_all&metric=amount",
                               @"&board=niuxiong_all&metric=amount",
                               ];
        
            MoreDataViewController *moreVC = [[MoreDataViewController alloc] init];
            if (button.tag-10 == 2 || button.tag-10 == 5) {
                moreVC.isAsc = YES;
            }
            
            if (button.tag-10==3 || button.tag-10==6|| button.tag-10==7|| button.tag-10==8) {
                moreVC.isColor = NO;
            } else {
                moreVC.isColor = YES;
            }
            moreVC.isHK = self.isHK;
            moreVC.title = self.titles[button.tag-10];
            moreVC.tString = array[button.tag-10-1];
            [self.navigationViewController pushViewController:moreVC animated:YES];
            
        }
        else if (self.isUS) {       //美股
          
            NSArray *array = @[
                               @"&m=zgg",
                               @"&m=ustec",
                               ];
            
            MoreDataViewController *moreVC = [[MoreDataViewController alloc] init];
   
            moreVC.isColor = YES;
            moreVC.isUS = self.isUS;
            moreVC.title = self.titles[button.tag-10];
            moreVC.tString = array[button.tag-10];
            [self.navigationViewController pushViewController:moreVC animated:YES];
        }
    }
    
}


@end
