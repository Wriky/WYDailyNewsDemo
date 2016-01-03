//
//  UIBarButtonItem+XP.h
//  SeekClient2
//
//  Created by xiupintech on 15/8/10.
//  Copyright (c) 2015年 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XP)


/**
 *  设置barbuttonItem相关
 *
 *  @param iconName            item图片
 *  @param highlightedIconName item高亮图片
 *  @param target              target
 *  @param action              事件
 *
 *  @return id
 */
+ (id)barButtonItemWithIconName:(NSString *)iconName
            highlightedIconName:(NSString *)highlightedIconName
                         target:(id)target
                         action:(SEL)action;


/**
 *  设置barbuttonItem相关
 *
 *  @param titleName 文字
 *  @param target    target
 *  @param action    事件
 *
 *  @return id
 */
+ (id)barButtonItemWithTitleName:(NSString *)titleName
                         target:(id)target
                         action:(SEL)action;

@end
