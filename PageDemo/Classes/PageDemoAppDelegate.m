//--------------------------------------------------------------------------
//  PageDemoAppDelegate.m
//
//  (c) StasH, 2010
//--------------------------------------------------------------------------


#import "PageDemoAppDelegate.h"


@implementation PageDemoAppDelegate


- (void) applicationDidFinishLaunching: (UIApplication *) application
{    
    
    [window makeKeyAndVisible];
}


- (void)dealloc 
{

    [window release];
    [super dealloc];
}


@end
