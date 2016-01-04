//
//  YYLatestNewsBO.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYSingleNewsBO.h"

@interface YYLatestNewsBO : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, strong) NSMutableArray *storiesArray;
@property (nonatomic, strong) NSMutableArray *topStoriesArray;




@end
