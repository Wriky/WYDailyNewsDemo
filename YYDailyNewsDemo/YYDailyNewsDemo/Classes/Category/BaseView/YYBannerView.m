//
//  YYBannerView.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/29.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYBannerView.h"
#import "UIImageView+YYImg.h"

@implementation YYBannerView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        
        UILabel *lab = [[UILabel alloc] init];
        lab.numberOfLines = 0;
        [self addSubview:lab];
        _titleLab = lab;

        
        [self configTapGes];
    }
    return self;
}


#pragma mark - 添加手势
- (void)configTapGes{

    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tapGes];
    
}

#pragma mark - User Action
- (void)tapAction{

    _clickBannerCallBackBlock(_bannerNewsBO);

}

#pragma mark - Setter


- (void)setBannerNewsBO:(YYSingleNewsBO *)bannerNewsBO{
    
    _bannerNewsBO = bannerNewsBO;
   
        [self yy_setImageWithUrlString:bannerNewsBO.imageUrl placeholderImage:Image(@"tags_selected.png")];
        NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:bannerNewsBO.newsTitle attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:21],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        CGSize size =  [attStr boundingRectWithSize:CGSizeMake(kScreenWidth-30, AdjustF(200.f)) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
        _titleLab.frame = CGRectMake(15, 0, kScreenWidth-30, size.height);
        [_titleLab setBottom:AdjustF(180.f)];
        _titleLab.attributedText = attStr;
    
}

@end
