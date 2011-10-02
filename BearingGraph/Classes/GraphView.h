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
    
    NSMutableArray *measurments; // Data to display
}


@property double min_x;
@property double max_x;
@property double min_y;
@property double max_y;


- (void) addPoint: (NSNumber *) measurment;


@end

