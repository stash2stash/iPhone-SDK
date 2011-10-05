//--------------------------------------------------------------------------
//  FILENAME
//
//  (c) FULLUSERNAME, YEAR
//--------------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


// Just struct to store measurment
@interface Measurment : NSObject
{
    double value;
    time_t time;
}

@property double value;
@property time_t time;

@end


// Class for layers drawing
// NB: We can't set UIView class or his subclasses as delegate to draw layers, so
// we need another class as delegate. This class will be call draw methods from
// _view.
@interface LayerDelegate : NSObject 
{
    UIView* _view; 
}

-(id) initWithView: (UIView*) view;

@end;



@interface GraphView : UIView 
{
    LayerDelegate *layerDelegate; // for correct layer draw

    CALayer *dataLayer;
    CALayer *gridLayer;
    
    double min_x, max_x;
    double min_y, max_y;
    
    double minimum_min_x, minimum_max_x;
    double minimum_min_y, minimum_max_y;
    
    double maximum_min_x, maximum_max_x;
    double maximum_min_y, maximum_max_y;
    
    BOOL limit_maximum_x, limit_maximum_y;
    BOOL limit_minimum_x, limit_minimum_y; 
    
    NSMutableArray *measurments; // Data to display
}


@property double minimum_min_x;
@property double minimum_max_x;
@property double minimum_min_y;
@property double minimum_max_y;

@property double maximum_min_x;
@property double maximum_max_x;
@property double maximum_min_y;
@property double maximum_max_y;


@property BOOL limit_maximum_x;
@property BOOL limit_maximum_y;
@property BOOL limit_minimum_x;
@property BOOL limit_minimum_y; 


- (void) addPoint: (NSNumber *) measurment;


@end

