//--------------------------------------------------------------------------
//  BearingViewController.m
//
//  (c) StasH, 2011
//--------------------------------------------------------------------------

#import "BearingViewController.h"



@implementation BearingViewController



-(void) viewDidLoad
{
    [super viewDidLoad];
    
    // Calculating height
    CGRect frame = [[self view] bounds];
    float tabBarHeight = [[[super tabBarController] tabBar] frame].size.height;
    frame.size.height -= tabBarHeight;
    
    graphView = [[GraphView alloc] initWithFrame: frame];
    
    self.view = graphView;
    
}


- (void)dealloc 
{
    [graphView release];
    
    [super dealloc];
}


@end
