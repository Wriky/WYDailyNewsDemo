//
//  YYBottomBarView.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/29.
//  Copyright © 2015年 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYBottomBarDelegate <NSObject>
@optional
- (void)selectBtn:(UIButton *)button;

@end

@interface YYBottomBarView : UIView

@property (nonatomic,assign)id<YYBottomBarDelegate>delegate;


@end
