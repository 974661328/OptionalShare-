//
//  PortfolioViewController.m
//  OptionalShares
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联. All rights reserved.
//

#import "PortfolioViewController.h"
#import "BaseTableView.h"
#import "ChooseTableView.h"
#import "ChooseModel.h"
#import "MyDataService.h"

@interface PortfolioViewController ()

@end

@implementation PortfolioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //数据未加载，隐藏tableView
    self.tableView.hidden = YES;
    //加载提示
    [super showLoading:YES];
    
    //1.创建导航栏按钮
    [self _createNavigationItems];
    
    //2.加载数据
    [self _loadData];
    
    //3.下拉刷新
    __weak PortfolioViewController *weakSelf = self;
    [self.tableView setPullBlock:^{
       
        [weakSelf _loadData];
    }];
    
    
}

//加载数据
- (void)_loadData {
    
    NSString *urlstring = @"http://stockapp.finance.qq.com/pstock/api/appstockshow.php?appn=3G&stktype=qq&grpid=0&_appName=android&_dev=kylepluschn&_devId=358905055466716&_appver=3.4.0&_ifChId=17&_osVer=4.1.2&_uin=956013350";
    
    NSDictionary *params = @{
                             @"code":@"sz002007%7Csz002155%7Csz002142%7Csz002202%7Csz002024%7Csh600002%7Csh600036%7Csh600016%7Csh600050%7Csh600028%7Chk00600%7Csz000600%7Csh600600"
                             };
    
    [MyDataService requestURL:urlstring httpMethod:@"POST" params:[params mutableCopy] complection:^(id result) {
        
        NSDictionary *dataDic = result[@"data"];
        NSArray *list = dataDic[@"list"];
        
        self.data = [NSMutableArray arrayWithCapacity:list.count];
        for (NSDictionary *dic in list) {
            
            ChooseModel *chooseModel = [[ChooseModel alloc] initWithDataDic:dic];
            
            [self.data addObject:chooseModel];
        }
        
        if (self.data == nil) { //无数据，显示添加按钮
            self.tableView.hidden = YES;
            //创建添加数据按钮
            [self _createAddViews];
            
            
        } else {                //有数据，显示数据
            
            self.tableView.data = self.data;
            //数据加载完成，显示tableView
            self.tableView.hidden = NO;
            //隐藏加载提示
            [super showLoading:NO];
            
            //若是下拉刷新，收起下拉
            [self.tableView doneLoadingTableViewData];
            
            [self.tableView reloadData];
        }
        
    }];
}

//创建导航栏按钮
- (void)_createNavigationItems {
    
    //1.创建查询按钮
    UIImage *searchImg = [UIImage imageNamed:@"stock_navigation_search.png"];
    UIImage *searchImgDown = [UIImage imageNamed:@"stock_navigation_search_down.png"];
    UIButton *searchbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchbutton setImage:searchImg forState:UIControlStateNormal];
    [searchbutton setImage:searchImgDown forState:UIControlStateHighlighted];
    searchbutton.frame = CGRectMake(0, 0, 22, 22);
    [searchbutton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchbutton];
    
    //2.创建刷新按钮
    UIImage *refreshImg = [UIImage imageNamed:@"stock_navigation_refresh.png"];
    UIImage *refreshImgDown = [UIImage imageNamed:@"stock_navigation_refresh_down.png"];
    UIButton *refreshbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshbutton setImage:refreshImg forState:UIControlStateNormal];
    [refreshbutton setImage:refreshImgDown forState:UIControlStateHighlighted];
    refreshbutton.frame = CGRectMake(0, 0, 22, 22);
    [refreshbutton addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithCustomView:refreshbutton];
    
    //3.添加到导航栏右按钮
    NSArray *items = @[refreshItem,searchItem];
    self.navigationItem.rightBarButtonItems = items;
   
    //4.创建编辑按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 40);
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setHighlighted:NO];
    [button setTitleColor:[UIColor colorWithRed:80/255.0 green:140/255.0 blue:240/255.0 alpha:1] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = editItem;
    
    //5.创建删除按钮
    [self _createDeleteButton];
    
}

- (void)_createDeleteButton {
    //创建删除按钮
    UIButton *deletebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deletebutton setTitle:@"删除" forState:UIControlStateNormal];
    [deletebutton setTitleColor:[UIColor colorWithRed:80/255.0 green:140/255.0 blue:240/255.0 alpha:1] forState:UIControlStateNormal];
    deletebutton.frame = CGRectMake(kScreenWidth-80, 0, 80, 49);
    [deletebutton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    deletebutton.hidden = YES;
    deletebutton.tag = 333;
    
    [self.navigationController.navigationBar addSubview:deletebutton];
}

//创建添加按钮
- (void)_createAddViews {
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(0, 0, 120, 70);
    UIImage *addImg = [UIImage imageNamed:@"add.png"];
    [addButton setBackgroundImage:addImg forState:UIControlStateNormal];
    addButton.center = self.view.center;
    addButton.top -= 40;
    [addButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    label.center = addButton.center;
    label.top = addButton.bottom;
    label.text = @"暂无股票 点击添加";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:label];
    
}

#pragma mark - 按钮事件
//添加、查询按钮
- (void)searchAction {
    NSLog(@"1");
}

//刷新按钮
- (void)refreshAction {
    [self _loadData];
}

//编辑按钮
- (void)editAction:(UIButton *)button {
    
    button.selected = !button.selected;
    if (button.selected) {  //tableView处于编辑状态
        
        //将编辑按钮转成完成按钮
        [button setTitle:@"完成" forState:UIControlStateNormal];
        
        //显示删除按钮
        UIButton *deleted = (UIButton *)[self.navigationController.navigationBar viewWithTag:333];
        deleted.hidden = NO;
        
        //隐藏刷新，查询按钮
//        self.navigationItem.rightBarButtonItem.customView.hidden = YES;
        NSArray *items = self.navigationItem.rightBarButtonItems;
        for (UIBarButtonItem *item in items) {
            item.customView.hidden = YES;
        }
        
        //设置编辑模式状态，单元格是否可以多选
        self.tableView.allowsMultipleSelectionDuringEditing = YES;
        
        //设置标示图处于编辑模式
        [self.tableView setEditing:YES animated:YES];
        
    } else {            //tableView处于非编辑状态
        
        //将编辑按钮转成完成按钮
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        
        //隐藏删除按钮
        UIButton *deleted = (UIButton *)[self.navigationController.navigationBar viewWithTag:333];
        deleted.hidden = YES;
        
        //显示刷新，查询按钮
        NSArray *items = self.navigationItem.rightBarButtonItems;
        for (UIBarButtonItem *item in items) {
            item.customView.hidden = NO;
        }
        
        self.tableView.allowsMultipleSelectionDuringEditing = NO;
        
        [self.tableView setEditing:NO];
    }
    
}

//删除事件
- (void)deleteAction:(UIButton *)button {
    
    if (self.tableView.selectedRows.count == 0) {
        return;
    }
    
    for (NSIndexPath *indexPath in self.tableView.selectedRows) {
        
        //1.删除数组中的消息对象
        [self.data removeObjectAtIndex:indexPath.row];
        
    }
    
    //2.从tableView 中删除一个单元格
    [self.tableView deleteRowsAtIndexPaths:self.tableView.selectedRows
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView.selectedRows removeAllObjects];
}

@end
