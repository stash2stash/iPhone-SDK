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
static int origin_axis = 3; // Space between axis and graph

static int max_lines_x = 8; // Maximum grid lines for X axies
static int max_lines_y = 10;

static int font_size = 10;




@implementation MEASURMENT

@synthesize bearing;
@synthesize time;


@end





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
    min_y = 0;
    max_y = 120;
    
//    min_x = 10000000;
//    max_x = -10000000;
  
    max_x = 3;
    min_x = -3;
    
//    min_x = 0;
//    max_x = 360;
    
    
    NSEnumerator *enumerator = [measurments objectEnumerator];
    MEASURMENT *anMeasurment;
    
    while (anMeasurment = [enumerator nextObject]) {
        if (min_x > anMeasurment.bearing) {
            min_x = anMeasurment.bearing;
        }
        
        if (max_x < anMeasurment.bearing) {
            max_x = anMeasurment.bearing;
        }


/* Don't scale Y axies
 
        if (min_y > (time(0) - anMeasurment.time)) {
            min_y = (time(0) - anMeasurment.time);
        }
        
        if (max_y < (time(0) - anMeasurment.time)) {
            max_y = (time(0) - anMeasurment.time);
        }
 */
    }

    NSLog(@"X: min = %f, max = %f", min_x, max_x);
    NSLog(@"Y: min = %f, max = %f", min_y, max_y);
    
    [dataLayer setNeedsDisplay];
    [gridLayer setNeedsDisplay];
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    
    
    // Configuring base layer
    self.view.layer.cornerRadius = 10;
    self.view.layer.backgroundColor = [UIColor colorWithRed:249/255.0 green:237/255.0 blue:219/255.0 alpha:1.0].CGColor;
    
    
    // Making layer for grid
    gridLayer = [CALayer layer];
    gridLayer.frame = CGRectInset(self.view.bounds, 10, 10);
    gridLayer.backgroundColor = [UIColor colorWithWhite: 1.0 alpha: 0.0].CGColor;
    
    [self.view.layer addSublayer: gridLayer];
    
    gridLayer.delegate = self;
    
    
    // Making layer for data diagram
    dataLayer = [CALayer layer];
    
    dataLayer.frame = CGRectMake(origin_left, 
                                 origin_up, 
                                 gridLayer.bounds.size.width - (origin_left + origin_right), 
                                 gridLayer.bounds.size.height - (origin_up + origin_down));
    
    dataLayer.backgroundColor = [UIColor colorWithWhite: 1.0 alpha: 0.0].CGColor;
    
    [gridLayer addSublayer: dataLayer];
    dataLayer.delegate = self;

    dataLayer.shadowColor = [UIColor blackColor].CGColor;
    dataLayer.shadowOffset = CGSizeMake(0, 3);
    dataLayer.shadowOpacity = 0.8;
    dataLayer.shadowRadius = 5;
    
    measurments = [[NSMutableArray alloc] init];
    
    // Making timer
    timer = [NSTimer scheduledTimerWithTimeInterval: 2.0 
                                             target: self 
                                           selector: @selector(handleTimer:)
                                           userInfo: nil
                                            repeats: YES];
    
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
                                  [NSNumber numberWithDouble: 5.0],
                                  [NSNumber numberWithDouble: 10.0],
                                  [NSNumber numberWithDouble: 30.0],
                                  [NSNumber numberWithDouble: 60.0],
                                  [NSNumber numberWithDouble: 120.0],
                                  nil];
        
        NSEnumerator *enumerator = [scale_y_array objectEnumerator];
        NSNumber *anScale;
        
        double scale_y = 0;
        
        while (anScale = [enumerator nextObject]) {
            int count = (max_y - min_y) / [anScale doubleValue];
            
            if (count <= max_lines_y) {
                //NSLog(@"count = %d", count);
                scale_y = [anScale doubleValue];
                break;
            }
        }
        
        //NSLog(@"Y: scale = %f", scale_y);
        
        if (scale_y != 0) {
            int first_count = ((int)(min_y / scale_y));
            
            CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:230/255.0 green:218/255.0 blue:200/255.0 alpha:1.0].CGColor);
            
            for (int i=first_count; i*scale_y < max_y; ++i) {
                //NSLog(@"---- line %d", i);
                
                double y = [self getYPointByValue: (i * scale_y)] + origin_up;
                
                //NSLog(@"Value = %f, y = %f", (i*scale_y), y);

                // draw line
                CGContextSetAllowsAntialiasing(ctx, false);
                CGContextBeginPath(ctx);
                CGContextMoveToPoint(ctx, origin_left - origin_axis + 1, y);
                CGContextAddLineToPoint(ctx, dataLayer.frame.size.width + origin_left /*- origin_axis*/, y);
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
        else {
            CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:230/255.0 green:218/255.0 blue:200/255.0 alpha:1.0].CGColor);

            double y1 = [self getYPointByValue: (min_y)] + origin_up;
            double y2 = [self getYPointByValue: (max_y)] + origin_up;    
                
            CGContextSetAllowsAntialiasing(ctx, false);
            
            // draw lines
            CGContextBeginPath(ctx);
            CGContextMoveToPoint(ctx, origin_left - origin_axis + 1, y1);
            CGContextAddLineToPoint(ctx, dataLayer.frame.size.width + origin_left /*- origin_axis*/, y1);
            CGContextMoveToPoint(ctx, origin_left - origin_axis + 1, y2);
            CGContextAddLineToPoint(ctx, dataLayer.frame.size.width + origin_left /*- origin_axis*/, y2);
            CGContextStrokePath(ctx);
                
            // draw text
            UIGraphicsPushContext(ctx);
            CGContextSetAllowsAntialiasing(ctx, true);
                
            NSString *dataLabel1 = [NSString stringWithFormat: @"%.0f", min_y];
            NSString *dataLabel2 = [NSString stringWithFormat: @"%.0f", max_y];
            
            CGSize textSize1 = [dataLabel1 sizeWithFont: [UIFont systemFontOfSize: font_size]];
            CGSize textSize2 = [dataLabel2 sizeWithFont: [UIFont systemFontOfSize: font_size]];
            
            [dataLabel1 drawInRect: CGRectMake(0, y1-textSize1.height/2, origin_left - origin_axis, textSize1.height) withFont: [UIFont systemFontOfSize: font_size] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];
            [dataLabel2 drawInRect: CGRectMake(0, y2-textSize2.height/2, origin_left - origin_axis, textSize2.height) withFont: [UIFont systemFontOfSize: font_size] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];
                
                
            UIGraphicsPopContext();
                
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
                                      [NSNumber numberWithDouble: 25.0],
                                      [NSNumber numberWithDouble: 50.0],
                                      nil];
            
            NSEnumerator *enumerator = [scale_x_array objectEnumerator];
            NSNumber *anScale;
            
            double scale_x = 0;
            
            while (anScale = [enumerator nextObject]) {
                int count = (max_x - min_x) / [anScale doubleValue];
                
                if (count <= max_lines_x) {
                    //NSLog(@"count = %d", count);
                    scale_x = [anScale doubleValue];
                    break;
                }
            }
            
            //NSLog(@"X: scale = %f", scale_x);
            
            if (scale_x != 0) {
                int first_count = ((int)(min_x / scale_x));
                
                
                CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:230/255.0 green:218/255.0 blue:200/255.0 alpha:1.0].CGColor);
                
                for (int i=first_count; i*scale_x < max_x; ++i) {
                    //NSLog(@"---- line %d", i);
                    
                    double x = [self getXPointByValue: (i * scale_x)] + origin_left;
                    
                    //NSLog(@"Value = %f, x = %f", (i*scale_x), x);
                    
                    // draw line
                    CGContextSetAllowsAntialiasing(ctx, false);
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
            else {
                CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:230/255.0 green:218/255.0 blue:200/255.0 alpha:1.0].CGColor);
                double x1 = [self getXPointByValue: (min_x)] + origin_left;
                double x2 = [self getXPointByValue: (max_x)] + origin_left;
                    
                // draw lines
                CGContextSetAllowsAntialiasing(ctx, false);
                CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:230/255.0 green:218/255.0 blue:200/255.0 alpha:1.0].CGColor);
                    
                CGContextBeginPath(ctx);
                CGContextMoveToPoint(ctx, x1, origin_up);
                CGContextAddLineToPoint(ctx, x1, dataLayer.frame.size.height + origin_up + origin_axis - 1);
                CGContextMoveToPoint(ctx, x2, origin_up);
                CGContextAddLineToPoint(ctx, x2, dataLayer.frame.size.height + origin_up + origin_axis - 1);
                CGContextStrokePath(ctx);
                    
                // draw text
                UIGraphicsPushContext(ctx);
                CGContextSetAllowsAntialiasing(ctx, true);
                    
                NSString *dataLabel1 = [NSString stringWithFormat: @"%.1f", min_x];
                NSString *dataLabel2 = [NSString stringWithFormat: @"%.1f", max_x];
                
                CGSize textSize1 = [dataLabel1 sizeWithFont: [UIFont systemFontOfSize: font_size]];
                CGSize textSize2 = [dataLabel2 sizeWithFont: [UIFont systemFontOfSize: font_size]];
                
                // if text don't fit in layer
                if ((x2 + textSize2.width/2) > gridLayer.bounds.size.width)
                    x2 = gridLayer.bounds.size.width - textSize2.width/2;
                    
                [dataLabel1 drawInRect: CGRectMake(x1-textSize1.width/2, [dataLayer bounds].size.height + origin_up + origin_axis, 
                                                      textSize1.width, origin_down - origin_up) withFont: [UIFont systemFontOfSize: font_size] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];
                [dataLabel2 drawInRect: CGRectMake(x2-textSize2.width/2, [dataLayer bounds].size.height + origin_up + origin_axis, 
                                                   textSize2.width, origin_down - origin_up) withFont: [UIFont systemFontOfSize: font_size] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];
                    
                UIGraphicsPopContext();
            }

            
            // draw ZERO line
            if ((min_x < 0) && (max_x > 0)) {
                
                double x = [self getXPointByValue: (0)] + origin_left;
                
                // draw 
                CGContextSetAllowsAntialiasing(ctx, false);
                CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
                CGFloat dash[] = {5.0, 5.0};
                CGContextSetLineDash(ctx, 0, dash, 2);
                
                CGContextBeginPath(ctx);
                CGContextMoveToPoint(ctx, x, origin_up);
                CGContextAddLineToPoint(ctx, x, dataLayer.frame.size.height + origin_up + origin_axis - 1);
                CGContextStrokePath(ctx);
            }
            
        } // X axies
        
        
    
    }
    
    if (layer == dataLayer) {
        NSLog(@"Draw DATA layer");

        // no data - return
        if ([measurments count] <= 0)
            return;
        
        CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
        CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
        CGContextSetAllowsAntialiasing(ctx, true);
        
        // draw path
        CGContextBeginPath(ctx);
        
        MEASURMENT *anMeasurment;
        MEASURMENT *prevMeasurment;
        
        anMeasurment = [measurments objectAtIndex: 0];
        prevMeasurment = [measurments objectAtIndex: 0];
        
        double x = [self getXPointByValue: anMeasurment.bearing];
        double y = [self getYPointByValue: (time(0) - anMeasurment.time)];
        CGContextMoveToPoint(ctx, x, y);
        
        for (anMeasurment in measurments) {
            double x = [self getXPointByValue: anMeasurment.bearing];
            double y = [self getYPointByValue: (time(0) - anMeasurment.time)];
            
            // Do not draw line, if bearing "too far"
            if (fabs(prevMeasurment.bearing - anMeasurment.bearing)>180)
            {
                // close line
                CGContextStrokePath(ctx);
                
                // and start new
                CGContextBeginPath(ctx);
                CGContextMoveToPoint(ctx, x, y);
            }
            
            CGContextAddLineToPoint(ctx, x, y);
            prevMeasurment = anMeasurment;
        }
        
        CGContextStrokePath(ctx);
          
//        // draw points
//        CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
//        CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
//
//        enumerator = [measurments objectEnumerator];
//        while (anMeasurment = [enumerator nextObject]) {
//            double x = [self getXPointByValue: anMeasurment.bearing];
//            double y = [self getYPointByValue: (time(0) - anMeasurment.time)];
//            
//            CGContextFillEllipseInRect(ctx, CGRectMake(x-2, y-2, 4, 4));
//        }
        
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


-(void) addDataPoint:(NSNumber *)measurment
{
    NSLog (@"add point p = %0.2f", [measurment doubleValue]);
    
    // Adding point
    MEASURMENT *new_measurment = [[MEASURMENT alloc] init];

    new_measurment.time = time (0);
    new_measurment.bearing = [measurment doubleValue];
    
    [measurments addObject: new_measurment];
   
}


-(void) handleTimer:(NSTimer *)timer
{
    // bearing with noise
    NSMutableArray *bearings = [NSMutableArray arrayWithObjects: 
                                [NSNumber numberWithDouble: 315.0181802],
                                [NSNumber numberWithDouble: 316.0476599],
                                [NSNumber numberWithDouble: 316.9725955],
                                [NSNumber numberWithDouble: 317.6980191],
                                [NSNumber numberWithDouble: 319.0029772],
                                [NSNumber numberWithDouble: 320.1756806],
                                [NSNumber numberWithDouble: 321.3823025],
                                [NSNumber numberWithDouble: 322.5424721],
                                [NSNumber numberWithDouble: 323.7490692],
                                [NSNumber numberWithDouble: 325.6071341],
                                [NSNumber numberWithDouble: 326.9713286],
                                [NSNumber numberWithDouble: 328.8191790],
                                [NSNumber numberWithDouble: 330.3829670],
                                [NSNumber numberWithDouble: 332.4922989],
                                [NSNumber numberWithDouble: 334.4068796],
                                [NSNumber numberWithDouble: 336.9540996],
                                [NSNumber numberWithDouble: 339.2842117],
                                [NSNumber numberWithDouble: 342.0010322],
                                [NSNumber numberWithDouble: 344.5667952],
                                [NSNumber numberWithDouble: 347.3584822],
                                [NSNumber numberWithDouble: 350.4634885],
                                [NSNumber numberWithDouble: 353.7254211],
                                [NSNumber numberWithDouble: 357.4461085],
                                [NSNumber numberWithDouble: 0.692636881],
                                [NSNumber numberWithDouble: 4.459733086],
                                [NSNumber numberWithDouble: 8.454279562],
                                [NSNumber numberWithDouble: 12.54064230],
                                [NSNumber numberWithDouble: 16.18866360],
                                [NSNumber numberWithDouble: 20.28655564],
                                [NSNumber numberWithDouble: 24.10606806],
                                [NSNumber numberWithDouble: 28.09233663],
                                [NSNumber numberWithDouble: 31.86877940],
                                [NSNumber numberWithDouble: 35.75463557],
                                [NSNumber numberWithDouble: 39.50717525],
                                [NSNumber numberWithDouble: 42.73026248],
                                [NSNumber numberWithDouble: 45.93604464],
                                [NSNumber numberWithDouble: 48.62405462],
                                [NSNumber numberWithDouble: 51.67563783],
                                [NSNumber numberWithDouble: 54.31314908],
                                [NSNumber numberWithDouble: 56.80469163],
                                [NSNumber numberWithDouble: 59.13915532],
                                [NSNumber numberWithDouble: 61.02807730],
                                [NSNumber numberWithDouble: 63.35683424],
                                [NSNumber numberWithDouble: 65.12287237],
                                [NSNumber numberWithDouble: 66.90415798],
                                [NSNumber numberWithDouble: 68.31059096],
                                [NSNumber numberWithDouble: 69.73325237],
                                [NSNumber numberWithDouble: 71.46149524],
                                [NSNumber numberWithDouble: 72.64219954],
                                [NSNumber numberWithDouble: 73.89624961],
                                [NSNumber numberWithDouble: 75.22221198],
                                [NSNumber numberWithDouble: 76.13302323],
                                [NSNumber numberWithDouble: 77.10139820],
                                [NSNumber numberWithDouble: 78.03465263],
                                [NSNumber numberWithDouble: 79.02423227],
                                [NSNumber numberWithDouble: 80.14928531],
                                nil];

    if ([measurments count] < [bearings count]) {

        double bearing = [[bearings objectAtIndex: [measurments count]] doubleValue];

        // Antialiasing
        int aliasing_level = 1;
        
        double prev_bearing = bearing;
        
        if ([measurments count] >= aliasing_level) {
            prev_bearing = [[bearings objectAtIndex: ([measurments count] - aliasing_level)] doubleValue];
        }
        else
        {
            prev_bearing = [[bearings objectAtIndex: 0] doubleValue];
            aliasing_level = [measurments count];
        }
        
        if (fabs(prev_bearing - bearing) > 180.0) {
            if (prev_bearing < 180)
                prev_bearing += 360;
            else
                prev_bearing -= 360;
        }
        
        bearing = (bearing - prev_bearing)/aliasing_level;

        // adding
        [self addDataPoint: [NSNumber numberWithDouble: bearing]];
    }
    
    [self calculateScale];
}



- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}


- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"w: %f, h: %f", self.view.layer.bounds.size.width, self.view.layer.bounds.size.height);
    
    gridLayer.frame = CGRectInset(self.view.layer.bounds, 10, 10);
    
    dataLayer.frame = CGRectMake(origin_left, 
                                 origin_up, 
                                 gridLayer.bounds.size.width - (origin_left + origin_right), 
                                 gridLayer.bounds.size.height - (origin_up + origin_down));
    
    
    [gridLayer setNeedsDisplay];
    
    [dataLayer setNeedsDisplay];
    
}


- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}


- (void)dealloc 
{
    [timer invalidate];
    [measurments release];

    [super dealloc];
}

@end
