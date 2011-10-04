//--------------------------------------------------------------------------
//  FILENAME
//
//  (c) FULLUSERNAME, YEAR
//--------------------------------------------------------------------------


#import "MovingObject.h"



@implementation MovingObject

@synthesize course;
@synthesize velocity;
@synthesize position;


-(id) initWithPosition: (CGPoint) startPosition
{
    if (self = [super init]) {
        position = startPosition;
    }
    
    return self;
}


-(void) extrapolateWithTimeInterval: (int) timeInterval
{
    
}


@end
