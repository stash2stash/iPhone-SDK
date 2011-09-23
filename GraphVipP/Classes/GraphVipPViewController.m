//
//  GraphVipPViewController.m
//  GraphVipP
//
//  Created by StasH on 22.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphVipPViewController.h"


static int origin_left = 23;
static int origin_right = 5;
static int origin_up = 5;
static int origin_down = 20;
static int origin_axis = 3;   // Space between axis and graph

static int max_lines_x = 10;   // Maximum grid lines for X axies
static int max_lines_y = 15;

static int font_size = 10;

@implementation GraphVipPViewController


// Convert (value) to screen points for X axies
-(double) getXPointByValue:(double) value
{
    return (value - min_x) * ([dataLayer bounds].size.width / (max_x - min_x));
}


// Convert (value) to screen points for Y axies
-(double) getYPointByValue:(double) value
{
    return [dataLayer bounds].size.height - ((value - min_y) * ([dataLayer bounds].size.height / (max_y - min_y)));
}


// Calculate min & max for axes
-(void) calculateScale
{
    min_y = 20;
    max_y = 5 * 60;
    
    min_x = 0;
    max_x = 3.1415;
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    
    
    // Configuring base layer
    self.view.layer.cornerRadius = 10;
    self.view.layer.backgroundColor = [UIColor colorWithRed:249/255.0 green:237/255.0 blue:219/255.0 alpha:1.0].CGColor;

    
    // Making layer for grid
    gridLayer = [CALayer layer];
    
    gridLayer.frame = CGRectInset(self.view.layer.bounds, 10, 10);
    gridLayer.backgroundColor = [UIColor colorWithWhite: 1.0 alpha: 0.0].CGColor;
    
    //gridLayer.shadowColor = [UIColor blackColor].CGColor;
    //gridLayer.shadowOffset = CGSizeMake(0, 3);
    //gridLayer.shadowOpacity = 0.8;
    //gridLayer.shadowRadius = 5;
    
    [self.view.layer addSublayer: gridLayer];
    
    gridLayer.delegate = self;
    [gridLayer setNeedsDisplay];
    
    
    // Making layer for data diagram
    dataLayer = [CALayer layer];
    
    dataLayer.frame = CGRectMake(origin_left, 
                                 origin_up, 
                                 gridLayer.bounds.size.width - (origin_left + origin_right), 
                                 gridLayer.bounds.size.height - (origin_up + origin_down));
    
    dataLayer.backgroundColor = [UIColor colorWithWhite: 1.0 alpha: 0.0].CGColor;
    
    [gridLayer addSublayer: dataLayer];
    dataLayer.delegate = self;
    [dataLayer setNeedsDisplay];
     
    
    [self calculateScale];
}


