//
//  YYRefreshView.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 16/1/4.
//  Copyright © 2016年 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYRefreshView : UIView

- (void)redrawFromProgress:(CGFloat)progress;
- (void)startAnimation;
- (void)stopAnimation;

@end
