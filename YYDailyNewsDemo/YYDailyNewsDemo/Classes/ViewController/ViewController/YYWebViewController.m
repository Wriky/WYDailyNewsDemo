//
//  YYWebViewController.m
//  YYDailyNewsDemo
//
//  Created by yyapple on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYWebViewController.h"
#import "YYManager+MainViewInfo.h"
#import "YYBottomBarView.h"
#import "YYLoadingView.h"

@interface YYWebViewController ()<UIWebViewDelegate, YYBottomBarDelegate, UIScrollViewDelegate>
{
    YYBottomBarView *bottomBar;
    YYDetailNewsBO *detailNewsBO;
    UIWebView *txtWebView;
}

@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UILabel *imgSourceLab;
@property (nonatomic,strong) YYLoadingView *loadingView;//加载视图
@end

@implementation YYWebViewController
#pragma mark - Data
- (void)loadHtmlData{
    [YYManager yy_getNewsDetailWithID:_singleNewsBO.newsId success:^(YYDetailNewsBO *detailNews) {
        [_loadingView dismissLoadingView];
        _loadingView = nil;
        detailNewsBO = detailNews;

        [self reloadSubViews];
     
    } failure:^(YYError *error) {
        
    }];
}




#pragma mark - View
#pragma mark - View factory

- (void)addSubViews{
    
    txtWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, KScreenWidth, KScreenHeight-20-43)];
    txtWebView.delegate = self;
    txtWebView.scrollView.delegate = self;
    [self.view addSubview:txtWebView];
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -40, KScreenWidth, 260)];
    _headerView.clipsToBounds = YES;
    [self.view addSubview:_headerView];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, KScreenWidth, 300.f)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_headerView addSubview:_imageView];
    
    _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLab.numberOfLines = 0;
    [_headerView addSubview:_titleLab];
    
    _imgSourceLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 240, KScreenWidth-20, 20)];
    _imgSourceLab.textAlignment = NSTextAlignmentRight;
    _imgSourceLab.font = [UIFont systemFontOfSize:12];
    _imgSourceLab.textColor = [UIColor whiteColor];
    [_headerView addSubview:_imgSourceLab];
    
    [self bottomBarView];
}

- (void)bottomBarView{
    bottomBar = [[YYBottomBarView alloc] init];
    bottomBar.frame = CGRectMake(0, KScreenHeight - 50.f, KScreenWidth, 50.f);
    bottomBar.delegate = self;
    [self.view addSubview:bottomBar];
}

- (YYLoadingView *)loadingView{
    
    if (!_loadingView) {
        _loadingView = [[YYLoadingView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    }
    
    return _loadingView;
}

#pragma mark - View action
- (void)reloadSubViews{
    [_imageView yy_setImageWithUrlString:detailNewsBO.imageUrl placeholderImage:Image(@"backgroundImage")];
    NSDictionary *attributesDic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:21],NSForegroundColorAttributeName:[UIColor whiteColor]};
    CGSize size = [detailNewsBO.newsTitle boundingRectWithSize:CGSizeMake(KScreenWidth-30, 60) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributesDic context:nil].size;
    
    _titleLab.frame = CGRectMake(15.f, _headerView.frame.size.height-20.f-size.height, KScreenWidth-30.f, size.height);
    _titleLab.attributedText = [[NSAttributedString alloc] initWithString:detailNewsBO.newsTitle attributes:attributesDic];
    _imgSourceLab.text = [NSString stringWithFormat:@"图片: %@",detailNewsBO.imageSource];;
    
    NSString *htmlStr = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>",detailNewsBO.cssType[0],detailNewsBO.newsBody];
    [txtWebView loadHTMLString:htmlStr baseURL:nil];
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
        _headerView.frame = CGRectMake(0, -40-offSetY/2, KScreenWidth, 260-offSetY/2);
       
        [_imgSourceLab setTop:240-offSetY/2];
        [_titleLab setBottom:_imgSourceLab.bottom-20];
        if (-offSetY>40&&!txtWebView.scrollView.isDragging){
            //[self.viewmodel getPreviousStoryContent];
        }
    }else if (-offSetY>80) {
        txtWebView.scrollView.contentOffset = CGPointMake(0, -80);
    }else if (offSetY <=300 ){
        _headerView.frame = CGRectMake(0, -40-offSetY, KScreenWidth, 260);
    }
    
    if (offSetY + KScreenHeight > scrollView.contentSize.height + 160&&!txtWebView.scrollView.isDragging) {
       // [self.viewmodel getNextStoryContent];
    }

}

#pragma mark - View Load
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self loadHtmlData];
    [self addSubViews];
    
     [self.view addSubview:self.loadingView];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NavigationBarNeedHide;
}


@end
