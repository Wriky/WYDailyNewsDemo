//
//  XPWebViewController.m
//  Test
//
//  Created by xiupintech on 15/7/28.
//  Copyright (c) 2015年 L. All rights reserved.
//

#import "XPWebViewController.h"

@interface XPWebViewController ()<UIWebViewDelegate>
{
   UIWebView *_webView;
   NJKWebViewProgressView *_progressView;
   NJKWebViewProgress *_progressProxy;
   NSString *_reqString;
}
@end

@implementation XPWebViewController

- (id)initWithReqUrl:(NSString *)reqUrlString{
    
    if (self = [super init]) {
    
        _reqString = [reqUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
 
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithIconName:@"Public/nav_but_back_n.png" highlightedIconName:@"Public/nav_but_back_s.png" target:self action:@selector(goBackPreVC)];
    
    self.navBarTitle = @"加载中...";
    
    
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
   
   
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, progressBarHeight)];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:_progressView];
    
    
    
    NSURLRequest *req;
    if ([_reqString hasPrefix:@"http"]) {
         req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_reqString]];
    }else if([_reqString hasPrefix:@"https"]){
         req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_reqString]];
    }else{//暂时不考虑加https
        NSString *newReq = [NSString stringWithFormat:@"http://%@",_reqString];
        req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:newReq]];
    }
    
    [_webView loadRequest:req];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    DLog(@"error == %@",error);
   
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.navBarTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
    
    [_progressView setProgress:progress animated:YES];
}


#pragma mark - NavBar action
- (void)goBackPreVC{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
