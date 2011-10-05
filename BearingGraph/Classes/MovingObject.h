//--------------------------------------------------------------------------
//  FILENAME
//
//  (c) FULLUSERNAME, YEAR
//--------------------------------------------------------------------------

#import <Foundation/Foundation.h>


// Class for moving object
@interface MovingObject : NSObject 
{
    double course;    // rad
    double velocity;  // m/sec
    
    CGPoint position; // x, y
}


@property double course;
@property double velocity;
@property CGPoint position;


-(id) initWithPosition: (CGPoint) startPosition course: (double)course velocity: (double) velocity;
-(void) extrapolateWithTimeInterval: (int) timeInterval;


@end
