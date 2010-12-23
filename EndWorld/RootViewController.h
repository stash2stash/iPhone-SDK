//--------------------------------------------------------------------------
//  RootViewController.h
//
//  (c) StasH, 2010
//--------------------------------------------------------------------------


#import <UIKit/UIKit.h>


@interface RootViewController : UIViewController 
{
    UITextView *textView;
    UIBarButtonItem *endWorldButton;
    UIAlertView *endWorldAlert;
}

- (id) init;
- (void) endWorld;


@end
