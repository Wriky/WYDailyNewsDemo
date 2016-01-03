//
//  YYHeaderView.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYHeaderView : UIView

@property (nonatomic ,copy)  NSString *headerImage;

/**
 *  初始化
 *
 *  @param headerSize 尺寸
 *
 *  @return id
 */
+ (id)yy_headerViewWithCGSize:(CGSize)headerSize;



/**
 *  根据滑动距离来设置headerview
 *
 *  @param offset 滑动距离
 */
- (void)yy_parallaxHeaderViewWithOffset:(CGPoint)offset;

- (void)initial;


@end
