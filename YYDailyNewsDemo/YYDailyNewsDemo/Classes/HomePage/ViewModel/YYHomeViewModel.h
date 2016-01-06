//
//  YYHomeViewModel.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 16/1/5.
//  Copyright © 2016年 L. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYLatestNewsBO.h"

typedef void(^ReqComplement)();

@interface YYHomeViewModel : NSObject

@property (nonatomic, readonly, strong)YYLatestNewsBO *latestNewsBO;
@property (nonatomic, readonly, strong)NSMutableArray *daysDataList;
@property (nonatomic, readonly, copy)NSArray *topScrollArr;

@property (nonatomic, readonly, strong)NSMutableArray *newsIDArray;
@property (nonatomic, readonly, assign)BOOL isLoading;
@property (nonatomic, copy)NSString *beforeDateStr;

- (void)requestLatestNews:(ReqComplement)reqComplement;

- (void)requestPreviousNews:(ReqComplement)reqComplement;

@end
