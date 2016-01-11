//
//  YYDetailPageController.h
//  YYDailyNewsDemo
//
//  Created by yyapple on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYSingleNewsBO.h"
#import "YYWebView.h"

@interface YYDetailPageController : UIViewController


@property (nonatomic, strong)YYSingleNewsBO *singleNewsBO;
@property (nonatomic, strong)YYWebView *txtWebView;
@end
