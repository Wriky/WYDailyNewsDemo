//
//  YYHomeViewController.h
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYHomeViewModel.h"

@interface YYHomeViewController : UIViewController

@property (nonatomic, strong)UIView *fakeNavBar;//假的导航

- (instancetype)initWithModel:(YYHomeViewModel *)hvModel;

@end
