//--------------------------------------------------------------------------
//  FILENAME
//
//  (c) FULLUSERNAME, YEAR
//--------------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface Measurment : NSObject
{
    double value;
    time_t time;
}

@property double value;
@property time_t time;

@end


// class for layers drawing
@interface DrawLayerDelegate : NSObject
{
    CGRect gridLayerFrame;
    CGRect dataLayerFrame;
}

@property CGRect gridLayerFrame;
@property CGRect dataLayerFrame;

@end



@interface GraphView : UIView 
{
    DrawLayerDelegate *drawLayerDelegate; // for correct layer draw

    CALayer *dataLayer;
    CALayer *gridLayer;
    
    double min_x, max_x;
    double min_y, max_y;
    
    NSMutableArray *measurments; // Data to display
}


@property double min_x;
@property double max_x;
@property double min_y;
@property double max_y;


- (void) addPoint: (NSNumber *) measurment;


@end

