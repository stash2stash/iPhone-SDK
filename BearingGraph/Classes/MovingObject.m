//--------------------------------------------------------------------------
//  FILENAME
//
//  (c) FULLUSERNAME, YEAR
//--------------------------------------------------------------------------


#import "MovingObject.h"
#import "NavyFunctions.h"


@implementation MovingObject

@synthesize course;
@synthesize velocity;
@synthesize position;


-(id) initWithPosition: (CGPoint) startPosition course: (double)c velocity: (double)v 
{
    if (self = [super init]) {
        self.position = startPosition;
        self.course = c;
        self.velocity = v;
    }
    
    return self;
}


-(void) extrapolateWithTimeInterval: (int) timeInterval
{
    position = [NavyFunctions extrapolatedPositionForTime: timeInterval Course:course Velocity:velocity FromPoint:position];
}


-(NSString *) description
{
    return [NSString stringWithFormat: @"course: %.2f, velocity: %.2f, position: (%.2f, %.2f)", course, velocity, position.x, position.y];
}

@end
