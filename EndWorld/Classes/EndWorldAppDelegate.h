//--------------------------------------------------------------------------
//  EndWorldAppDelegate.h
//
//  (c) StasH, 2010
//--------------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import "RootViewController.h"


@interface EndWorldAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
    RootViewController *viewController;
    UINavigationController *navigationController;
}

@end

