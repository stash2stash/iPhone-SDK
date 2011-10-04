//--------------------------------------------------------------------------
//  BCVViewController.m
//
//  (c) StasH, 2011
//--------------------------------------------------------------------------

#import "BCVViewController.h"



@implementation BCVViewController

@synthesize graphView;
//@synthesize segmentedControl;


-(void) viewDidLoad
{
    [super viewDidLoad];
    
    graphView.min_y = 0;
    graphView.max_y = 120;
    
    graphView.min_x = -3;
    graphView.max_x = 3;
    
}


- (void)dealloc 
{
    self.graphView = nil;
    
    [super dealloc];
}


@end
