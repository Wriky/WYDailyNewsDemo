//
//  YYManager+MainViewInfo.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYManager.h"
#import "YYSingleNewsBO.h"
#import "YYLatestNewsBO.h"
#import "YYDetailNewsBO.h"


typedef void(^GetMainViewInfoSuccessBlock)(YYLatestNewsBO *);
typedef void(^GetNewsDetailSuccessBlock)(YYDetailNewsBO *);

@interface YYManager (MainViewInfo)


+ (void)yy_getMainViewNewsWithField:(NSString *)fieldTxt
                            Success:(GetMainViewInfoSuccessBlock)success
                            Failure:(yy_reqFailureBlock)failure;

+ (void)yy_getNewsDetailWithID:(NSString *)newsId
                      Success:(GetNewsDetailSuccessBlock)success
                      Failure:(yy_reqFailureBlock)failure;

+ (void)yy_getPreviousNewsWithDate:(NSString *)dateStr
                           Success:(GetMainViewInfoSuccessBlock)success
                           Failure:(yy_reqFailureBlock)failure;

@end
