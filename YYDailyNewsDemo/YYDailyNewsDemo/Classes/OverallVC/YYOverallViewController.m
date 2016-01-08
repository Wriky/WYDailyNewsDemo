//
//  YYOverallViewController.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 16/1/5.
//  Copyright © 2016年 L. All rights reserved.
//

#import "YYOverallViewController.h"

#define AnimateDuration             0.2
#define MainViewOriginXFromValue    0
#define MainViewMoveXMaxValue kScreenWidth*0.6
#define LeftViewOriginXFromValue    -kScreenWidth*0.6


@interface YYOverallViewController ()

@property (nonatomic, strong)YYHomeViewController *homeViewController;
@property (nonatomic, strong)YYLeftMenuViewController *leftMenuViewController;
@property (nonatomic, strong)UIView *overallView;
@property (nonatomic, strong)UIView *leftMenuView;
@property (nonatomic, assign)CGFloat distance;
@property (nonatomic, strong)UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong)UIPanGestureRecognizer *panGesture;


@end

@implementation YYOverallViewController

#pragma mark - Init
- (instancetype)initWithLeftCtrl:(YYLeftMenuViewController *)leftMenuVC MainCtrl:(UIViewController *)homeVC{
    self = [super init];
    if (self) {
        _homeViewController = (YYHomeViewController *)homeVC;
        _leftMenuViewController = leftMenuVC;
        
    }
    return self;
}

#pragma mark - Data

#pragma mark - View
#pragma mark - View factory

#pragma mark - View action
- (void)panAction:(UIPanGestureRecognizer *)panRecognizer{
    CGFloat movex = [panRecognizer translationInView:self.view].x;
    CGFloat trueDistance = _distance + movex;
    if (trueDistance > 0 && trueDistance < MainViewMoveXMaxValue) {
        _leftMenuView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, LeftViewOriginXFromValue + trueDistance , 0);
        _overallView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, MainViewOriginXFromValue + trueDistance, 0);
    }
    if (panRecognizer.state == UIGestureRecognizerStateEnded) {
        if(trueDistance <= MainViewMoveXMaxValue/2){
            [self showHomeView];
        }else{
            [self showLeftMenuView];
        }
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapRecognizer{
    [self showHomeView];
}


- (void)showLeftMenuView{
    [UIView animateWithDuration:AnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _overallView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, MainViewMoveXMaxValue, 0);
        _leftMenuView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        _distance = MainViewMoveXMaxValue;
        [_overallView addGestureRecognizer:_tapGesture];
    }];
}

- (void)showHomeView{
    [UIView animateWithDuration:AnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _overallView.transform = CGAffineTransformIdentity;
        _leftMenuView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, LeftViewOriginXFromValue, 0);
    } completion:^(BOOL finished) {
        _distance = MainViewOriginXFromValue;
        [_overallView removeGestureRecognizer:_tapGesture];
    }];
}

#pragma mark - Delegate



#pragma mark - View Load
- (void)viewDidLoad{
    _distance = MainViewOriginXFromValue;
    
    _leftMenuView = _leftMenuViewController.view;
    _leftMenuView.frame = kScreenBounds;
    [self.view addSubview:_leftMenuView];
    
    _overallView = [[UIView alloc] initWithFrame:kScreenBounds];
    [self.view addSubview:_overallView];
    
    [_overallView addSubview:_homeViewController.view];
    
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:_panGesture];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        NavigationBarNeedHide;        
}

@end
