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

    _clickBannerCallBackBlock(_banner);

}

#pragma mark - Setter
- (void)setBanner:(XPBannerInfo *)banner {
    
    _banner = banner;
    if ([banner.bannerImage hasPrefix:@"Sao/shopDefault"]){
        self.image = Image(banner.bannerImage);
    }else{
        [self yy_setImageWithUrlString:banner.bannerImage placeholderImage:Image(@"tags_selected.png")];
    }
}

@end
