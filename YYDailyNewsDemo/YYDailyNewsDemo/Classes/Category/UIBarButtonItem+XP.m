//
//  UIBarButtonItem+XP.m
//  SeekClient2
//
//  Created by xiupintech on 15/8/10.
//  Copyright (c) 2015年 L. All rights reserved.
//

#import "UIBarButtonItem+XP.h"

@implementation UIBarButtonItem (XP)

- (id)initWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action {
    // 创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
   // btn.frame = CGRectMake(0, 0, 44, 44);
    // 设置普通背景图片
    UIImage *image = Image(icon);
    [btn setImage:image forState:UIControlStateNormal];
    
    // 设置高亮图片
    if (highlighted) {
        [btn setImage:Image(highlighted) forState:UIControlStateHighlighted];
    }
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    // 设置尺寸
    btn.bounds = (CGRect){CGPointZero, image.size};
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:btn];
}

+ (id)barButtonItemWithIconName:(NSString *)iconName highlightedIconName:(NSString *)highlightedIconName target:(id)target action:(SEL)action {
    
    return [[self alloc] initWithIcon:iconName highlightedIcon:highlightedIconName target:target action:action];
}



// ///////////////////////////////////////////////

- (id)initWithTitle:(NSString *)titleName target:(id)target action:(SEL)action{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:titleName forState:0];
    btn.titleLabel.font = FontOfSize(15);
    [btn setTitleColor:LightColor_1 forState:0];
    [btn setTitleColor:LightColor_2 forState:UIControlStateHighlighted];

      // 设置尺寸
    btn.bounds = CGRectMake(0, 0, GetTextWidth(FontOfSize(15), titleName) + 8, 44);
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:btn];

 
}

+ (id)barButtonItemWithTitleName:(NSString *)titleName
                          target:(id)target
                          action:(SEL)action{
    return [[self alloc] initWithTitle:titleName target:target action:action];


}


@end
