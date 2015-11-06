//
//  AppDelegate.m
//  ForU
//
//  Created by 胡礼节 on 15/8/29.
//  Copyright (c) 2015年 胡礼节. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "HomeViewController.h"
#import "ViewController.h"
#import "UIViewController+MLTransition.h"

#import <SMS_SDK/SMS_SDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [UIViewController validatePanPackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypePan];
    

    //youmeng key 55fa5ffce0f55a4fd4001e9a
    [SMS_SDK registerApp:@"aed4c777ad38" withSecret:@"a96c48276b41e70e9527a5ed7fdca687"];
    
    
    
    [UMSocialData setAppKey:@"55fa5ffce0f55a4fd4001e9a"];
    [UMSocialQQHandler setQQWithAppId:@"1104900454" appKey:@"N2At4puR9sD1KIuB" url:@"http://www.umeng.com/social"];
    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
   
    UIColor*bgColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"ForUyingdaoye.jpg"]];
     self.window.backgroundColor = bgColor;
    ViewController *vc=[[ViewController alloc]init];
    self.nv = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController=self.nv;
    [self.window makeKeyAndVisible];
    
    [NSThread sleepForTimeInterval:3.0];
    
    self.FLagData = TRUE;
    
    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
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
