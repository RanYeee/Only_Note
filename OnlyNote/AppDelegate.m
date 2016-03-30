//
//  AppDelegate.m
//  OnlyNote
//
//  Created by IMac on 16/3/11.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MainTabbarController.h"
#import "RNNavigationController.h"
#import "RootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Bmob registerWithAppKey:@"a8fae748496362a9069f536d084750d6"];

    [self changeNav];
    
    BmobUser *user = [BmobUser getCurrentUser];
    
    if (!user) {
        
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        
        RNNavigationController *nav = [[RNNavigationController alloc]initWithRootViewController:loginVC];

        nav.navigationBar.hidden = YES;
        
        self.window.rootViewController = nav;
        
        [self.window makeKeyAndVisible];
        
    }else{
//
        
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//        
//        self.window.rootViewController = [sb instantiateViewControllerWithIdentifier:@"MainTabBarID"];
        
        RootViewController *rootVC = [[RootViewController alloc]init];
        
        self.window.rootViewController = rootVC;
        
        [self.window makeKeyAndVisible];
        
    }
    
    return YES;
    
}
- (void)changeNav
{
    //设置NavigationBar背景颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.2627 green:0.3098 blue:0.3647 alpha:1.0]];
    //@{}代表Dictionary
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //不设置这个无法修改状态栏字体颜色
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
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
