//--------------------------------------------------------------------------
//  TableDemoAppDelegate.m
//
//  (c) StasH, 2011
//--------------------------------------------------------------------------


#import "TableDemoAppDelegate.h"
#import "TableDemoViewController.h"


@implementation TableDemoAppDelegate


- (void) applicationDidFinishLaunching: (UIApplication *) application
{    
    // Скрываем строку состояния
    [[UIApplication sharedApplication] setStatusBarHidden: YES];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    window = [[UIWindow alloc] initWithFrame: screenBounds];
    
    viewController = [[TableDemoViewController alloc] init];
    
    navigationController = [[UINavigationController alloc] initWithRootViewController: viewController];
    
    [window addSubview: [navigationController view]];
    [window makeKeyAndVisible];
}


- (void)dealloc 
{
    [viewController release];
    [window release];
    [super dealloc];
}


@end
