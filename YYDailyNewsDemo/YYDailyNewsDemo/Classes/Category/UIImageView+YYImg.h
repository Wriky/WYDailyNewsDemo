//
//  UIImageView+YYImg.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^YYWebImageCompletionWithFinishedBlock)(UIImage *image);

@interface UIImageView (YYImg)

- (void)yy_setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeHolderImage;


@end
