//--------------------------------------------------------------------------
//  FILENAME
//
//  (c) FULLUSERNAME, YEAR
//--------------------------------------------------------------------------

#import <Foundation/Foundation.h>


@protocol OptionsDataProtocol

@optional -(void) onShip_cChanged;
@optional -(void) onShip_vChanged;
@optional -(void) onTarget_cChanged;
@optional -(void) onTarget_vChanged;
@optional -(void) onTarget_bChanged;
@optional -(void) onTarget_dChanged;

@optional -(void) onOptionsChanged;

@end



// Class for storing options data
@interface OptionsData : NSObject 
{
    double ship_c;
    double ship_v;
    
    double target_c;
    double target_v;
    double target_b;
    double target_d;
    int target_mse; // Store only identifier (0, 1, ...)
    
    id <OptionsDataProtocol> delegate;
}


@property double ship_c;
@property double ship_v;

@property double target_c;
@property double target_v;
@property double target_b;
@property double target_d;
@property int target_mse;

@property (nonatomic, retain) id delegate;

@end
