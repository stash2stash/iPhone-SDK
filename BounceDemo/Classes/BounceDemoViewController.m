//
//  BounceDemoViewController.m
//  BounceDemo
//
//  Created by StasH on 21.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BounceDemoViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation BounceDemoViewController


- (id) init
{
    self = [super init];
    
    if (self != nil) {

        NSURL *url = [NSURL URLWithString: @"http://www.ljplus.ru/img4/s/t/stash_stash/2.jpg"];
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL: url]];
        
        image1 = [[UIImageView alloc] initWithImage: image];
        directionImage1 = CGPointMake(-1.0, -1.0);
        image1.layer.position = CGPointMake((image.size.width/2)+1, (image.size.width/2)+1);

        url = [NSURL URLWithString: @"http://www.ljplus.ru/img4/s/t/stash_stash/4.jpg"];
        image = [UIImage imageWithData: [NSData dataWithContentsOfURL: url]];

        image2 = [[UIImageView alloc] initWithImage: image];
        directionImage2 = CGPointMake(1.0, 1.0);
        image2.layer.position = CGPointMake((image.size.width/2)+1, (image.size.width/2)+1);
        
        [self.view.layer addSublayer: image2.layer];
        [self.view.layer addSublayer: image1.layer];
    }
    
    return self;
}


- (void) loadView
{
    [super loadView];
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    
    timer = [NSTimer scheduledTimerWithTimeInterval: 0.01
                                             target: self
                                           selector: @selector (handleTimer:)
                                           userInfo: nil
                                            repeats: YES];
    
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath: @"transform"];
    anim1.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(3.1415, 1.0, 0, 0)];
    
    anim1.duration = 2;
    anim1.cumulative = YES;
    anim1.repeatCount = 1000;
    [image1.layer addAnimation: anim1 forKey: @"transformAnimation"];
}


- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    [timer invalidate];
    [image1 release];
    [image2 release];
    
    [super dealloc];
}


- (void) handleTimer:(NSTimer *)timer
{

    // Moving image1
    CGSize size = [image1 image].size;
    
    if (image1.layer.position.x <= ((size.width/2)+1) - self.view.frame.origin.x) {
        directionImage1.x = 1.0;
    }
    if (image1.layer.position.x + (size.width/2)+1 >= (self.view.frame.size.width - self.view.frame.origin.x)-1) {
        directionImage1.x = -1.0;
    }
    if (image1.layer.position.y <= ((size.height/2)+1) - self.view.frame.origin.y) {
        directionImage1.y = 1.0;
    }
    if (image1.layer.position.y + (size.height/2)+1 >= (self.view.frame.size.height - self.view.frame.origin.y)-1) {
        directionImage1.y = -1.0;
    }
    
    CGPoint origin = image1.layer.position;
    origin.x += directionImage1.x;
    origin.y += directionImage1.y;
    image1.layer.position = origin;
    
    // Moving image2
    size = [image2 image].size;
    
    if (image2.layer.position.x <= ((size.width/2)+1) - self.view.frame.origin.x) {
        directionImage2.x = 1.0;
    }
    if (image2.layer.position.x + (size.width/2)+1 >= (self.view.frame.size.width - self.view.frame.origin.x)-1) {
        directionImage2.x = -1.0;
    }
    if (image2.layer.position.y <= ((size.height/2)+1) - self.view.frame.origin.y) {
        directionImage2.y = 1.0;
    }
    if (image2.layer.position.y + (size.height/2)+1 >= (self.view.frame.size.height - self.view.frame.origin.y)-1) {
        directionImage2.y = -1.0;
    }
    
    origin = image2.layer.position;
    origin.x += directionImage2.x;
    origin.y += directionImage2.y;
    image2.layer.position = origin;
    
    [self.view setNeedsDisplayInRect: image1.layer.frame];
    [self.view setNeedsDisplayInRect: image2.layer.frame];
}


@end
