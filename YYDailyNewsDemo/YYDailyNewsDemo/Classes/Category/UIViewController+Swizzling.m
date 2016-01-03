//
//  UIViewController+Swizzling.m
//  SeekClient_
//
//  Created by xiupintech on 15/7/22.
//  Copyright (c) 2015年 xiupintech. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import <objc/runtime.h>


@implementation UIViewController (Swizzling)

static char kNavBarTitleKey;
static char kNavBarViewKey;

@dynamic navBarView;
@dynamic navBarTitle;

static void swizzInstance(Class class, SEL originalSelector, SEL swizzledSelector){
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod){
        
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
    }
    else{
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)swizz_log:(BOOL)log{
    
    if (!log){
        
        return;
    }
    
    swizzInstance([self class],@selector(viewDidAppear:),@selector(swizzviewDidAppear:));
}



- (void)swizzviewDidAppear:(BOOL)animated{

    [self swizzviewDidAppear:animated];
    DLog(@"%@",[self.class description]);
}

#pragma mark - Setter
- (void)setNavBarTitle:(NSString *)navBarTitle{
    
    objc_setAssociatedObject(self, &kNavBarTitleKey, navBarTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);

    UILabel *titlelbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    titlelbl.backgroundColor = [UIColor clearColor];
    titlelbl.textAlignment = NSTextAlignmentCenter;
    titlelbl.font = FontOfSize(17);
    titlelbl.textColor = LightColor_1;
    titlelbl.text = navBarTitle;
    self.navigationItem.titleView = titlelbl;
}


- (void)setNavBarView:(UIView *)navBarView{
   
    objc_setAssociatedObject(self, &kNavBarViewKey, navBarView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.navigationItem.titleView = navBarView;
   
}

#pragma mark - Getter
- (NSString *)navBarTitle {
    
    return objc_getAssociatedObject(self, &kNavBarTitleKey);
}

- (UIView *)navBarView{

    return objc_getAssociatedObject(self, &kNavBarViewKey);

}

@end
