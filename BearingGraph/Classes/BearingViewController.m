//--------------------------------------------------------------------------
//  BearingViewController.m
//
//  (c) StasH, 2011
//--------------------------------------------------------------------------

#import "BearingViewController.h"



@implementation BearingViewController


-(id) initWithCoder: (NSCoder *) aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        CGRect frame = [[self view] bounds];
        float tabHeight = [[[super tabBarController] tabBar] frame].size.height;
        
        frame.size.height -= tabHeight;
        
        graphView = [[GraphView alloc] initWithFrame: frame];
        self.view = graphView;
        NSLog(@"%@", graphView);

        graphView.min_y = 0;
        graphView.max_y = 120;
        
        graphView.min_x = 0;
        graphView.max_x = 360;
    }

    return self;
}

/*
-(void) viewWillAppear:(BOOL)animated
{
    NSLog(@"%@", graphView);
    
}
*/

- (void)dealloc 
{
    [graphView release];
    
    [super dealloc];
}


@end
