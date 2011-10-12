//
//  BearingGraphAppDelegate.h
//  BearingGraph
//
//  Created by StasH on 29.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovingObject.h"
#import "OptionsViewController.h"
#import "OptionsData.h"
#import "GraphView.h"


@interface BearingGraphAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, OptionsDataProtocol> 
{
    UIWindow *window;
    UITabBarController *tabBarController;
    OptionsViewController *optionsViewController;
    
    OptionsData *options;
    MovingObject *ship;
    MovingObject *target;
    
    NSTimer *timer;
    
    GraphView *bearingGraph;
    GraphView *bcvGraph;
    
    UISegmentedControl *aliasing_level;
}


@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet OptionsViewController *optionsViewController;

@property (nonatomic, retain) IBOutlet UISegmentedControl *aliasing_level;


-(void) handleTimer: (NSTimer *) timer;

@end
