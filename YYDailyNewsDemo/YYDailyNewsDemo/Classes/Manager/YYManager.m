//
//  YYManager.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYManager.h"
#import "YYHttpMgr.h"
#import "MJExtension.h"

YYReturnCode const YYReturnCodeSuccess = @"9001";
YYReturnCode const YYReturnCodeError = @"9999";

@implementation YYManager

+ (void)yy_baseReqWithMethod:(NSString *)method
                      urlStr:(NSString *)urlStr
                      params:(NSDictionary *)params
                     success:(yy_reqSuccessBlock)success
                     failure:(yy_reqFailureBlock)failure{
    
    if ([method isEqualToString:YYRequestGET]) {
        NSString *baseUrl = IP_HEADER;
        
        [YYHttpMgr getReqWithBaseUrlStr:baseUrl urlStr:urlStr params:nil success:^(id json) {
            if (success) {
                success(json);
            }
        } failure:^(NSError *error) {
            
            YYError *err = [YYError errorWithErrorCode:YYReturnCodeError errMsg:nil];
            if (failure) {
                
                failure(err);
            }
            
        }];
    }
    
    if ([method isEqualToString:YYRequestPOST]) {
        
        NSString *baseUrl = IP_HEADER;
        
        [YYHttpMgr postReqWithBaseUrlStr:baseUrl urlStr:urlStr params:params success:^(id json) {
            if (success) {
                success(json);
            }
        } failure:^(NSError *error) {
            
            YYError *err = [YYError errorWithErrorCode:YYReturnCodeError errMsg:nil];
            if (failure) {
                
                failure(err);
            }
            
        }];
        
    }
    
}

#pragma mark 调用api的公用方法
+ (void)yy_reqWithMethod:(NSString *)method
                  urlStr:(NSString *)urlStr
                  params:(NSDictionary *)params
                   class:(Class )cls
                 success:(yy_reqSuccessBlock)success
                 failure:(yy_reqFailureBlock)failure{
    
    [self yy_baseReqWithMethod:method urlStr:urlStr params:params success:^(id data) {
        if (cls == nil) {
            success(data);
        }else{
            success([cls mj_objectWithKeyValues:data]);
        }

        
    } failure:failure];
}

@end

#pragma mark - 失败错误模型
@implementation YYError

- (NSString *)errMsgWithCode:(YYReturnCode)code {
    NSDictionary *errMsgDict = @{
                                 @"9001" : @"操作成功",                               
                                 @"9999" : @"未能连接到服务器，请稍后再试^_^",
                                
                                 };
    return errMsgDict[code];
}

- (instancetype)initWithErrorCode:(YYReturnCode)code {
    
    return [self initWithErrorCode:code errMsg:nil];
}

- (instancetype)initWithErrorCode:(YYReturnCode)code
                           errMsg:(NSString *)errMsg {
    self = [super init];
    if (self) {
        _code = code;
        _errMsg  = errMsg.length ? errMsg : [self errMsgWithCode:code];
    }
    return self;
}

+ (instancetype)errorWithErrorCode:(YYReturnCode)code
                            errMsg:(NSString *)errMsg {
    
    return [[self alloc] initWithErrorCode:code errMsg:errMsg];
}

@end
