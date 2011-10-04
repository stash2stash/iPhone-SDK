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

    CGRect frame = [[self view] bounds];
    float tabHeight = [[[super tabBarController] tabBar] frame].size.height;
    
    frame.size.height -= tabHeight;
    
    graphView = [[GraphView alloc] initWithFrame: frame];
    self.view = graphView;
    
    graphView.min_y = 0;
    graphView.max_y = 120;
    
    graphView.min_x = 0;
    graphView.max_x = 360;
    
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
