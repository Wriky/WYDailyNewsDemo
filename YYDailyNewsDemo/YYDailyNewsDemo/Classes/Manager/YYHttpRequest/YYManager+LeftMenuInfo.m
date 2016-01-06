//
//  YYManager+LeftMenuInfo.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 16/1/6.
//  Copyright © 2016年 L. All rights reserved.
//

#import "YYManager+LeftMenuInfo.h"

@implementation YYManager (LeftMenuInfo)

+ (void)yy_getThemeListWithField:(NSString *)fieldTxt
                       Success:(yy_reqSuccessBlock)success
                       Failure:(yy_reqFailureBlock)failure{
    [YYManager yy_reqWithMethod:YYRequestGET urlStr:fieldTxt params:nil class:nil success:^(id data) {
        
        success(data);
    } failure:^(YYError *error) {
        failure(error);
    }];
}

@end
