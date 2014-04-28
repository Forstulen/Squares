//
//  SquareAppDelegate.m
//  Squares
//
//  Created by Romain on 4/4/14.
//
//

#import "SquareAppDelegate.h"
#import "SquareScoreManager.h"
#import "SquareMenuViewController.h"
#import "defines.h"


@implementation SquareAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.mainViewController = [[SquareMenuViewController alloc] initWithNibName:NSStringFromClass([SquareMenuViewController class]) bundle:nil];
    
    
    UINavigationController  *navController = [[UINavigationController alloc] initWithRootViewController:self.mainViewController];

    [navController setNavigationBarHidden:YES];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SQUARE_PAUSE object:nil userInfo:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[SquareScoreManager sharedSquareScoreManager] saveBestScore];
}

@end
