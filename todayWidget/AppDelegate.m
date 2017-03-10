//
//  AppDelegate.m
//  todayWidget
//
//  Created by StarHui on 2017/3/1.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "STLsitViewController.h"

@interface AppDelegate ()
@property (strong, nonatomic) UIViewController *rootViewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupRootViewController];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 9.0 以后
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options {
    return [self p_parseApplication:app openURL:url sourceApplication:nil annotation:nil];
}

// 9.0 以前
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self p_parseApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (BOOL)p_parseApplication:(UIApplication *)application
                   openURL:(NSURL *)url
         sourceApplication:(NSString *)sourceApplication
                annotation:(id)annotation {
    NSString *urlString = [url absoluteString];
    if ([urlString isEqualToString:@"STTodayWidget://GOTOEventListVC"]) {
        STLsitViewController *eventListVC = [STLsitViewController instance];
        [self.rootViewController.navigationController pushViewController:eventListVC animated:YES];
    }
    return YES;
}

-(void)setupRootViewController{

    self.window                 = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *vc          = [ViewController instance];
    UIViewController *rootVc    = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = rootVc;
    [self.window makeKeyAndVisible];
    self.rootViewController = vc;

}

@end
