//
//  YYBannerView.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYBannerView.h"
#import "YYTopperView.h"
#import "YYSingleNewsBO.h"

@interface YYBannerView()<UIScrollViewDelegate>

@property(strong,nonatomic)UIScrollView *scrollView;
@property(strong,nonatomic)UIPageControl *pageControl;
@property(strong,nonatomic)NSTimer *timer;

@end

@implementation YYBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, 300.f)];
        _scrollView.contentSize = CGSizeMake(ScreenWidth*7, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        for (int i = 0; i<7; i++) {
            YYTopperView *tsv = [[YYTopperView alloc] initWithFrame:CGRectMake(ScreenWidth*i, 0.f, ScreenWidth, 300.f)];
            [tsv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
            [tsv setTag:i+100];
            [_scrollView addSubview:tsv];
        }
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.f, 240.f, ScreenWidth,20.f)];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        [self addSubview:_pageControl];
    }
    return self;
}

- (void)tap:(UIGestureRecognizer *)recognizer {
    [self.delegate didSelectItemWithTag:recognizer.view.tag];
}

- (void)setTopStories:(NSArray *)topStories {
    [_timer invalidate];
    _pageControl.numberOfPages = topStories.count-2;
    _scrollView.contentOffset = CGPointMake(ScreenWidth, 0);
    _pageControl.currentPage = 0;
    for (int i = 0 ; i < topStories.count; i++) {
        YYTopperView *tsv = [_scrollView viewWithTag:(100+i)];
        YYSingleNewsBO *newsBO = topStories[i];
        [tsv.imageView yy_setImageWithUrlString:newsBO.imageUrl placeholderImage: Image( @"tags_selected")];
        NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:newsBO.newsTitle attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:21],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        CGSize size =  [attStr boundingRectWithSize:CGSizeMake(ScreenWidth-30, 200) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
        tsv.label.frame = CGRectMake(15, 0, ScreenWidth-30, size.height);
        [tsv.label setBottom:240];
        tsv.label.attributedText = attStr;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.f target:self selector:@selector(nextStoryDisplay) userInfo:nil repeats:YES];
}

- (void)nextStoryDisplay {
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x+ScreenWidth, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_scrollView]) {
        CGFloat offSetX = scrollView.contentOffset.x;
        if (offSetX == 6*ScreenWidth) {
            _scrollView.contentOffset = CGPointMake(ScreenWidth, 0);
            _pageControl.currentPage = 0;
        }else if (offSetX == 0){
            _scrollView.contentOffset = CGPointMake(5*ScreenWidth, 0);
            _pageControl.currentPage = 4;
        }else {
            _pageControl.currentPage = offSetX/ScreenWidth-1;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:5.0]];
}


- (void)updateSubViewsOriginY:(CGFloat)value {
    [_pageControl setBottom:260-value/2];
    NSUInteger index = _scrollView.contentOffset.x/ScreenWidth;
    YYTopperView *tsv= [_scrollView viewWithTag:index+100];
    [tsv.label setBottom:_pageControl.top];
}



@end
