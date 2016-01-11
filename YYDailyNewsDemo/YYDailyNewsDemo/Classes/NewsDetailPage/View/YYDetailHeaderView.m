//
//  YYDetailHeaderView.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 16/1/11.
//  Copyright © 2016年 L. All rights reserved.
//

#import "YYDetailHeaderView.h"


@implementation YYDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 300.f)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_imageView];
    
    _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLab.numberOfLines = 0;
    [self addSubview:_titleLab];
    
    _imgSourceLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 240, kScreenWidth-20, 20)];
    _imgSourceLab.textAlignment = NSTextAlignmentRight;
    _imgSourceLab.font = [UIFont systemFontOfSize:12];
    _imgSourceLab.textColor = [UIColor whiteColor];
    [self addSubview:_imgSourceLab];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (event.type == UIEventTypeTouches) {
        
        NSSet *touches = [event touchesForView:self];
        UITouch *touch = [touches anyObject];
        
        if (touch.phase == UITouchPhaseBegan) {
            
            for (UIView *subView in self.superview.subviews) {
                if ([subView isKindOfClass:[UIWebView class]]) {
                    UIWebView *webView = (UIWebView *)subView;
                    [self addGestureRecognizer:webView.scrollView.panGestureRecognizer];
                }
            }
        }
    }
    return [super hitTest:point withEvent:event];
}

@end
