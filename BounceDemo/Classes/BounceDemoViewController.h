//
//  BounceDemoViewController.h
//  BounceDemo
//
//  Created by StasH on 21.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BounceDemoViewController : UIViewController 
{
    UIImageView *image1, *image2;
    CGPoint directionImage1, directionImage2;
    NSTimer *timer;
}

- (void) handleTimer: (NSTimer *) timer;

@end

