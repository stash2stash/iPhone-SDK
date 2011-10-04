//--------------------------------------------------------------------------
//  BearingViewController.h
//
//  (c) StasH, 2011
//--------------------------------------------------------------------------


#import <UIKit/UIKit.h>
#import "GraphView.h"


@interface BearingViewController : UIViewController 
{
    GraphView *graphView;
}


@property (nonatomic, retain) GraphView *graphView;

@end
