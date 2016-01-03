//
//  XPWebViewController.h
//  Test
//
//  Created by xiupintech on 15/7/28.
//  Copyright (c) 2015年 L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface XPWebViewController : UIViewController<UIWebViewDelegate, NJKWebViewProgressDelegate>

/**
 *  初始化
 *
 *  @param reqUrlString 请求的url的string
 *
 *  @return id
 */
- (id)initWithReqUrl:(NSString *)reqUrlString;

@end
