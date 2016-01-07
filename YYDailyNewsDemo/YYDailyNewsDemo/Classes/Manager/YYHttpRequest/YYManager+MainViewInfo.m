//
//  YYManager+MainViewInfo.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYManager+MainViewInfo.h"
#import "YYManager+MainViewInfo.h"

@implementation YYManager (MainViewInfo)

+ (void)yy_getMainViewNewsWithField:(NSString *)fieldTxt
                            Success:(GetMainViewInfoSuccessBlock)success
                            Failure:(yy_reqFailureBlock)failure{
  
    NSString *appendStr = [NSString stringWithFormat:@"news/%@",fieldTxt];

    [YYManager yy_reqWithMethod:YYRequestGET urlStr:appendStr params:nil class:NSClassFromString(@"YYLatestNewsBO") success:^(id data) {
        
        success(data);
    } failure:^(YYError *error) {
        failure(error);
    }];
}

+ (void)yy_getNewsDetailWithID:(NSString *)newsId
                      Success:(GetNewsDetailSuccessBlock)success
                      Failure:(yy_reqFailureBlock)failure{
    
    NSString *appendStr = [NSString stringWithFormat:@"news/%@",newsId];
    [YYManager yy_reqWithMethod:YYRequestGET urlStr:appendStr params:nil class:NSClassFromString(@"YYDetailNewsBO") success:^(id data) {

        success(data);
    } failure:^(YYError *error) {
        failure(error);
    }];

}

+ (void)yy_getPreviousNewsWithDate:(NSString *)dateStr
                           Success:(GetMainViewInfoSuccessBlock)success
                           Failure:(yy_reqFailureBlock)failure{
    NSString *appendStr = [NSString stringWithFormat:@"news/before/%@",dateStr];
    [YYManager yy_reqWithMethod:YYRequestGET urlStr:appendStr params:nil class:NSClassFromString(@"YYLatestNewsBO") success:^(id data) {
        success(data);
    } failure:^(YYError *error) {
        failure(error);
    }];
}



@end
