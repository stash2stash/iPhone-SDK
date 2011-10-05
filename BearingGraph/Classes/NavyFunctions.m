//--------------------------------------------------------------------------
//  FILENAME
//
//  (c) FULLUSERNAME, YEAR
//--------------------------------------------------------------------------


#import "NavyFunctions.h"



@implementation NavyFunctions


+(double) degToRad: (double) deg
{
    return (deg*M_PI)/180.0;
}


+(double) radToDeg: (double) rad
{
    return (rad*180.0)/M_PI;
}


+(double) mpsToUz: (double) mps
{
    return mps/0.514;
}


+(double) uzToMps: (double) uz
{
    return uz*0.514;
}


+(double) kabToM: (double) kab
{
    return kab * 185.2;
}


+(double) mToKab: (double) m
{
    return m/185.2;
}


+(CGPoint) positionFromPoint: (CGPoint)point Bearing: (double)bearing Distance: (double)dist
{
    CGPoint result;
    
    result.x = dist * sin(bearing) + point.x;
    result.y = dist * cos(bearing) + point.y;
    
    return result;
}


+(CGPoint) extrapolatedPositionForTime: (int)time Course: (double)course Velocity: (double)vel FromPoint: (CGPoint) point
{
    CGPoint result;
    
    double dist = vel * time;
    
    result.x = dist * sin(course) + point.x;
    result.y = dist * cos(course) + point.y;
    
    return result;
}


+(double) getBearingFromPosition: (CGPoint)first toPosition: (CGPoint)second
{
    double x = second.x - first.x;
    double y = second.y - first.y;
    
    return (x<0) ? (atan2 (x, y) + 2*M_PI) : atan2 (x, y);
}


+(double) getDistanceFromPosition: (CGPoint)first toPosition: (CGPoint)second
{
    double x = first.x - second.x;
    double y = first.y - second.y;
    
    return sqrt (x*x + y*y);
}


@end
