//
//  YYSectionTitleView.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 16/1/11.
//  Copyright © 2016年 L. All rights reserved.
//

#import "YYSectionTitleView.h"

@implementation YYSectionTitleView


- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.backgroundColor = StandardColor_1;
    self.textLabel.centerX = self.width/2;
    self.textLabel.textColor = [UIColor whiteColor];
}

@end
