//
//  GraphVipPViewController.h
//  GraphVipP
//
//  Created by StasH on 22.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface MEASURMENT : NSObject
{
    double bearing;
    time_t time;
}

@property double bearing;
@property time_t time;

@end



@interface GraphVipPViewController : UIViewController 
{
    CALayer *gridLayer;
    CALayer *dataLayer;

    double min_x, max_x; // min & max values for X axis
    double min_y, max_y; // min & max values for Y axis
    
    NSMutableArray *measurments; // Data to display
}



@end

