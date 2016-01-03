//
//  YYHeaderView.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYHeaderView.h"
#import "UIImage+ImageEffects.h"
#import "UIImageView+YYImg.h"

#define kDefaultHeaderFrame CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)

static CGFloat kParallaxDeltaFactor = 0.5f;

@interface YYHeaderView ()

@property (strong, nonatomic)  UIScrollView *imageScrollView;
@property (strong, nonatomic)  UIImageView *imageView;

@end

@implementation YYHeaderView


+ (id)yy_headerViewWithCGSize:(CGSize)headerSize{
    
    YYHeaderView *headerView = [[YYHeaderView alloc] initWithFrame:CGRectMake(0, 0, headerSize.width, headerSize.height)];
    [headerView initial];
    return headerView;
}


- (void)initial{
    
    _imageScrollView= [[UIScrollView alloc] initWithFrame:self.bounds];
   
    _imageView = [[UIImageView alloc] initWithFrame:_imageScrollView.bounds];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.image = nil;
    _imageView.userInteractionEnabled = YES;
    
    [_imageScrollView addSubview:_imageView];
    
    UITapGestureRecognizer *tapBackgroundGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUserBackgroundView)];
    [_imageView addGestureRecognizer:tapBackgroundGes];
    

    [self addSubview:self.imageScrollView];
}

- (void)setHeaderImage:(NSString *)headerImage{
    
    [self.imageView yy_setImageWithUrlString:headerImage placeholderImage:[UIImage imageNamed:@"backgroundImage.png"]];
   
}

- (void)tapUserBackgroundView{
    
}

#pragma mark - 外部方法
- (void)yy_parallaxHeaderViewWithOffset:(CGPoint)offset{
    
    CGRect frame = self.imageScrollView.frame;
    
    if (offset.y > 0){
        
        frame.origin.y = MAX(offset.y *kParallaxDeltaFactor, 0);
        self.imageScrollView.frame = frame;
        self.clipsToBounds = YES;
    }
    else{
        
        CGFloat delta = 0.0f;
        CGRect rect = kDefaultHeaderFrame;
        delta = fabs(MIN(0.0f, offset.y));
        rect.origin.y -= delta;
        rect.size.height += delta;
        // DLog(@"delta = %f",delta);
        self.imageScrollView.frame = rect;
        
        CGPoint newPoint = self.imageScrollView.center;
        newPoint.y += delta;
        self.clipsToBounds = NO;
        
    }
    
    
}




@end
