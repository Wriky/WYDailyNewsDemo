//
//  YYLatestNewsBO.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYLatestNewsBO.h"


@implementation YYLatestNewsBO

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"date":@"date",
             @"storiesArray":@"stories",
             @"topStoriesArray":@"top_stories",
             };
}

+ (NSDictionary *)objectClassInArray{
    
    return @{
             @"storiesArray":[YYSingleNewsBO class],
             @"topStoriesArray":[YYSingleNewsBO class],
             };
}

@end
