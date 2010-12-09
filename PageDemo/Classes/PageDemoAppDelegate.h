//--------------------------------------------------------------------------
//  PageDemoAppDelegate.h
//
//  (c) StasH, 2010
//--------------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "CreditsViewController.h"


@interface PageDemoAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
    RootViewController *rootViewController;
    CreditsViewController *creditsViewController;
    UINavigationController *navigationController;
}


@end

