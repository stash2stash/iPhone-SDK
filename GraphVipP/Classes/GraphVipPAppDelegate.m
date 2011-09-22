//
//  GraphVipPAppDelegate.m
//  GraphVipP
//
//  Created by StasH on 22.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphVipPAppDelegate.h"
#import "GraphVipPViewController.h"

@implementation GraphVipPAppDelegate


- (void) applicationDidFinishLaunching:(UIApplication *)application
{
    window = [[UIWindow alloc] initWithFrame: [[UIScreen alloc] applicationFrame]];
    viewController = [[GraphVipPViewController alloc] init];

    [window addSubview:viewController.view];
    [window makeKeyAndVisible];

}


- (void)dealloc 
{
    [viewController release];
    [window release];
    [super dealloc];
}


@end
