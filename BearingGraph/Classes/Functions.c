/*
 *  Functions.c
 *  BearingGraph
 *
 *  Created by StasH on 04.10.11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include <math.h>
#include "Functions.h"


double degToRad (double deg)
{
    return (deg*M_PI)/180.0;
}


double radToDeg (double rad)
{
    return (rad*180.0)/M_PI;
}


double mpsToUz (double mps)
{
    return mps/0.514;
}


double uzToMps (double uz)
{
    return uz*0.514;
}


double kabToM (double kab)
{
    return kab * 185.2;
}


double mToKab (double m)
{
    return m/185.2;
}

