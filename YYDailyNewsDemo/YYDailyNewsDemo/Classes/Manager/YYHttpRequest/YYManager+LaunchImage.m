//
//  YYManager+LaunchImage.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 16/1/5.
//  Copyright © 2016年 L. All rights reserved.
//

#import "YYManager+LaunchImage.h"

@implementation YYManager (LaunchImage)

+ (void)yy_getLaunchImageWithSize:(NSString *)size
                          Success:(yy_reqSuccessBlock)success
                          Failure:(yy_reqFailureBlock)failure{
    NSString *appendStr = [NSString stringWithFormat:@"start-image/%@",size];
    [YYManager yy_reqWithMethod:YYRequestGET urlStr:appendStr params:nil class:nil success:^(id data) {
        
        success(data);
    } failure:^(YYError *error) {
        failure(error);
    }];

}

@end
