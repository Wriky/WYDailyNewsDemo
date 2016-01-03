//
//  UIViewController+Swizzling.h
//  SeekClient2.0
//
//  Created by xiupintech on 15/7/22.
//  Copyright (c) 2015年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SWIZZ_IT(log) [UIViewController swizz_log:log];

@interface UIViewController (Swizzling)

/**
 *  navigationbar 标题 
 */
@property (nonatomic,copy) NSString *navBarTitle;

/**
 *  导航上自定义的view
 */
@property (nonatomic,strong) UIView *navBarView;

/**
 *  是否打印出即将展现的viewcontroller的名称
 *
 *  @param log 是否打印
 */
+ (void)swizz_log:(BOOL)log;


@end
