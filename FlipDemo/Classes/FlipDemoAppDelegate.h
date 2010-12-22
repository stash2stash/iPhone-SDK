//--------------------------------------------------------------------------
//  FlipDemoAppDelegate.h
//
//  (c) StasH, 2010
//--------------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import "RootViewController.h"


@interface FlipDemoAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
    RootViewController *viewController;
    UINavigationController *navigationController;
}

@end

