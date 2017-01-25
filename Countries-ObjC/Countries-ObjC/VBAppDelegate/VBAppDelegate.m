//
//  VBAppDelegate.m
//  Counries-ObjC
//
//  Created by Vladimir Budniy on 1/23/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBAppDelegate.h"
#import "VBCountriesViewController.h"

@interface VBAppDelegate ()

@end

@implementation VBAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    VBCountriesViewController *viewController = [VBCountriesViewController new];
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:viewController];
    UIWindow *window = [UIWindow window];
    window.rootViewController = controller;
    self.window = window;
    [window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
