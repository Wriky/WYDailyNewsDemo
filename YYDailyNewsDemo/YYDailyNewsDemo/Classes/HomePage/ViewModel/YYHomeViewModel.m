//
//  YYHomeViewModel.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 16/1/5.
//  Copyright © 2016年 L. All rights reserved.
//

#import "YYHomeViewModel.h"
#import "YYSingleNewsBO.h"
#import "YYLatestNewsBO.h"
#import "YYManager+MainViewInfo.h"

@interface YYHomeViewModel ()


@end

@implementation YYHomeViewModel

#pragma mark - Data
- (void)requestLatestNews:(ReqComplement)reqComplement{
    _isLoading = YES;
    [YYManager yy_getMainViewNewsWithField:@"latest" Success:^(YYLatestNewsBO *newsBO) {

        _latestNewsBO = newsBO;
        _topScrollArr = newsBO.topStoriesArray;
        _daysDataList = [[NSMutableArray alloc] init];
        [_daysDataList addObjectsFromArray:newsBO.storiesArray];
        _beforeDateStr = newsBO.date;
        _isLoading = NO;
        reqComplement();
    } Failure:^(YYError *error) {
    }];
}

- (void)requestPreviousNews:(ReqComplement)reqComplement{
    
    [YYManager yy_getPreviousNewsWithDate:_beforeDateStr Success:^(YYLatestNewsBO *newsBO) {
        [_daysDataList addObject:newsBO.date];
        [_daysDataList addObjectsFromArray:newsBO.storiesArray];
        
        _beforeDateStr = newsBO.date;
        reqComplement();
    } Failure:^(YYError *error) {
        
    }];
}


@end
