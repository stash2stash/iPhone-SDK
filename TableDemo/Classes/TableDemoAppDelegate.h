//--------------------------------------------------------------------------
//  TableDemoAppDelegate.h
//
//  (c) StasH, 2011
//--------------------------------------------------------------------------

#import <UIKit/UIKit.h>


@class TableDemoViewController;


@interface TableDemoAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
    TableDemoViewController *viewController;
    UINavigationController *navigationController;
}


@end

