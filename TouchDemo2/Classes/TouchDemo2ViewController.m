//
//  TouchDemo2ViewController.m
//  TouchDemo2
//
//  Created by StasH on 20.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TouchDemo2ViewController.h"


@implementation TouchDemo2View


- (id) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame: frame];
    
    if (self != nil) {
        self.multipleTouchEnabled = YES;
        
        for (int i=0; i<4; ++i) {
            NSURL *url = [NSURL URLWithString: [NSString stringWithFormat: @"http://www.ljplus.ru/img4/s/t/stash_stash/%d.jpg", i+1]];
            
            images [i] = [[UIImage alloc] initWithData: [NSData dataWithContentsOfURL: url]];
            
            offsets [i] = CGPointMake(0.0, 0.0);
        }
    
        offsets[0] = CGPointMake(0.0, 0.0);
        offsets[1] = CGPointMake(self.frame.size.width - images[1].size.width, 0.0);
        offsets[2] = CGPointMake(0.0, self.frame.size.height - images[2].size.height);
        offsets[3] = CGPointMake(self.frame.size.width - images[3].size.width, 
                                 self.frame.size.height - images[3].size.height);
    }
    return self;
}


- (void) drawRect: (CGRect) rect
{
    CGContextClearRect(UIGraphicsGetCurrentContext(), rect);
    
    for (int i=0; i<4; ++i) {
        [images[i] drawInRect: CGRectMake(offsets[i].x, offsets[i].y, images[i].size.width, images[i].size.height)];
    }    
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch;
    int touchId = 0;
    
    NSEnumerator *enumerator = [touches objectEnumerator];
    
    while ((touch = (UITouch *)[enumerator nextObject])) {
        tracking [touchId] = -1;
        
        CGPoint location = [touch locationInView: self];
        
        for (int i=3; i>=0; i--) {
            CGRect rect = CGRectMake(offsets[i].x, offsets[i].y, images[i].size.width, images[i].size.height);
            
            if (CGRectContainsPoint(rect, location)) {
                NSLog(@"Begin Touch ID %d Tracking with image %d\n",
                      touchId, i);
                tracking [touchId] = i;
                break;
            }
        }
        ++touchId;
    }
}


- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch;
    int touchId = 0;
    
    NSEnumerator *enumerator = [touches objectEnumerator];
    
    while ((touch = (UITouch *) [enumerator nextObject])) {
        if (tracking[touchId] != -1) {
            NSLog(@"Touch ID %d Tracking with image %d\n",
                  touchId, tracking[touchId]);
            
            CGPoint location = [touch locationInView: self];
            CGPoint oldLocation = [touch previousLocationInView: self];
            
            offsets [tracking[touchId]].x += (location.x - oldLocation.x);
            offsets [tracking[touchId]].y += (location.y - oldLocation.y);
            
            if (offsets[tracking[touchId]].x < 0.0) {
                offsets[tracking[touchId]].x = 0.0;
            }
            
            if (offsets[tracking[touchId]].x + images[tracking[touchId]].size.width > self.frame.size.width) {
                offsets[tracking[touchId]].x = self.frame.size.width - images[tracking[touchId]].size.width;
            }

            if (offsets[tracking[touchId]].y < 0.0) {
                offsets[tracking[touchId]].y = 0.0;
            }
            
            if (offsets[tracking[touchId]].y + images[tracking[touchId]].size.height > self.frame.size.height) {
                offsets[tracking[touchId]].y = self.frame.size.height - images[tracking[touchId]].size.height;
            }
        }
        
        ++touchId;
    }
    
    [self setNeedsDisplay];
}


@end


@implementation TouchDemo2ViewController


- (void) loadView
{
    [super loadView];
    
    touchView = [[TouchDemo2View alloc] initWithFrame: [[UIScreen mainScreen] applicationFrame]];
    
    self.view = touchView;
}


- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}


- (void)dealloc 
{
    [touchView release];
    [super dealloc];
}

@end
