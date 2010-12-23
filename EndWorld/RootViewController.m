//--------------------------------------------------------------------------
//  RootViewController.m
//
//  (c) StasH, 2010
//--------------------------------------------------------------------------

#import "RootViewController.h"



@implementation RootViewController


- (id) init
{
    self = [super init];
    if (self != nil)
    {
        endWorldButton = [[[UIBarButtonItem alloc]
                           initWithTitle: @"EndWorld"
                           style: UIBarButtonItemStyleDone
                           target: self
                           action: @selector (endWorld)] autorelease];
        self.navigationItem.rightBarButtonItem = endWorldButton;
    }
    return self;
}


- (void) loadView
{
    [super loadView];
    
    textView = [[UITextView alloc] initWithFrame: [[UIScreen mainScreen] applicationFrame]];
    textView.editable = YES;
    textView.text = @"Enter any last words here, then press End World.";
    
    self.view = textView;
}


- (void) endWorld
{
    endWorldAlert = [[UIAlertView alloc] initWithTitle: @"End The World" 
                                               message: @"Warning: You are about to end the world."
                                              delegate: self
                                     cancelButtonTitle: @"My Bad"
                                     otherButtonTitles: @"OK", nil];
    endWorldAlert.delegate = self;
    [endWorldAlert show];
}


- (void) alertView: (UIAlertView *) alertView
    clickedButtonAtIndex: (NSInteger) buttonIndex
{
    if (alertView == endWorldAlert)
    {
        NSLog (@"Button %d pressed", buttonIndex);
        
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle: @"End the world"
                                                          message: nil 
                                                         delegate: self
                                                cancelButtonTitle: nil
                                                otherButtonTitles: @"OK", nil];
        if (buttonIndex == 0)
            myAlert.message = @"Be more careful next time!";
        else 
            if (buttonIndex == 1)
                myAlert.message = @"You must be connected to a WiFi network to end the world.";
            else 
                myAlert.message = @"Invalid button.";
        
        [myAlert show];
    }
    
    [alertView release];
}


- (void)dealloc 
{
    [textView dealloc];
    [endWorldButton dealloc];
    [super dealloc];
}


@end
