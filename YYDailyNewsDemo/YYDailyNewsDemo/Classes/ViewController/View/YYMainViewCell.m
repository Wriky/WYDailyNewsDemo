//
//  YYMainViewCell.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import "YYMainViewCell.h"

@implementation YYMainViewCell

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
   
    _newsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth - 60.f, 10.f, 50.f, 50.f)];
    [self.contentView addSubview:_newsImageView];
    
    _newsTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 6.f, KScreenWidth-90.f, 60.f)];
    _newsTitleLbl.numberOfLines = 3;
    _newsTitleLbl.textColor = StandardColor_2;
    _newsTitleLbl.textAlignment = NSTextAlignmentLeft;
    _newsTitleLbl.font = [UIFont boldSystemFontOfSize:15];
     [self.contentView addSubview:_newsTitleLbl];
}


- (void)setSingleNewsBO:(YYSingleNewsBO *)singleNewsBO{
    [_newsImageView yy_setImageWithUrlString:singleNewsBO.imagesUrl[0] placeholderImage:Image(@"tags_selected")];
    _newsTitleLbl.text = singleNewsBO.newsTitle;
    
}

@end
