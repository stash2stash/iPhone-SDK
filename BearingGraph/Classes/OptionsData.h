//--------------------------------------------------------------------------
//  FILENAME
//
//  (c) FULLUSERNAME, YEAR
//--------------------------------------------------------------------------

#import <Foundation/Foundation.h>


// Class for storing options data
@interface OptionsData : NSObject 
{
    double ship_c;
    double ship_v;
    
    double target_c;
    double target_v;
    double target_b;
    double target_d;
    double target_mse;
}


@property double ship_c;
@property double ship_v;

@property double target_c;
@property double target_v;
@property double target_b;
@property double target_d;
@property double target_mse;

@end
