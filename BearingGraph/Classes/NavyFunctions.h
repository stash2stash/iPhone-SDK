//--------------------------------------------------------------------------
//  FILENAME
//
//  (c) FULLUSERNAME, YEAR
//--------------------------------------------------------------------------

#import <Foundation/Foundation.h>


@interface NavyFunctions : NSObject 
{

}


+(double) degToRad: (double) deg;

+(double) radToDeg: (double) rad;

+(double) mpsToUz: (double) mps;

+(double) uzToMps: (double) uz;

+(double) kabToM: (double) kab;

+(double) mToKab: (double) m;

+(CGPoint) positionFromPoint: (CGPoint)point Bearing: (double)bearing Distance: (double)dist;

+(CGPoint) extrapolatedPositionForTime: (int)time Course: (double)course Velocity: (double)vel FromPoint: (CGPoint) point;

+(double) getBearingFromPosition: (CGPoint)first toPosition: (CGPoint)second;

+(double) getDistanceFromPosition: (CGPoint)first toPosition: (CGPoint)second;

@end
