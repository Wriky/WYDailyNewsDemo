//
//  UIImageView+YYImg.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import "UIImageView+YYImg.h"
#import <SDWebImage/UIView+WebCacheOperation.h>

@implementation UIImageView (YYImg)

- (void)yy_setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeHolderImage{
    
    [self yy_setImageWithUrlString:urlString placeholderImage:placeHolderImage completed:nil];
    
    
}
- (void)yy_setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeHolderImage completed:(YYWebImageCompletionWithFinishedBlock)completedBlock{
    
    [self sd_cancelCurrentImageLoad];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    SDWebImageManager *imageMgr = [SDWebImageManager sharedManager];
    // 检查磁盘缓存
    NSString *storeKey = [imageMgr cacheKeyForURL:url];
    __block UIImage *roundImage = [imageMgr.imageCache imageFromDiskCacheForKey:storeKey];
    
    if (roundImage) { // 缓存有图片
        self.image = roundImage;
        if (completedBlock != nil) {
            completedBlock(roundImage);
            
        }
    } else { // 缓存没图片
        self.image = placeHolderImage;
        // 开始下载
        if (url) {
            __weak typeof(self) wself = self;
            id <SDWebImageOperation> operation = [imageMgr downloadImageWithURL:url options:SDWebImageRetryFailed | SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                // 下载中
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if (!wself) return;
                dispatch_main_sync_safe(^{
                    if (!wself) return;
                    if (image) {
                        // 下载成功
                        // 在这里处理image
                        
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            
                            roundImage = image;
                            
                            dispatch_main_sync_safe(^{
                                
                                if (completedBlock != nil) {
                                    completedBlock(image);
                                    
                                }
                                
                                [UIView transitionWithView:self duration:1. options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAllowUserInteraction animations:^{
                                    wself.image = roundImage;
                                } completion:^(BOOL finished) {
                                    [wself setNeedsLayout];
                                }];
                            });
                        });
                        
                    } else {
                        // 下载失败
                        wself.image = placeHolderImage;
                        [wself setNeedsLayout];
                    }
                });
            }];
            [self sd_setImageLoadOperation:operation forKey:@"UIImageViewImageLoad"];
        }
    }
    
    
}


@end
