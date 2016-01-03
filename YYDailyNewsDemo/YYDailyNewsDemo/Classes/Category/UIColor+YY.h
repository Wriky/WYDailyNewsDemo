//
//  UIColor+YY.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIColor (YY)

/**
 *  根据颜色的十六进制码生成颜色
 *
 *  @param colorHexCode 颜色的十六进制码
 *
 *  @return 颜色
 */
+ (UIColor *)yy_colorWithColorHexCode:(NSString *)colorHexCode;

@end
