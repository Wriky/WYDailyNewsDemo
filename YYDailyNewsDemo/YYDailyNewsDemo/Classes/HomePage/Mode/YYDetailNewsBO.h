//
//  YYDetailNewsBO.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/29.
//  Copyright © 2015年 L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYDetailNewsBO : NSObject

@property (nonatomic, copy) NSString *newsBody; //消息体
@property (nonatomic, copy) NSString *imageSource;
@property (nonatomic, copy) NSString *newsTitle;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *js;
@property (nonatomic, copy) NSArray *recommenders;
@property (nonatomic, copy) NSString *gaPrefix;
@property (nonatomic, copy) NSString *newsType;
@property (nonatomic, copy) NSString *newsId;
@property (nonatomic, copy) NSArray *cssType;

@end
