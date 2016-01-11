//
//  YYWebView.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 16/1/11.
//  Copyright © 2016年 L. All rights reserved.
//

#import "YYWebView.h"

@implementation YYWebView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}




- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (event.type == UIEventTypeTouches) {
        
        NSSet *touches = [event touchesForView:self];
        UITouch *touch = [touches anyObject];
        
        if (touch.phase == UITouchPhaseBegan) {
            
            [self addGestureRecognizer:self.scrollView.panGestureRecognizer];
        }
    }
    return [super hitTest:point withEvent:event];
}

@end
