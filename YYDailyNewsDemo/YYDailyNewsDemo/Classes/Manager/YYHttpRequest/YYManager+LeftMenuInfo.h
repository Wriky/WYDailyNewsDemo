//
//  YYManager+LeftMenuInfo.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 16/1/6.
//  Copyright © 2016年 L. All rights reserved.
//

#import "YYManager.h"

@interface YYManager (LeftMenuInfo)

+ (void)yy_getThemeListWithField:(NSString *)fieldTxt
                       Success:(yy_reqSuccessBlock)success
                       Failure:(yy_reqFailureBlock)failure;


@end
