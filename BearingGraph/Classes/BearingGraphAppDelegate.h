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


@interface BearingGraphAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
    OptionsViewController *optionsViewController;
    
    OptionsData *options;
    MovingObject *ship;
    MovingObject *target;
}


@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet OptionsViewController *optionsViewController;

@end
