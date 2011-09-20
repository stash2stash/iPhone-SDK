//
//  PinchMeViewController.m
//  PinchMe
//
//  Created by StasH on 20.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PinchMeViewController.h"

@implementation PinchMeViewController


- (void) viewDidLoad
{
    [super viewDidLoad];
    [self.view setMultipleTouchEnabled:YES];
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: self.view];
    NSUInteger taps = [touch tapCount];
    
    [super touchesBegan:touches withEvent:event];
    
    NSLog(@"Tap BEGIN at %f, %f Tap count: %d",
          location.x, location.y, taps);
}


- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    int finger = 0;
    NSEnumerator *enumerator = [touches objectEnumerator];
    UITouch *touch;
    CGPoint location[2];
    
    while ((touch = [enumerator nextObject]) && finger < 2) {
        location[finger] = [touch locationInView: self.view];
        NSLog(@"Finger %d moved: %fx%f",
              finger+1, location[finger].x, location[finger].y);
        ++finger;
    }
    
    if (finger == 2) {
        CGPoint scale;
        
        scale.x = fabs(location[0].x - location[1].x);
        scale.y = fabs(location[0].y - location[1].y);
        
        NSLog(@"Scaling: %.0f x %.0f",
              scale.x, scale.y);
    }
    
    [super touchesMoved:touches withEvent: event];
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: self.view];
    
    [super touchesEnded: touches withEvent: event];
    NSLog(@"Tap ENDED at %f, %f",
          location.x, location.y);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
