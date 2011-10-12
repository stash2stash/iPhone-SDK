//--------------------------------------------------------------------------
//  BCVViewController.m
//
//  (c) StasH, 2011
//--------------------------------------------------------------------------

#import "BCVViewController.h"



@implementation BCVViewController

@synthesize graphView;
@synthesize segmentedControl;


-(void) viewDidLoad
{
    [super viewDidLoad];

    // set scale limiters
    graphView.minimum_min_x = -3;
    graphView.minimum_max_x = 3;
    graphView.minimum_min_y = 0;
    graphView.minimum_max_y = 120;
    
    //graphView.maximum_min_x = -180;
    //graphView.maximum_max_x = 180;
    graphView.maximum_min_y = 0;
    graphView.maximum_max_y = 120;
    
    graphView.limit_minimum_y = TRUE;
    graphView.limit_maximum_y = TRUE;
    graphView.limit_minimum_x = TRUE;
    
}


- (void)dealloc 
{
    self.graphView = nil;
    
    [super dealloc];
}


@end
