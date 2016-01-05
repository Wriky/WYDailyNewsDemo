//
//  YYManager+LaunchImage.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 16/1/5.
//  Copyright © 2016年 L. All rights reserved.
//

#import "YYManager.h"

@interface YYManager (LaunchImage)

+ (void)yy_getLaunchImageWithSize:(NSString *)size
                          Success:(yy_reqSuccessBlock)success
                          Failure:(yy_reqFailureBlock)failure;

@end
