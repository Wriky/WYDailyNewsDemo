//
//  YYDetailPageController.m
//  YYDailyNewsDemo
//
//  Created by yyapple on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYDetailPageController.h"
#import "YYManager+MainViewInfo.h"
#import "YYBottomBarView.h"
#import "YYLoadingView.h"
#import "YYDetailHeaderView.h"


@interface YYDetailPageController ()<UIWebViewDelegate, YYBottomBarDelegate, UIScrollViewDelegate>
{
    YYBottomBarView *bottomBar;
    YYDetailNewsBO *detailNewsBO;
}

@property (nonatomic, strong)YYDetailHeaderView *topHeaderView;
@property (nonatomic,strong) YYLoadingView *loadingView;//加载视图
@end

@implementation YYDetailPageController
#pragma mark - Data
- (void)loadHtmlData{
    [YYManager yy_getNewsDetailWithID:_singleNewsBO.newsId Success:^(YYDetailNewsBO *detailNews) {
        [_loadingView dismissLoadingView];
        _loadingView = nil;
        detailNewsBO = detailNews;

        [self reloadSubViews];
     
    } Failure:^(YYError *error) {
        
    }];
}

#pragma mark - View
#pragma mark - View factory

- (void)addSubViews{
    
    _txtWebView = [[YYWebView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20-43)];
    _txtWebView.delegate = self;
    _txtWebView.scrollView.delegate = self;
    [self.view addSubview:_txtWebView];
    
    _topHeaderView = [[YYDetailHeaderView alloc] initWithFrame:CGRectMake(0, -40, kScreenWidth, 260)];
    _topHeaderView.clipsToBounds = YES;
    [self.view addSubview:_topHeaderView];
    

    
    [self bottomBarView];
}

- (void)bottomBarView{
    bottomBar = [[YYBottomBarView alloc] init];
    bottomBar.frame = CGRectMake(0, kScreenHeight - 50.f, kScreenWidth, 50.f);
    bottomBar.delegate = self;
    [self.view addSubview:bottomBar];
}

- (YYLoadingView *)loadingView{
    
    if (!_loadingView) {
        _loadingView = [[YYLoadingView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    
    return _loadingView;
}

#pragma mark - View action
- (void)reloadSubViews{
    [_topHeaderView.imageView yy_setImageWithUrlString:detailNewsBO.imageUrl placeholderImage:Image(@"tags_selected")];
    NSDictionary *attributesDic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:21],NSForegroundColorAttributeName:[UIColor whiteColor]};
    CGSize size = [detailNewsBO.newsTitle boundingRectWithSize:CGSizeMake(kScreenWidth-30, 60) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributesDic context:nil].size;
    
    _topHeaderView.titleLab.frame = CGRectMake(15.f, _topHeaderView.frame.size.height-20.f-size.height, kScreenWidth-30.f, size.height);
    _topHeaderView.titleLab.attributedText = [[NSAttributedString alloc] initWithString:detailNewsBO.newsTitle attributes:attributesDic];
    _topHeaderView.imgSourceLab.text = [NSString stringWithFormat:@"图片: %@",detailNewsBO.imageSource];;
    
    NSString *htmlStr = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>",detailNewsBO.cssType[0],detailNewsBO.newsBody];
    [_txtWebView loadHTMLString:htmlStr baseURL:nil];
}


#pragma mark - Delegate
#pragma mark - YYBottomBarDelegate

- (void)selectBtn:(UIButton *)button
{
    switch (button.tag - BOTTOM_BAR_TAG)
    {
        case 0:
        {
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
        case 1:
        {

            break;
        }
        case 2:
        {
            break;
        }
        case 3:
        {
            
        }
        default:
            break;
    }
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offSetY = scrollView.contentOffset.y;
    if (-offSetY<=80&&-offSetY>=0) {
        _topHeaderView.frame = CGRectMake(0, -40-offSetY/2, kScreenWidth, 260-offSetY/2);
       
        [_topHeaderView.imgSourceLab setTop:240-offSetY/2];
        [_topHeaderView.titleLab setBottom:_topHeaderView.imgSourceLab.bottom-20];
        if (-offSetY>40&&!_txtWebView.scrollView.isDragging){
        }
    }else if (-offSetY>80) {
        _txtWebView.scrollView.contentOffset = CGPointMake(0, -80);
    }else if (offSetY <=300 ){
        _topHeaderView.frame = CGRectMake(0, -40-offSetY, kScreenWidth, 260);
    }
    
    if (offSetY + kScreenHeight > scrollView.contentSize.height + 160&&!_txtWebView.scrollView.isDragging) {
    }

}

#pragma mark - View Load
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self addSubViews];
    [self loadHtmlData];
 
    
     [self.view addSubview:self.loadingView];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NavigationBarNeedHide;
}




@end
