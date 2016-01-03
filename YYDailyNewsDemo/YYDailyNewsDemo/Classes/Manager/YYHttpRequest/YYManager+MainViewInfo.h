//
//  YYManager+MainViewInfo.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYManager.h"
#include "YYSingleNewsBO.h"
#import "YYLatestNewsBO.h"
#import "YYDetailNewsBO.h"


typedef void(^GetMainViewInfoSuccessBlock)(YYLatestNewsBO *);
typedef void(^GetNewsDetailSuccessBlock)(YYDetailNewsBO *);

@interface YYManager (MainViewInfo)

+ (void)yy_getMainViewNewsWithField:(NSString *)fieldTxt
                            success:(GetMainViewInfoSuccessBlock)success
                            failure:(yy_reqFailureBlock)failure;

+ (void)yy_getNewsDetailWithID:(NSString *)newsId
                      success:(GetNewsDetailSuccessBlock)success
                      failure:(yy_reqFailureBlock)failure;

+ (void)yy_getPreviousNewsWithDate:(NSString *)dateStr
                           success:(GetMainViewInfoSuccessBlock)success
                           failure:(yy_reqFailureBlock)failure;

@end
