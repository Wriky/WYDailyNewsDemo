//
//  YYMainViewController.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYMainViewController.h"
#import "YYManager+MainViewInfo.h"
#import "YYMainViewCell.h"
#import "YYDateCell.h"
#import "YYWebViewController.h"
#import "YYRefreshFooterView.h"
#import "YYLoadingView.h"
#import "YYRefreshView.h"
#import "YYAutoLoopView.h"

#define kLimitOffsetY sizeForDevices(165, 165, 200, 220)

@interface YYMainViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *mainTableView;
    YYLatestNewsBO *latesNewsBO;
    NSMutableArray *tableNewsArr;
    NSMutableArray *scrollNewsArr;
    UIView  *_fakeNavBar;//假的导航
    UILabel *_navTitleLab;
    NSUInteger indexF;
    NSString *currentDateStr;
    NSString *beforeDateStr;
    MJRefreshAutoNormalFooter *footer;
    YYAutoLoopView *autoLoopView;
    BOOL isLoading;
}
@property (nonatomic, strong)YYLoadingView *loadingView; //加载视图
@property (nonatomic, strong)YYRefreshView *refreshView;
@end

@implementation YYMainViewController

#pragma mark - Data
- (void)requestLatestNewsData{
    isLoading = YES;
     [YYManager yy_getMainViewNewsWithField:@"latest" success:^(YYLatestNewsBO *newsBO) {
         [_loadingView dismissLoadingView];
         _loadingView = nil;
         latesNewsBO = newsBO;
         tableNewsArr = [[NSMutableArray alloc] init];
         [tableNewsArr addObjectsFromArray:latesNewsBO.storiesArray];
         
         beforeDateStr = latesNewsBO.date;
         [self addTopView];
         [mainTableView reloadData];
         [mainTableView.mj_header endRefreshing];
         isLoading = NO;
         [_refreshView stopAnimation];

    } failure:^(YYError *error) {
    }];
}

- (void)reloadMoreData{
    
    [YYManager yy_getPreviousNewsWithDate:beforeDateStr success:^(YYLatestNewsBO *newsBO) {
       [tableNewsArr addObject:newsBO.date];
       [tableNewsArr addObjectsFromArray:newsBO.storiesArray];
        
        [mainTableView reloadData];
        [mainTableView.mj_footer endRefreshing];
        beforeDateStr = newsBO.date;
    } failure:^(YYError *error) {
        
    }];
}

- (void)constructScrollData{
    NSArray *topArray = latesNewsBO.topStoriesArray;
    scrollNewsArr = [[NSMutableArray alloc] init];
    for (NSUInteger i=0; i<topArray.count; i++) {
        YYSingleNewsBO *scrollNewsBO = topArray[i];
        XPBannerInfo *bannerInfo = [[XPBannerInfo alloc] init];
        bannerInfo.bannerImage = scrollNewsBO.imageUrl;
        bannerInfo.newsId = scrollNewsBO.newsId;
        [scrollNewsArr addObject:bannerInfo];
    }

}

- (void)addTopView{
    
    [self constructScrollData];
    WS(weakSelf);
    autoLoopView = [[YYAutoLoopView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 200.f)];
    autoLoopView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    autoLoopView.contentMode = UIViewContentModeScaleAspectFill;
    autoLoopView.banners = scrollNewsArr;
    autoLoopView.clickAutoLoopCallBackBlock = ^(XPBannerInfo *banner){
        YYSingleNewsBO *singleBO= [[YYSingleNewsBO alloc] init];
        singleBO.newsId = banner.newsId;
        singleBO.imagesUrl = @[banner.bannerImage];
        YYWebViewController *webView = [[YYWebViewController alloc] init];
        webView.singleNewsBO = singleBO;
        [weakSelf.navigationController pushViewController:webView animated:YES];
    };
    [mainTableView setTableHeaderView:autoLoopView];
    
    [scrollNewsArr removeAllObjects];
    
}

#pragma mark - View
#pragma mark - View factory
- (void)addMainTableView{
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, KScreenWidth, 200.f)];
    [self.view addSubview:mainTableView];
    
}


