//
//  TouchDemo2ViewController.h
//  TouchDemo2
//
//  Created by StasH on 20.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TouchDemo2View : UIView
{
    UIImage *images [4];
    CGPoint offsets [4];
    int tracking [4];
}

@end



@interface TouchDemo2ViewController : UIViewController 
{
    TouchDemo2View *touchView;
}

@end

