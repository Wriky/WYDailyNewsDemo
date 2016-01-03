//
//  YYDateCell.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/29.
//  Copyright © 2015年 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYDateCell : UITableViewCell

@property (nonatomic, strong)UIImageView *bgImgView;
@property (nonatomic, strong)UILabel *dateLabel;

@property (nonatomic, copy)NSString *dateStr;

@end
