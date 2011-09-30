//--------------------------------------------------------------------------
//  FILENAME
//
//  (c) FULLUSERNAME, YEAR
//--------------------------------------------------------------------------

#import "GraphView.h"


static int origin_left = 23;
static int origin_right = 5;
static int origin_up = 5;
static int origin_down = 20;
static int origin_axis = 3; // Space between axis and graph

//static int max_lines_x = 8; // Maximum grid lines for X axies
//static int max_lines_y = 10;

//static int font_size = 10;


@implementation Measurment

@synthesize value;
@synthesize time;

@end


@implementation DrawLayerDelegate

@synthesize gridLayerFrame;
@synthesize dataLayerFrame;


- (void)drawLayer:(CALayer*)layer inContext:(CGContextRef)ctx
{
 //   if (layer == gridLayer) {
        NSLog (@"Draw GRID layer");
        
        CGContextSetLineWidth(ctx, 1);
        CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
        CGContextSetAllowsAntialiasing(ctx, false);
        
        // Draw axis
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, origin_left - origin_axis, 0);
        CGContextAddLineToPoint(ctx, origin_left - origin_axis, dataLayerFrame.size.height + origin_up + origin_axis);
        CGContextAddLineToPoint(ctx, dataLayerFrame.size.width + origin_left + origin_axis, 
                                dataLayerFrame.size.height + origin_up + origin_axis);
        CGContextStrokePath(ctx);
        
   /* }
    
    if (layer == dataLayer) {
        NSLog (@"Draw DATA layer");
        
    }*/
}

@end


@implementation GraphView

@synthesize min_x;
@synthesize max_x;
@synthesize min_y;
@synthesize max_y;



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


// Calculate min & max scale for X and Y
-(void) calculateScale
{
    NSEnumerator *enumerator = [measurments objectEnumerator];
    Measurment *anMeasurment;
    
    while (anMeasurment = [enumerator nextObject]) {
        if (min_x > anMeasurment.value) {
            min_x = anMeasurment.value;
        }
        
        if (max_x < anMeasurment.value) {
            max_x = anMeasurment.value;
        }

        if (min_y > anMeasurment.time) {
            min_y = anMeasurment.time;
        }
        
        if (max_y < anMeasurment.time) {
            max_y = anMeasurment.time;
        }
    }
    
    [dataLayer setNeedsDisplay];
    [gridLayer setNeedsDisplay];
    
    NSLog (@"X: %0.2f -> %0.2f", min_x, max_x);
    NSLog (@"Y: %0.2f -> %0.2f", min_y, max_y);
}


// Creating View, layers
- (id)initWithFrame:(CGRect)frame 
{
    NSLog(@"Init in frame: (%.0f,%.0f)x(%.0f,%.0f)", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    
    min_x = max_x = min_y = max_y = 0;
    
    if ((self = [super initWithFrame:frame])) 
    {
        NSLog (@"Init GraphView ... ");

        measurments = [[NSMutableArray alloc] init];
        
        drawLayerDelegate = [[DrawLayerDelegate alloc] init];
        
        
        // Configuring base layer
        self.layer.backgroundColor = [UIColor colorWithRed:249/255.0 green:237/255.0 blue:219/255.0 alpha:1.0].CGColor;
        
        // Making layer for grid
        gridLayer = [CALayer layer];
        gridLayer.frame = self.bounds;
        gridLayer.backgroundColor = [UIColor colorWithWhite: 1.0 alpha: 0.0].CGColor;
        
        [self.layer addSublayer: gridLayer];
        
        // Making layer for data diagram
        dataLayer = [CALayer layer];
        
        dataLayer.frame = CGRectMake(origin_left, 
                                     origin_up, 
                                     gridLayer.bounds.size.width - (origin_left + origin_right), 
                                     gridLayer.bounds.size.height - (origin_up + origin_down));
        
        dataLayer.backgroundColor = [UIColor colorWithWhite: 1.0 alpha: 1.0].CGColor;

        dataLayer.shadowColor = [UIColor blackColor].CGColor;
        dataLayer.shadowOffset = CGSizeMake(0, 3);
        dataLayer.shadowOpacity = 0.8;
        dataLayer.shadowRadius = 5;
        
        [self.layer addSublayer: dataLayer];
        
        drawLayerDelegate.dataLayerFrame = dataLayer.frame;
        dataLayer.delegate = drawLayerDelegate;
        
        drawLayerDelegate.gridLayerFrame = gridLayer.frame;
        gridLayer.delegate = drawLayerDelegate;
        
        [self calculateScale];
    }
    return self;
}


// Free up memory
- (void)dealloc 
{
    Measurment *anMeasurment;
    for (anMeasurment in measurments) 
        [anMeasurment release];
    
    [measurments release];
    
    [drawLayerDelegate release];
    
    [super dealloc];
}


// Adding new value to graph
-(void) addPoint:(NSNumber *)measurment
{
    Measurment *new_measurment = [[Measurment alloc] init];

    new_measurment.time = time (0);
    new_measurment.value = [measurment doubleValue];

    [measurments addObject: new_measurment];
    
    [self calculateScale];
}





@end


/*

        
        
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
                    CGContextAddLineToPoint(ctx, dataLayer.frame.size.width + origin_left, y);
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
                CGContextAddLineToPoint(ctx, dataLayer.frame.size.width + origin_left, y1);
                CGContextMoveToPoint(ctx, origin_left - origin_axis + 1, y2);
                CGContextAddLineToPoint(ctx, dataLayer.frame.size.width + origin_left, y2);
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
        
    }
    
}




-(void) addDataPoint:(NSNumber *)measurment
{
    
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



@end
*/