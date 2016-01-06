//
//  YYRefreshFooterView.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/29.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYRefreshFooterView.h"

@implementation YYRefreshFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        
        //活动指示器初始化
        _activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activity.frame = CGRectMake(10, 0, 50, 70);
        [self addSubview:_activity];
        
        //箭头图片初始化
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 50)];
        _imageView.backgroundColor = [UIColor redColor];
        [self addSubview:_imageView];
        
        //信息label初始化
        _infolabel = [[UILabel alloc]initWithFrame:CGRectMake(100,0 ,100, 70)];
        _infolabel.text = @"刷新...";
        _infolabel.font = FontOfSize(20.f);
        _infolabel.textAlignment = NSTextAlignmentCenter;
        _infolabel.textColor = [UIColor blackColor];
        [self addSubview:_infolabel];
        
        //设置初始状态
        self.refreshState = RefreshStateNomal;
    }
    return self;
}

//初始状态
- (void)refreshStateNomal
{
    self.refreshState = RefreshStateNomal;
    [self.activity stopAnimating];
    self.infolabel.text = @"下拉加载更多...";
    self.imageView.layer.transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    self.imageView.hidden = NO;
}

//正在请求数据时
- (void)refreshStateLoading
{
    self.refreshState = RefreshStateLoading;
    self.imageView.hidden = YES;
    [UIView beginAnimations:nil context:nil];
    self.infolabel.text = @"正在加载...";
    [self.activity startAnimating];
    [UIView commitAnimations];
}

//下拉完成后
- (void)refreshStateRelsease
{
    self.refreshState = RefreshStateRelease;
    [UIView beginAnimations:nil context:nil];
    self.infolabel.text = @"释放后加载...";
    self.imageView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
    [UIView commitAnimations];
    
}

@end