- (void)navigationBarView{
    //假的navBar
    _fakeNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, TopMinY)];
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
    [_navTitleLab setCenter:CGPointMake(self.view.centerX, 38.f)];
    [self.view addSubview:_navTitleLab];
    
    _refreshView = [[YYRefreshView alloc] initWithFrame:CGRectMake(_navTitleLab.left-20.f, _navTitleLab.centerY-10.f, 20.f, 20.f)];
    [self.view addSubview:_refreshView];
}

- (YYLoadingView *)loadingView{
    
    if (!_loadingView) {
        _loadingView = [[YYLoadingView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    }
    
    return _loadingView;
}


- (void)addHeader{
    mainTableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self requestLatestNewsData];
        
    }];
    [self addFooter];
}


- (void)addFooter{
    if (footer) {
        return;
    }
    footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadMoreData)];
    [footer setTitle:@"上拉加载更多..." forState:MJRefreshStateRefreshing];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    mainTableView.mj_footer = footer;
    mainTableView.mj_footer.hidden = YES;


}
#pragma mark - View action
- (void)initCircleProgress{
    
    
}

#pragma mark - Delegate
#pragma mark - UITableViewDataSource and Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableNewsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id model = [tableNewsArr objectAtIndex:indexPath.row];
    if ([model isKindOfClass:[NSString class]]) {
        static NSString *cellIndentifier = @"YYDateCell";
        YYDateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (nil == cell) {
            cell = [[YYDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            
        }
        cell.dateStr = [tableNewsArr objectAtIndex:indexPath.row];
        return cell;
    }
    
    if ([model isKindOfClass:[YYSingleNewsBO class]]) {
        static NSString *cellIndentifier = @"YYMainViewCell";
        YYMainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (nil == cell) {
            cell = [[YYMainViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            
        }
        cell.singleNewsBO = tableNewsArr[indexPath.row];
        return cell;
    }
   
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    YYSingleNewsBO *singleBO= tableNewsArr[indexPath.row];
    YYWebViewController *webView = [[YYWebViewController alloc] init];
    webView.singleNewsBO = singleBO;
    [self.navigationController pushViewController:webView animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = [tableNewsArr objectAtIndex:indexPath.row];
    if ([model isKindOfClass:[NSString class]]) {
        return 40.f;
    }

    return 70.f;
}


#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:mainTableView]) {
    
        CGFloat offSetY = scrollView.contentOffset.y;
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
        
        float todayHeight = latesNewsBO.storiesArray.count*70.f + 220.f;
        if (scrollView.contentOffset.y < todayHeight) {
            self.navBarTitle = @"今日热闻";
            
        }else{
            NSArray *array = [mainTableView indexPathsForVisibleRows];
            NSIndexPath *indexPath = [array firstObject];
            id model = tableNewsArr[indexPath.row];
            
            if ([model isKindOfClass:[NSString class]]) {
                indexF = indexPath.row;
                currentDateStr  =  [tableNewsArr objectAtIndex:indexPath.row];
                
                self.navBarTitle = transformDateStr(currentDateStr);
            }
            
            if (indexPath.row < indexF) {
                self.navBarTitle = getPreviousDate(currentDateStr);
            }
        }
        
        if (offSetY<=0&&offSetY>=-80) {
            if (-offSetY <= 60) {
                if (!isLoading) {
                   [_refreshView redrawFromProgress:-offSetY/60];
                }else{
                   [_refreshView redrawFromProgress:0];
                }
            }
            if(isLoading && !scrollView.isDragging){
                [_refreshView redrawFromProgress:0];
                [_refreshView startAnimation];
               
            }
            
            
        }else if(offSetY<-80){
          //  mainTableView.contentOffset = CGPointMake(0.f, -80.f);
        }else if(offSetY <= 300) {
            [_refreshView redrawFromProgress:0];
                   }
    }
    
    if (scrollView == mainTableView){
        
        [(YYAutoLoopView *)mainTableView.tableHeaderView yy_parallaxHeaderViewWithOffset:scrollView.contentOffset];
    }
}


#pragma mark - View Load
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navBarTitle = @"今日热闻";
   
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initCircleProgress];
    [self requestLatestNewsData];
    [self addMainTableView];

    [self navigationBarView];
    [self addHeader];
   
    [self.view addSubview:self.loadingView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_fakeNavBar.hidden == NO) {
        NavigationBarNeedHide;
    }
}

@end
