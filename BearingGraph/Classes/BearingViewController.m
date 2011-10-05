//--------------------------------------------------------------------------
//  BearingViewController.m
//
//  (c) StasH, 2011
//--------------------------------------------------------------------------

#import "BearingViewController.h"



@implementation BearingViewController


@synthesize graphView;


-(void) viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:249/255.0 green:237/255.0 blue:219/255.0 alpha:1.0];

    CGRect frame = [[self view] bounds];
    float tabHeight = [[[super tabBarController] tabBar] frame].size.height;
    
    frame.size.height -= tabHeight;

    frame = CGRectInset(frame, 10, 10);    
    
    graphView = [[GraphView alloc] initWithFrame: frame];

    // fixed scale
    graphView.minimum_min_x = 0;
    graphView.minimum_max_x = 360;
    graphView.minimum_min_y = 0;
    graphView.minimum_max_y = 120;
    
    graphView.maximum_min_x = 0;
    graphView.maximum_max_x = 360;
    graphView.maximum_min_y = 0;
    graphView.maximum_max_y = 120;
    
    graphView.limit_minimum_x = TRUE;
    graphView.limit_minimum_y = TRUE;
    graphView.limit_maximum_x = TRUE;
    graphView.limit_maximum_y = TRUE;
    
    [self.view addSubview: graphView];
    
}


-(void) viewDidUnload
{
    self.graphView = nil;
}


- (void)dealloc 
{
    [self viewDidUnload];
    
    [super dealloc];
}


@end
