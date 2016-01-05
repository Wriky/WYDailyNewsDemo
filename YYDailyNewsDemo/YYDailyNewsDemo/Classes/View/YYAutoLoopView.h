//
//  YYAutoLoopView.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/29.
//  Copyright © 2015年 L. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XPBannerInfo;

/**
 *  自动滚动视图
 */
@interface YYAutoLoopView : UIView

@property (nonatomic, copy)   void(^clickAutoLoopCallBackBlock)(XPBannerInfo *banner);//点击图片事件回调
@property (nonatomic, assign) BOOL autoLoopScroll; // 是否自动滚动（默认为YES）
@property (nonatomic, assign) NSTimeInterval autoLoopScrollInterval; // 自动滚动的时间间隔（单位为s）
@property (nonatomic, strong) NSArray *banners;//bannner数组 数据源

- (void)reloadData;

- (void)yy_parallaxHeaderViewWithOffset:(CGPoint)offset;

@end
