//
//  YYDateCell.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/29.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYDateCell.h"

@implementation YYDateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // cell不可以选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
        
    }
    return self;
}

- (void)configUI{

   
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40.f)];
    _bgImgView.image = Image(@"navBar");
    _bgImgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_bgImgView];
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth/2-100.f, 8.f, 200.f, 24.f)];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel.textColor = [UIColor whiteColor];
    _dateLabel.font = FontOfSize(15.f);
    [self addSubview:_dateLabel];
}

- (void)setDateStr:(NSString *)dateStr{
    
    _dateLabel.text = transformDateStr(dateStr);
}


@end
