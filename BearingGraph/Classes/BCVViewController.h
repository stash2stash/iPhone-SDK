//--------------------------------------------------------------------------
//  BCVViewController.h
//
//  (c) StasH, 2011
//--------------------------------------------------------------------------


#import <UIKit/UIKit.h>
#import "GraphView.h"


@interface BCVViewController : UIViewController 
{
    GraphView *graphView;
    //UISegmentedControl *segmentedControl;
}


@property (nonatomic, retain) IBOutlet GraphView *graphView;
//@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;


@end
