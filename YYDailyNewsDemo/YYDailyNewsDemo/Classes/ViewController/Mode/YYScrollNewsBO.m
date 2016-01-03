//
//  YYScrollNewsBO.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/29.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYScrollNewsBO.h"

@implementation YYScrollNewsBO

+(NSDictionary *)replacedKeyFromPropertyName{
    
    return @{
             
             @"imageUrl":@"image",
             @"newsType":@"type",
             @"newsId":@"id",
             @"ga_prefix":@"ga_prefix",
             @"newsTitle":@"title"
             
             };
}

@end