- (void) drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    
    if (layer == gridLayer) {
        NSLog(@"Draw GRID layer");
        
        CGContextSetLineWidth(ctx, 1);
        CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
        CGContextSetAllowsAntialiasing(ctx, false);
        
        // Draw axis
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, origin_left - origin_axis, 0);
        CGContextAddLineToPoint(ctx, origin_left - origin_axis, dataLayer.frame.size.height + origin_up + origin_axis);
        CGContextAddLineToPoint(ctx, dataLayer.frame.size.width + origin_left + origin_axis, 
                                dataLayer.frame.size.height + origin_up + origin_axis);
        CGContextStrokePath(ctx);

        
        //----- Y axies ----------
        {
        // Finding scale
        NSArray *scale_y_array = [NSArray arrayWithObjects: 
                                  [NSNumber numberWithDouble: 1.0], 
                                  [NSNumber numberWithDouble: 30.0],
                                  [NSNumber numberWithDouble: 60.0],
                                  [NSNumber numberWithDouble: 300.0],
                                  [NSNumber numberWithDouble: 600.0],
                                  [NSNumber numberWithDouble: 3600.0],
                                  nil];
        
        NSEnumerator *enumerator = [scale_y_array objectEnumerator];
        NSNumber *anScale;
        
        double scale_y = 0;
        
        while (anScale = [enumerator nextObject]) {
            int count = (max_y - min_y) / [anScale doubleValue];
            
            if (count <= max_lines_y) {
                NSLog(@"count = %d", count);
                scale_y = [anScale doubleValue];
                break;
            }
        }
        
        NSLog(@"Y: scale = %f", scale_y);
        
        if (scale_y != 0) {
            int first_count = ((int)(min_y / scale_y)) + 1;
            
            CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:230/255.0 green:218/255.0 blue:200/255.0 alpha:1.0].CGColor);
            
            for (int i=first_count; i*scale_y < max_y; ++i) {
                NSLog(@"---- line %d", i);
                
                double y = [self getYPointByValue: (i * scale_y)] + origin_up;
                
                NSLog(@"Value = %f, y = %f", (i*scale_y), y);

                // draw line
                CGContextSetAllowsAntialiasing(ctx, false);
                CGContextBeginPath(ctx);
                CGContextMoveToPoint(ctx, origin_left - origin_axis + 1, y);
                CGContextAddLineToPoint(ctx, dataLayer.frame.size.width + origin_left - origin_axis, y);
                CGContextStrokePath(ctx);
                
                // draw text
                UIGraphicsPushContext(ctx);
                CGContextSetAllowsAntialiasing(ctx, true);
                
                NSString *dataLabel = [NSString stringWithFormat: @"%.0f", i*scale_y];

                CGSize textSize = [dataLabel sizeWithFont: [UIFont systemFontOfSize: font_size]];
                [dataLabel drawInRect: CGRectMake(0, y-textSize.height/2, origin_left - origin_axis, textSize.height) withFont: [UIFont systemFontOfSize: font_size] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];

                //CGContextStrokeRect(ctx, CGRectMake(0, y-textSize.height/2, origin_left - origin_axis, textSize.height));
                
                UIGraphicsPopContext();
                
            }
        }
        }

    
        //----- X axies ----------
        
        {
            // Finding scale
            NSArray *scale_x_array = [NSArray arrayWithObjects: 
                                      [NSNumber numberWithDouble: 0.1], 
                                      [NSNumber numberWithDouble: 0.2],
                                      [NSNumber numberWithDouble: 0.5],
                                      [NSNumber numberWithDouble: 1.0],
                                      [NSNumber numberWithDouble: 5.0],
                                      [NSNumber numberWithDouble: 10.0],
                                      nil];
            
            NSEnumerator *enumerator = [scale_x_array objectEnumerator];
            NSNumber *anScale;
            
            double scale_x = 0;
            
            while (anScale = [enumerator nextObject]) {
                int count = (max_x - min_x) / [anScale doubleValue];
                
                if (count <= max_lines_x) {
                    NSLog(@"count = %d", count);
                    scale_x = [anScale doubleValue];
                    break;
                }
            }
            
            NSLog(@"X: scale = %f", scale_x);
            
            if (scale_x != 0) {
                int first_count = ((int)(min_x / scale_x));
                
                
                CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:230/255.0 green:218/255.0 blue:200/255.0 alpha:1.0].CGColor);
                
                for (int i=first_count; i*scale_x < max_x; ++i) {
                    NSLog(@"---- line %d", i);
                    
                    double x = [self getXPointByValue: (i * scale_x)] + origin_left;
                    
                    NSLog(@"Value = %f, x = %f", (i*scale_x), x);
                    
                    // draw line
                    CGContextSetAllowsAntialiasing(ctx, false);
                    
                    if (i*scale_x == 0)
                        CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
                    else
                        CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:230/255.0 green:218/255.0 blue:200/255.0 alpha:1.0].CGColor);
                    
                    CGContextBeginPath(ctx);
                    CGContextMoveToPoint(ctx, x, origin_up);
                    CGContextAddLineToPoint(ctx, x, dataLayer.frame.size.height + origin_up + origin_axis - 1);
                    CGContextStrokePath(ctx);
                    
                    // draw text
                    UIGraphicsPushContext(ctx);
                    CGContextSetAllowsAntialiasing(ctx, true);
                    
                    NSString *dataLabel = [NSString stringWithFormat: @"%.1f", i*scale_x];
                    
                    CGSize textSize = [dataLabel sizeWithFont: [UIFont systemFontOfSize: font_size]];
                    [dataLabel drawInRect: CGRectMake(x-textSize.width/2, 
                                                      [dataLayer bounds].size.height + origin_up + origin_axis, 
                                                      textSize.width, 
                                                      origin_down - origin_up) 
                                 withFont: [UIFont systemFontOfSize: font_size] 
                            lineBreakMode:UILineBreakModeWordWrap 
                                alignment:UITextAlignmentRight];
                    
                    //CGContextStrokeRect(ctx, CGRectMake(x-textSize.width/2, [dataLayer bounds].size.height + origin_up+origin_axis, textSize.width, origin_down - origin_up));
                    
                    UIGraphicsPopContext();
                    
                }
            }
        }
        
        
    
    }
    
    if (layer == dataLayer) {
        NSLog(@"Draw DATA layer");
/*
        CGContextSetLineWidth(ctx, 1);
        CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
        
        CGContextStrokeRect(ctx, layer.bounds);
*/        
        
    }
     
}


/*
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
*/

/*
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
 UITouch *touch;
 
 NSEnumerator *enumerator = [touches objectEnumerator];
 
 while ((touch = (UITouch *) [enumerator nextObject])) {
 CGPoint location = [touch locationInView: self.view];
 CGPoint oldLocation = [touch previousLocationInView: self.view];
 
 double offset_x = (location.x - oldLocation.x);
 
 min_x += offset_x;
 }
 
 [gridLayer setNeedsDisplay];
 
}
*/

/*
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}
*/

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}


- (void)dealloc 
{

    [super dealloc];
}

@end
