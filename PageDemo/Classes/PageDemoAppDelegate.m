//--------------------------------------------------------------------------
//  PageDemoAppDelegate.m
//
//  (c) StasH, 2010
//--------------------------------------------------------------------------


#import "PageDemoAppDelegate.h"


@implementation PageDemoAppDelegate


- (void) applicationDidFinishLaunching: (UIApplication *) application
{    
    window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    
    rootViewController = [[RootViewController alloc] initWithAppDelegate: self];
    creditsViewController = [[CreditsViewController alloc] initWithAppDelegate: self];
    
    navigationController = [[UINavigationController alloc] initWithRootViewController: rootViewController];
    
    [window addSubview: [navigationController view]];
    
    [window makeKeyAndVisible];
}


- (void)dealloc 
{
    [navigationController release];
    [rootViewController release];
    [creditsViewController release];

    [window release];
    [super dealloc];
}


-(void) credits
{
    [navigationController pushViewController: creditsViewController animated: YES];
}


-(void) back
{
    [navigationController popViewControllerAnimated: YES];
}


@end
