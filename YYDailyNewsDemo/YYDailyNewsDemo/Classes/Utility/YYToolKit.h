//
//  YYToolKit.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const YYRequestGET; // get
UIKIT_EXTERN NSString * const YYRequestPOST; // post


#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenBounds [UIScreen mainScreen].bounds
#define NavHeight   50.f
#define TopMinY 64.f
#define YYTimeoutInterval 20.0 // 请求超时时间
#define BOTTOM_BAR_TAG 9779

// 日志开关
#ifndef DLog
#ifdef DEBUG
#define DLog(...) NSLog(__VA_ARGS__)
#else
#define DLog(...)
#endif
#endif

//AppDelegate
#define kAppdelegate (AppDelegate *)[UIApplication sharedApplication].delegate;

// 延迟调用
#define DELAYEXECUTE(delayTime,func) (dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{func;}))

//颜色相关
#define StandardColor_1 [UIColor yy_colorWithColorHexCode:@"#f52443"] //红
#define StandardColor_2 [UIColor yy_colorWithColorHexCode:@"#212121"] //黑

#define NormalColor_1  [UIColor yy_colorWithColorHexCode:@"#7f7f7f"]  //灰
#define NormalColor_2  [UIColor yy_colorWithColorHexCode:@"#eff1f4"]  //分割线色，控件描边

#define LightColor_1   [UIColor yy_colorWithColorHexCode:@"#ffffff"]  //内容区域底色
#define LightColor_2   [UIColor yy_colorWithColorHexCode:@"#f7f8f9"]  //分割模块底色
#define kNavigationBarColor [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:253.f/255.f alpha:1.f];

//弱引用
#define WS(weakSelf)  __weak __typeof(self)weakSelf = self;

//导航栏需要隐藏
#define NavigationBarNeedHideAnimation [self.navigationController setNavigationBarHidden:YES animated:YES]
#define NavigationBarNeedHide [self.navigationController setNavigationBarHidden:YES animated:NO]
#define NavigationBarNeedShow [self.navigationController setNavigationBarHidden:NO]

#pragma mark resource Control
//Web图片加载
extern UIImage *ImageWithURL(NSString *imageURL);
//bundle图片加载
extern UIImage* Image(NSString* imageName);
//bundle文件加载
extern NSString* FilePath(NSString* fileName);
//获取资源全路径
NSString* ResourcePath(NSString* fileName);

NSString *stringConvertToTitleText(NSString *str);
//日期转换
NSString *transformDateStr(NSString *dateStr);

//指定日期的前一天
NSString *getPreviousDate(NSString *currentDateStr);

//获取星期几
NSString *weekdayStringFromDate(NSDate *inputDate);

//坐标转换
float    CurrentDevce();
float  AdjustF(float X);
CGRect AdjustRect(float X,float Y,float W,float H);

//UITable消除线
void     setExtraCellLineHidden(UITableView *tableView);

UIColor *RGBColor(float R,float G,float B,float A);

UIFont * FontOfSize(CGFloat fontSize);
UIFont * BoldFontOfSize(CGFloat fontSize);

float sizeForDevices(float f1,float f2, float f3, float f4);
UIFont * FontOfSizeForDevices(CGFloat font1,CGFloat font2,CGFloat font3,CGFloat font4);
UIFont * BoldFontOfSizeForDevices(CGFloat font1,CGFloat font2,CGFloat font3,CGFloat font4);

float GetTextHight(UIFont *font, NSString* text, CGFloat width);
float GetTextWidth(UIFont *font, NSString* text);
