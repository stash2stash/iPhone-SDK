//
//  LayerFunAppDelegate.h
//  LayerFun
//
//  Created by StasH on 21.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LayerFunViewController;

@interface LayerFunAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    LayerFunViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet LayerFunViewController *viewController;

@end

