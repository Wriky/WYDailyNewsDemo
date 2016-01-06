//
//  YYLoadingView.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 16/1/4.
//  Copyright © 2016年 L. All rights reserved.
//

#import "YYLoadingView.h"
#import "FLAnimatedImage.h"

@implementation YYLoadingView
{
    FLAnimatedImageView *_loadingView;
}

- (id)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = LightColor_1;
        [self configUI];
        
    }
    return self;
}


- (void)configUI{
    
    _loadingView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 44)/2, (self.frame.size.height - 44)/2, 44, 44)];
    [self addSubview:_loadingView];
    
    NSString *hdPath = [[NSBundle mainBundle] pathForResource:@"LoadingAnimation" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:hdPath];
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
    _loadingView.animatedImage = image;
    
}

#pragma mark - 外部方法
- (void)dismissLoadingView{
    
    [UIView animateWithDuration:0.6f animations:^{
        self.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)dealloc{
    
    if (_loadingView) {
        [_loadingView removeFromSuperview];
        _loadingView = nil;
    }
}

@end
