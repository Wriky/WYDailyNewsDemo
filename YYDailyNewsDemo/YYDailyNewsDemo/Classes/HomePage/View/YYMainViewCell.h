//
//  YYMainViewCell.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYSingleNewsBO.h"

@interface YYMainViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *newsImageView;

@property (nonatomic, strong) UILabel     *newsTitleLbl;


@property (nonatomic, strong) YYSingleNewsBO *singleNewsBO;

@end
