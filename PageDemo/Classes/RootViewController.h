//--------------------------------------------------------------------------
//  RootViewController.h
//
//  (c) StasH, 2010
//--------------------------------------------------------------------------


#import <UIKit/UIKit.h>


@interface RootViewController : UIViewController 
{
    UITextView *textView;
    UIBarButtonItem *credits;
    UISegmentedControl *segmentedControl;
}


-(void) setPage;
-(id) initWithAppDelegate: (id) appDelegate;


@end
