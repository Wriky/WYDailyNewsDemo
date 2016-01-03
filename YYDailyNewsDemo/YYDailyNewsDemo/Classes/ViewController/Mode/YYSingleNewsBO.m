//
//  YYSingleNewsBO.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYSingleNewsBO.h"

@implementation YYSingleNewsBO

+(NSDictionary *)replacedKeyFromPropertyName{
    
    return @{
             
             @"imagesUrl":@"images",
             @"newsType":@"type",
             @"newsId":@"id",
             @"ga_prefix":@"ga_prefix",
             @"newsTitle":@"title"
             
             };
}

@end
