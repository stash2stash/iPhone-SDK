//
//  GraphVipPViewController.m
//  GraphVipP
//
//  Created by StasH on 22.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphVipPViewController.h"


@implementation GraphVipPViewController



- (void) viewDidLoad
{
    [super viewDidLoad];
    
    
    // Configuring base layer
    self.view.layer.cornerRadius = 10;
    self.view.layer.backgroundColor = [UIColor colorWithRed:249/255.0 green:237/255.0 blue:219/255.0 alpha:1.0].CGColor;

    
    // Making layer for grid
    gridLayer = [CALayer layer];
    
    gridLayer.frame = CGRectInset(self.view.layer.frame, 10, 10);
    gridLayer.backgroundColor = [UIColor colorWithWhite: 0.0 alpha: 1.0].CGColor;
    
    gridLayer.shadowColor = [UIColor blackColor].CGColor;
    gridLayer.shadowOffset = CGSizeMake(0, 3);
    gridLayer.shadowOpacity = 0.8;
    gridLayer.shadowRadius = 5;
    
    [self.view.layer addSublayer: gridLayer];
    
    gridLayer.delegate = self;
    [gridLayer setNeedsDisplay];
    
    
    // Making layer for data diagram
    dataLayer = [CALayer layer];
    
    int origin_left = 10;
    int origin_right = 1;
    int origin_up = 1;
    int origin_down = 5;
    
    dataLayer.frame = CGRectMake(origin_left, 
                                 origin_up, 
                                 gridLayer.frame.size.width - (origin_left + origin_right), 
                                 gridLayer.frame.size.height - (origin_up + origin_down));
    
    dataLayer.backgroundColor = [UIColor colorWithWhite: 1.0 alpha: 1.0].CGColor;
    
    [gridLayer addSublayer: dataLayer];
    dataLayer.delegate = self;
    [dataLayer setNeedsDisplay];
}


- (void) drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    if (layer == gridLayer) {
        NSLog(@"Draw GRID layer");
        
        CGContextSetLineWidth(ctx, 1);
        CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
       
        CGContextStrokeRect(ctx, layer.frame);
    }
    
    if (layer == dataLayer) {
        NSLog(@"Draw DATA layer");

        CGContextSetLineWidth(ctx, 1);
        CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
        
        CGContextStrokeRect(ctx, layer.frame);
        
        
    }
}


- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}


- (void)dealloc 
{
    [super dealloc];
}

@end
