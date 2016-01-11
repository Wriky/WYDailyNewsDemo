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

@property (nonatomic, copy)NSString *beforeDateStr;

@end

@implementation YYHomeViewModel

#pragma mark - Data
- (void)requestLatestNews:(ReqComplement)reqComplement{
    _isLoading = YES;
    [YYManager yy_getMainViewNewsWithField:@"latest" Success:^(YYLatestNewsBO *newsBO) {

        _latestNewsBO = newsBO;
        _topScrollArr = newsBO.topStoriesArray;
        _daysDataList = [[NSMutableArray alloc] init];
        [_daysDataList addObject:newsBO];
        _beforeDateStr = newsBO.date;
        _isLoading = NO;
        reqComplement();
    } Failure:^(YYError *error) {
    }];
}

- (void)requestPreviousNews:(ReqComplement)reqComplement{
     _isLoading = YES;
    [YYManager yy_getPreviousNewsWithDate:_beforeDateStr Success:^(YYLatestNewsBO *newsBO) {
        [_daysDataList addObject:newsBO];
        
        _beforeDateStr = newsBO.date;
        _isLoading = NO;
        reqComplement();
    } Failure:^(YYError *error) {
        
    }];
}

#pragma mark - calculate
- (NSUInteger)numberOfSections{
   return  _daysDataList.count;
}

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section{
    
    YYLatestNewsBO *newsBO = _daysDataList[section];
    return newsBO.storiesArray.count;
}

- (NSString *)titleForSection:(NSInteger)section{
    YYLatestNewsBO *newsBO = _daysDataList[section];
    return transformDateStr(newsBO.date);
}

- (YYSingleNewsBO *)newsAtIndexPath:(NSIndexPath *)indexPath{
    YYLatestNewsBO *newsBO = _daysDataList[indexPath.section];
    YYSingleNewsBO *singleBO = newsBO.storiesArray[indexPath.row];
    return singleBO;
}



@end
