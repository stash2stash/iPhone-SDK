//
//  TouchDemoAppDelegate.h
//  TouchDemo
//
//  Created by StasH on 19.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TouchDemoViewController;

@interface TouchDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TouchDemoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TouchDemoViewController *viewController;

@end

