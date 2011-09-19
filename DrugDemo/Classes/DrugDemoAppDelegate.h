//
//  DrugDemoAppDelegate.h
//  DrugDemo
//
//  Created by StasH on 19.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DrugDemoViewController;

@interface DrugDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DrugDemoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DrugDemoViewController *viewController;

@end

