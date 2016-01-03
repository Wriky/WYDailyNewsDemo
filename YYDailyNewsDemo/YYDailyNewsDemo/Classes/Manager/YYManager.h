//
//  YYManager.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YYError;
typedef void(^yy_reqSuccessBlock)(id data);
typedef void(^yy_reqFailureBlock)(YYError *error);

/**
 *  接口调用返回码
 */
typedef NSString * YYReturnCode;

/**
 *  操作成功
 */
extern YYReturnCode const YYReturnCodeSuccess;//9001
/**
 *  查询失败 操作失败
 */
extern YYReturnCode const YYReturnCodeError;//9999


@interface YYManager : NSObject

/**
 *  所有的对服务器的请求均调用该方法（该方法的成功回调会返回成功后的json数据中的data字段的信息，data的类型(一般为NSDictionary、NSArray等)请参考api文档）
 *
 *  @param method  get post
 *  @param urlStr  api url
 *  @param params  参数
 *  @param cls     模型类名
 *  @param success 成功回调block
 *  @param failure 失败回调block
 */
+ (void)yy_reqWithMethod:(NSString *)method
                  urlStr:(NSString *)urlStr
                  params:(NSDictionary *)params
                   class:(Class )cls
                 success:(yy_reqSuccessBlock)success
                 failure:(yy_reqFailureBlock)failure;

/**
 *  @param method  get post
 *  @param urlStr  api url
 *  @param params  参数
 *  @param success 成功回调block
 *  @param failure 失败回调block
 */
+ (void)yy_baseReqWithMethod:(NSString *)method
                      urlStr:(NSString *)urlStr
                      params:(NSDictionary *)params
                     success:(yy_reqSuccessBlock)success
                     failure:(yy_reqFailureBlock)failure;





@end


#pragma mark - 失败错误类
@interface YYError : NSObject

/**
 *  返回错误类实例
 *
 *  @param code   错误码
 *  @param errMsg 错误描述信息
 *
 *  @return 错误类实例
 */
+ (instancetype)errorWithErrorCode:(YYReturnCode)code errMsg:(NSString *)errMsg;

@property (nonatomic, copy, readonly) YYReturnCode code; // 返回码
@property (nonatomic, copy, readonly) NSString *errMsg; // 返回码对应的错误信息

@end