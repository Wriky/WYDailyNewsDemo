//
//  YYHomeViewController.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYHomeViewController.h"
#import "YYManager+MainViewInfo.h"
#import "YYMainViewCell.h"
#import "YYDateCell.h"
#import "YYDetailPageController.h"
#import "YYRefreshFooterView.h"
#import "YYLoadingView.h"
#import "YYRefreshView.h"
#import "YYAutoLoopView.h"
#import "YYSectionTitleView.h"

#define kLimitOffsetY sizeForDevices(165, 165, 200, 220)
#define kRowHeight 70.f
#define kSectionHeight 36.f

@interface YYHomeViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *mainTableView;
    UILabel *_navTitleLab;
    NSUInteger indexF;
    NSString *currentDateStr;
    YYAutoLoopView *autoLoopView;
}
@property (nonatomic, strong)YYLoadingView *loadingView; //加载视图
@property (nonatomic, strong)YYRefreshView *refreshView;
@property (nonatomic, strong)YYHomeViewModel *homeVModel;
@end

@implementation YYHomeViewController

#pragma mark -Init
- (instancetype)initWithModel:(YYHomeViewModel *)hvModel{
    self = [super init];
    if (self) {
        self.homeVModel = hvModel;
    }
    return self;
}

#pragma mark - View
#pragma mark - View factory
- (void)initSubViews{
    
    [self addMainTableView];
    [self navigationBarView];
    [self addTopView];
    [self.view addSubview:self.loadingView];
    
    [_homeVModel requestLatestNews:^{
        autoLoopView.banners = _homeVModel.topScrollArr;
         [mainTableView setTableHeaderView:autoLoopView];
        [mainTableView reloadData];
        [_loadingView dismissLoadingView];
        _loadingView = nil;
        
        DELAYEXECUTE(1.f, [_refreshView stopAnimation];);

    }];
    
}

- (void)addMainTableView{
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    [self.view addSubview:mainTableView];
    [mainTableView registerClass:[YYSectionTitleView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([YYSectionTitleView class])];
}


- (void)navigationBarView{
    self.navBarTitle = @"今日热闻";
    //假的navBar
    _fakeNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, TopMinY)];
    _fakeNavBar.backgroundColor = StandardColor_1;
    _fakeNavBar.alpha = 0.0;
    [self.view addSubview:_fakeNavBar];
    
    _navTitleLab = [[UILabel alloc]init];
    _navTitleLab.backgroundColor = [UIColor clearColor];
    _navTitleLab.textAlignment = NSTextAlignmentCenter;
    _navTitleLab.font = FontOfSize(17);
    _navTitleLab.textColor = LightColor_1;
    _navTitleLab.text = @"今日热闻";
    [_navTitleLab sizeToFit];
    [_navTitleLab setCenter:CGPointMake(self.view.centerX, 41.8f)];
    [self.view addSubview:_navTitleLab];
    
    _refreshView = [[YYRefreshView alloc] initWithFrame:CGRectMake(_navTitleLab.left-20.f, _navTitleLab.centerY-10.f, 20.f, 20.f)];
    [self.view addSubview:_refreshView];
}


- (void)addTopView{
    
    WS(weakSelf);
    autoLoopView = [[YYAutoLoopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, AdjustF(200.f))];

    autoLoopView.clickAutoLoopCallBackBlock = ^(YYSingleNewsBO *bannerNews){
        
        YYDetailPageController *webView = [[YYDetailPageController alloc] init];
        webView.singleNewsBO = bannerNews;
        [weakSelf.navigationController pushViewController:webView animated:YES];
    };
   
}

- (YYLoadingView *)loadingView{
    
    if (!_loadingView) {
        _loadingView = [[YYLoadingView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    
    return _loadingView;
}



#pragma mark - View action


#pragma mark - Delegate
#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_homeVModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_homeVModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
        static NSString *cellIndentifier = @"YYMainViewCell";
        YYMainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (nil == cell) {
            cell = [[YYMainViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            
        }
        cell.singleNewsBO = [_homeVModel newsAtIndexPath:indexPath];
        return cell;
  }


#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    YYSingleNewsBO *singleBO= [_homeVModel newsAtIndexPath:indexPath];
    YYDetailPageController *webView = [[YYDetailPageController alloc] init];
    webView.singleNewsBO = singleBO;
    [self.navigationController pushViewController:webView animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return kSectionHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return nil;
    }
    
    YYSectionTitleView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([YYSectionTitleView class])];
    headerView.textLabel.text = [_homeVModel titleForSection:section];
    return headerView;
}


#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
     CGFloat offSetY = scrollView.contentOffset.y;
    if ([scrollView isEqual:mainTableView]) {
    
        float h = offSetY / kLimitOffsetY;
        _fakeNavBar.alpha = (h > 1)?1:h;
        
        if (_fakeNavBar.alpha >= 1) {
            
            NavigationBarNeedShow;
            _fakeNavBar.hidden = YES;
            _navTitleLab.hidden = YES;
        }
        if (h < 1) {
            
            NavigationBarNeedHide;
            _fakeNavBar.hidden = NO;
            _navTitleLab.hidden = NO;
        }
        
        float todayHeight = _homeVModel.latestNewsBO.storiesArray.count*kRowHeight + AdjustF(200.f);
        if (scrollView.contentOffset.y < todayHeight) {
            self.navBarTitle = @"今日热闻";
            
        }else{
            NSArray *array = [mainTableView indexPathsForVisibleRows];
            NSIndexPath *indexPath = [array firstObject];
            YYLatestNewsBO *currentBO = _homeVModel.daysDataList[indexPath.section];
            self.navBarTitle = transformDateStr(currentBO.date);
            
            scrollView.contentInset = UIEdgeInsetsMake(TopMinY-kSectionHeight, 0, 0, 0);
    }
        
        if (offSetY<=0&&offSetY>=-80) {
            if (-offSetY <= 60) {
                if (!_homeVModel.isLoading) {
                    [_refreshView redrawFromProgress:-offSetY/60];
                }else{
                    [_refreshView redrawFromProgress:0];
                }
            }
            if(!_homeVModel.isLoading && !scrollView.isDragging && -offSetY>40 && -offSetY<=80){
                [_refreshView redrawFromProgress:0];
                [_refreshView startAnimation];
                
                [_homeVModel requestLatestNews:^{
                    autoLoopView.banners = _homeVModel.daysDataList;
                    [mainTableView reloadData];
                    [_loadingView dismissLoadingView];
                    _loadingView = nil;
                    
                    DELAYEXECUTE(1.f, [_refreshView stopAnimation];);
                    
                }];
                
            }
        }else if(offSetY <= 300) {
            [_refreshView redrawFromProgress:0];
        }
    }
    
    if (scrollView == mainTableView){
        
        [(YYAutoLoopView *)mainTableView.tableHeaderView yy_parallaxHeaderViewWithOffset:scrollView.contentOffset];
    }
    
    if (offSetY + kRowHeight > scrollView.contentSize.height - kScreenHeight) {
        if (!_homeVModel.isLoading) {
            [_homeVModel requestPreviousNews:^{
                [mainTableView reloadData];
            }];
        }
    }
}




#pragma mark - View Load
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;

    
    [self initSubViews];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_fakeNavBar.hidden == NO) {
        NavigationBarNeedHide;
    }
}

@end
