//--------------------------------------------------------------------------
//  RootViewController.h
//
//  (c) StasH, 2010
//--------------------------------------------------------------------------


#import <UIKit/UIKit.h>


@interface RootViewController : UIViewController 
{
    UITextView *textView [10];
    UIView *view;
    UIBarButtonItem *prev, *next;
    
    int page, lastViewed;
}


- (void) setPage;


@end
