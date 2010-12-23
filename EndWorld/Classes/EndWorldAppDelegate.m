//--------------------------------------------------------------------------
//  EndWorldAppDelegate.m
//
//  (c) StasH, 2010
//--------------------------------------------------------------------------


#import "EndWorldAppDelegate.h"


@implementation EndWorldAppDelegate


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
