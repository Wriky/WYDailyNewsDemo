//
//  YYDetailNewsBO.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/29.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYDetailNewsBO.h"

@implementation YYDetailNewsBO

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"newsBody":@"body",
             @"imageSource":@"image_source",
             @"newsTitle":@"title",
             @"imageUrl":@"image",
             @"shareUrl":@"share_url",
             @"js":@"js",
             @"gaPrefix":@"ga_prefix",
             @"newsType":@"type",
             @"newsId":@"id",
             @"cssType":@"css",
             };
}

@end
