//
//  YYBannerView.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYBannerViewDelegate <NSObject>

- (void)didSelectItemWithTag:(NSInteger)tag;

@end

@interface YYBannerView : UIView

@property(strong,nonatomic)NSArray *topStories;
@property(weak,nonatomic) id<YYBannerViewDelegate> delegate;

- (void)updateSubViewsOriginY:(CGFloat)value;

@end
