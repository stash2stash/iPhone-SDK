//
//  BearingGraphAppDelegate.m
//  BearingGraph
//
//  Created by StasH on 29.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BearingGraphAppDelegate.h"
#import "Functions.h"


@implementation BearingGraphAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize optionsViewController;
 

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
    
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];

    // init options
    options = [[OptionsData alloc] init];
    
    options.ship_c = degToRad (12);
    options.ship_v = uzToMps (8);
    options.target_c = degToRad(210);
    options.target_v = uzToMps (12);
    options.target_b = degToRad (10);
    options.target_d = kabToM (5);
    
    [optionsViewController setOptions: options];

    
    // init objects
    ship = [[MovingObject alloc] initWithPosition: CGPointMake (0.0, 0.0)];
    
    
    
    
    return YES;
}


- (void)dealloc 
{
    [ship release];
    [options release];
    [tabBarController release];
    [window release];
    
    [super dealloc];
}

@end

