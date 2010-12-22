//--------------------------------------------------------------------------
//  FlipDemoAppDelegate.m
//
//  (c) StasH, 2010
//--------------------------------------------------------------------------


#import "FlipDemoAppDelegate.h"


@implementation FlipDemoAppDelegate


- (void) applicationDidFinishLaunching: (UIApplication *) application
{    
    window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    
    viewController = [[RootViewController alloc] init];
    
    navigationController = [[UINavigationController alloc] initWithRootViewController: viewController];
    
    [window addSubview: [navigationController view]];
    
    [window makeKeyAndVisible];
}


- (void)dealloc 
{
    [navigationController release];
    [viewController release];

    [window release];
    [super dealloc];
}


@end
