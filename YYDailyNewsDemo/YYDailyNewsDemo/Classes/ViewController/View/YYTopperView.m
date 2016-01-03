//
//  YYTopperView.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYTopperView.h"

@implementation YYTopperView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imaView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
        imaView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imaView];
        _imageView = imaView;
        
        UILabel *lab = [[UILabel alloc] init];
        lab.numberOfLines = 0;
        [self addSubview:lab];
        _label = lab;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
