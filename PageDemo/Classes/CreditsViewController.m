//--------------------------------------------------------------------------
//  CreditsViewController.m
//
//  (c) StasH, 2010
//--------------------------------------------------------------------------

#import "CreditsViewController.h"


@implementation CreditsViewController


-(id) initWithAppDelegate:(id)appDelegate
{
    self = [super init];
    if (self != nil)
    {
        UIBarButtonItem *back = [[[UIBarButtonItem alloc]
                                  initWithTitle: @"Back"
                                  style: UIBarButtonItemStylePlain
                                  target: appDelegate
                                  action: @selector (back)] autorelease];
        self.navigationItem.backBarButtonItem = back;
    }
    return self;
}


-(void) loadView
{
    [super loadView];
    
    textView = [[UITextView alloc] initWithFrame: [[UIScreen mainScreen] applicationFrame]];
    
    textView.editable = NO;
    
    textView.text = @"iPhone SDK Application Development\n"
                    "Copyright (c) 2008, O'Reilly Media.";
    
    self.view = textView;
}


-(void) dealloc
{
    [textView release];
    [super dealloc];
}


@end
