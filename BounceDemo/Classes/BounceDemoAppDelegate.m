//
//  BounceDemoAppDelegate.m
//  BounceDemo
//
//  Created by StasH on 21.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BounceDemoAppDelegate.h"
#import "BounceDemoViewController.h"

@implementation BounceDemoAppDelegate


- (void) applicationDidFinishLaunching:(UIApplication *)application
{
    CGRect screenBounds = [[UIScreen alloc] applicationFrame];
    
    window = [[UIWindow alloc] initWithFrame: screenBounds];
    
    viewController = [[BounceDemoViewController alloc] init];
    
    [window addSubview: viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc 
{
    [viewController release];
    [window release];
    [super dealloc];
}


@end
