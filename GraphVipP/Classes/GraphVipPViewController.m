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
    min_y = 10000000;
    max_y = -10000000;
    
    min_x = 10000000;
    max_x = -10000000;
    
    NSEnumerator *enumerator = [measurments objectEnumerator];
    MEASURMENT *anMeasurment;
    
    while (anMeasurment = [enumerator nextObject]) {
        if (min_x > anMeasurment.bearing) {
            min_x = anMeasurment.bearing;
        }
        
        if (max_x < anMeasurment.bearing) {
            max_x = anMeasurment.bearing;
        }
        
        if (min_y > anMeasurment.time ) {
            min_y = anMeasurment.time;
        }
        
        if (max_y < anMeasurment.time) {
            max_y = anMeasurment.time;
        }
    }

 /*   // add some space
    double delta_x = fabs(max_x-min_x);
    double delta_y = fabs(max_y-min_y);
    
    delta_x = delta_x/10;
    delta_y = delta_y/10;
    
    max_x += delta_x;
    min_x -= delta_x;
    
    max_y += delta_y;
    min_y -= delta_y;
    
    if (min_y < 0) {
        min_y = 0;
    }
   */ 
    NSLog(@"X: min = %f, max = %f", min_x, max_x);
    NSLog(@"Y: min = %f, max = %f", min_y, max_y);
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

    
    measurments = [NSMutableArray array];
    
    /*
    // ideal bearing
    NSMutableArray *bearings = [NSMutableArray arrayWithObjects: 
                                [NSNumber numberWithDouble: 315.0131692],
                                [NSNumber numberWithDouble: 315.9064184],
                                [NSNumber numberWithDouble: 316.8537345],
                                [NSNumber numberWithDouble: 317.8596114],
                                [NSNumber numberWithDouble: 318.9289710],
                                [NSNumber numberWithDouble: 320.0671984],
                                [NSNumber numberWithDouble: 321.2801766],
                                [NSNumber numberWithDouble: 322.5743173],
                                [NSNumber numberWithDouble: 323.9565862],
                                [NSNumber numberWithDouble: 325.4345176],
                                [NSNumber numberWithDouble: 327.0162131],
                                [NSNumber numberWithDouble: 328.7103156],
                                [NSNumber numberWithDouble: 330.5259499],
                                [NSNumber numberWithDouble: 332.4726155],
                                [NSNumber numberWithDouble: 334.5600158],
                                [NSNumber numberWithDouble: 336.7978068],
                                [NSNumber numberWithDouble: 339.1952428],
                                [NSNumber numberWithDouble: 341.7607018],
                                [NSNumber numberWithDouble: 344.5010763],
                                [NSNumber numberWithDouble: 347.4210267],
                                [NSNumber numberWithDouble: 350.5221163],
                                [NSNumber numberWithDouble: 353.8018759],
                                [NSNumber numberWithDouble: 357.2528844],
                                [NSNumber numberWithDouble: 0.861994268],
                                [NSNumber numberWithDouble: 4.609859619],
                                [NSNumber numberWithDouble: 8.470930589],
                                [NSNumber numberWithDouble: 12.41404093],
                                [NSNumber numberWithDouble: 16.40363102],
                                [NSNumber numberWithDouble: 20.40152854],
                                [NSNumber numberWithDouble: 24.36908461],
                                [NSNumber numberWithDouble: 28.26937674],
                                [NSNumber numberWithDouble: 32.06917273],
                                [NSNumber numberWithDouble: 35.74040954],
                                [NSNumber numberWithDouble: 39.26105407],
                                [NSNumber numberWithDouble: 42.61533987],
                                [NSNumber numberWithDouble: 45.79347584],
                                [NSNumber numberWithDouble: 48.79098060],
                                [NSNumber numberWithDouble: 51.60780738],
                                [NSNumber numberWithDouble: 54.24740252],
                                [NSNumber numberWithDouble: 56.71580209],
                                [NSNumber numberWithDouble: 59.02083094],
                                [NSNumber numberWithDouble: 61.17143405],
                                [NSNumber numberWithDouble: 63.17714532],
                                [NSNumber numberWithDouble: 65.04768427],
                                [NSNumber numberWithDouble: 66.79266286],
                                [NSNumber numberWithDouble: 68.42138258],
                                [NSNumber numberWithDouble: 69.94270241],
                                [NSNumber numberWithDouble: 71.36496049],
                                [NSNumber numberWithDouble: 72.69593531],
                                [NSNumber numberWithDouble: 73.94283496],
                                [NSNumber numberWithDouble: 75.11230574],
                                [NSNumber numberWithDouble: 76.21045334],
                                [NSNumber numberWithDouble: 77.24287189],
                                [NSNumber numberWithDouble: 78.21467727],
                                [NSNumber numberWithDouble: 79.13054225],
                                [NSNumber numberWithDouble: 79.99473184],
                                nil];
    */
    
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
    
    NSEnumerator *enumerator = [bearings objectEnumerator];
    NSNumber *anValue;

    int time = 0;
    int aliasing_level = 5;
    NSMutableArray *prev = [NSMutableArray array];
    
    for (int i=1; i<=aliasing_level; ++i) {
        if (anValue = [enumerator nextObject])
        {
            [prev addObject: anValue];
            
            MEASURMENT *measurment = [[MEASURMENT alloc] init];
            double prev_bearing = [[prev objectAtIndex: 0] doubleValue];
            if (fabs(prev_bearing - [anValue doubleValue]) > 180.0) {
                if (prev_bearing < 180)
                    prev_bearing += 360;
                else
                    prev_bearing -= 360;
            }
            measurment.bearing = ([anValue doubleValue] - prev_bearing)/i;
            
            measurment.time = time;
            time+=1;
            [measurments addObject: measurment];
        }
    }

    aliasing_level = [prev count];
    
    while (anValue = [enumerator nextObject]) {
        MEASURMENT *measurment = [[MEASURMENT alloc] init];
        double prev_bearing = [[prev objectAtIndex: 0] doubleValue];
        if (fabs(prev_bearing - [anValue doubleValue]) > 180.0) {
            if (prev_bearing < 180)
                prev_bearing += 360;
            else
                prev_bearing -= 360;
        }
        measurment.bearing = ([anValue doubleValue] - prev_bearing)/aliasing_level;
        
        for (int i=0; i<aliasing_level-1; ++i) {
            [prev replaceObjectAtIndex: i withObject: [prev objectAtIndex: i+1]];
        }

        [prev replaceObjectAtIndex:(aliasing_level-1) withObject: anValue];
                
        measurment.time = time;
        time+=1;
        [measurments addObject: measurment];
        
        NSLog(@"time = %d, p = %f", measurment.time, measurment.bearing);
    }
    
    /*
    for (int i=0; i<100; ++i) {
        
        MEASURMENT *measurment = [[MEASURMENT alloc] init];
        measurment.bearing = i*i;
        measurment.time = i*2;
    
        [measurments addObject: measurment];
    }
    */
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
                NSLog(@"count = %d", count);
                scale_y = [anScale doubleValue];
                break;
            }
        }
        
        NSLog(@"Y: scale = %f", scale_y);
        
        if (scale_y != 0) {
            int first_count = ((int)(min_y / scale_y));
            
            CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:230/255.0 green:218/255.0 blue:200/255.0 alpha:1.0].CGColor);
            
            for (int i=first_count; i*scale_y < max_y; ++i) {
                NSLog(@"---- line %d", i);
                
                double y = [self getYPointByValue: (i * scale_y)] + origin_up;
                
                NSLog(@"Value = %f, y = %f", (i*scale_y), y);

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

        NSEnumerator *enumerator = [measurments objectEnumerator];
        MEASURMENT *anMeasurment;
        
        CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
        CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
        CGContextSetAllowsAntialiasing(ctx, true);
        
        // draw path
        CGContextBeginPath(ctx);
        
        // first point of path
        if (anMeasurment = [enumerator nextObject])
        {
            double x = [self getXPointByValue: anMeasurment.bearing];
            double y = [self getYPointByValue: anMeasurment.time];
            CGContextMoveToPoint(ctx, x, y);
        }
         
        // other 
        while (anMeasurment = [enumerator nextObject]) {
            double x = [self getXPointByValue: anMeasurment.bearing];
            double y = [self getYPointByValue: anMeasurment.time];

            CGContextAddLineToPoint(ctx, x, y);
        }
        
        CGContextStrokePath(ctx);
          
        /*
        // draw points
        CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
        CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);

        enumerator = [measurments objectEnumerator];
        while (anMeasurment = [enumerator nextObject]) {
            double x = [self getXPointByValue: anMeasurment.bearing];
            double y = [self getYPointByValue: anMeasurment.time];
            
            CGContextFillEllipseInRect(ctx, CGRectMake(x-2, y-2, 4, 4));
        }
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
