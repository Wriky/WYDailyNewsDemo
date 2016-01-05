//
//  YYSingleNewsBO.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYSingleNewsBO : NSObject

@property (nonatomic, copy) NSArray *imagesUrl; //新闻列表
@property (nonatomic, copy) NSString *imageUrl; //轮播图
@property (nonatomic, copy) NSString *newsType;
@property (nonatomic, copy) NSString *newsId;
@property (nonatomic, copy) NSString *ga_prefix;
@property (nonatomic, copy) NSString *newsTitle;


@end
