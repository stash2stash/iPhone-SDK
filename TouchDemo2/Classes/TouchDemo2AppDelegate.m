//
//  TouchDemo2AppDelegate.m
//  TouchDemo2
//
//  Created by StasH on 20.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TouchDemo2AppDelegate.h"
#import "TouchDemo2ViewController.h"

@implementation TouchDemo2AppDelegate

- (void) applicationDidFinishLaunching:(UIApplication *)application
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    window = [[UIWindow alloc] initWithFrame: screenBounds];
    
    viewController = [[TouchDemo2ViewController alloc] init];
    
    [window addSubview: viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
