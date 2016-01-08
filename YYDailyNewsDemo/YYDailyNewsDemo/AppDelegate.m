//
//  AppDelegate.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

#import "AppDelegate.h"
#import "YYHomeViewController.h"
#import "YYHomeViewModel.h"
#import "YYManager+LaunchImage.h"

@interface AppDelegate ()

@property (nonatomic, strong)UIImageView *firstLaunchView;
@property (nonatomic, strong)UIImageView *secondLaunchView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[UINavigationBar appearance] setBackgroundImage:Image(@"navBar") forBarMetrics:UIBarMetricsDefault];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    YYHomeViewController *homeVC = [[YYHomeViewController alloc] initWithModel:[YYHomeViewModel new]];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    YYLeftMenuViewController *leftMenuVC = [[YYLeftMenuViewController alloc] init];
    
    _overallVC = [[YYOverallViewController alloc] initWithLeftCtrl:leftMenuVC MainCtrl:homeNav];
    
   
    self.window.rootViewController = _overallVC;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setLaunchView];
    return YES;
}

- (void)setLaunchView{
    
    _secondLaunchView = [[UIImageView alloc] initWithFrame:kScreenBounds];
    _secondLaunchView.contentMode = UIViewContentModeScaleAspectFill;
    [self.window addSubview:_secondLaunchView];
    
    _firstLaunchView = [[UIImageView alloc] initWithFrame:kScreenBounds];
    _firstLaunchView.contentMode = UIViewContentModeScaleAspectFill;
    _firstLaunchView.image = Image(@"Default");
    [self.window addSubview:_firstLaunchView];
    
    [YYManager yy_getLaunchImageWithSize:@"720*1184" Success:^(id data) {
        [_secondLaunchView yy_setImageWithUrlString:data[@"img"] placeholderImage:nil];
        [UIView animateWithDuration:2.f animations:^{
            _firstLaunchView.alpha = 0.f;
            _secondLaunchView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
        } completion:^(BOOL finished) {
            [_firstLaunchView removeFromSuperview];
            [_secondLaunchView removeFromSuperview];
        }];
    } Failure:^(YYError *error) {
        [_firstLaunchView removeFromSuperview];
        [_secondLaunchView removeFromSuperview];
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
