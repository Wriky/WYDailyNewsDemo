//
//  XPBannerView.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/29.
//  Copyright © 2015年 L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYSingleNewsBO.h"

@interface YYBannerView : UIImageView

@property (nonatomic, strong) YYSingleNewsBO *bannerNewsBO;


@property (nonatomic,   copy) void(^clickBannerCallBackBlock)(YYSingleNewsBO *bannerNewsBO);
@property (nonatomic, weak)UILabel *titleLab;

@end
