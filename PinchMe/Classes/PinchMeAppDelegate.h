//
//  PinchMeAppDelegate.h
//  PinchMe
//
//  Created by StasH on 20.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PinchMeViewController;

@interface PinchMeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    PinchMeViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PinchMeViewController *viewController;

@end

