//--------------------------------------------------------------------------
//  RootViewController.m
//
//  (c) StasH, 2010
//--------------------------------------------------------------------------

#import "RootViewController.h"


@implementation RootViewController


-(id) initWithAppDelegate:(id)appDelegate
{
    self = [super init];
    if (self != nil)
    {
        credits = [[[UIBarButtonItem alloc]
                    initWithTitle: @"Credits"
                    style: UIBarButtonItemStylePlain
                    target: appDelegate 
                    action: @selector (credits)] autorelease];
        self.navigationItem.rightBarButtonItem = credits;
        
        segmentedControl = [[UISegmentedControl alloc] initWithItems: nil];
        
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        
        [segmentedControl insertSegmentWithTitle: @"Bunnies" atIndex: 0 animated: NO];
        [segmentedControl insertSegmentWithTitle: @"Ponies" atIndex: 1 animated: NO];
        
        [segmentedControl addTarget: self 
                             action: @selector (controlPressed:) 
                   forControlEvents: UIControlEventValueChanged];
        
        self.navigationItem.titleView = segmentedControl;
        
        segmentedControl.selectedSegmentIndex = 0;
    }
    return self;
}


-(void) controlPressed: (id) sender
{
    [self setPage];
}


-(void) setPage
{
    int index = segmentedControl.selectedSegmentIndex;
    
    if (index == 0)
        textView.text = @"OMG Bunnies!";
    else 
        textView.text = @"OMG Ponies";
}


-(void) loadView
{
    [super  loadView];
    
    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    
    textView = [[UITextView alloc] initWithFrame: bounds];
    
    textView.editable = NO;
    
    [self setPage];
    
    self.view = textView;
}


-(void) dealloc
{
    [textView release];
    [super dealloc];
}


@end
