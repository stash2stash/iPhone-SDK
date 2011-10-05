//--------------------------------------------------------------------------
//  FILENAME
//
//  (c) FULLUSERNAME, YEAR
//--------------------------------------------------------------------------


#import "OptionsData.h"



@implementation OptionsData

@synthesize ship_c;
@synthesize ship_v;

@synthesize target_c;
@synthesize target_v;
@synthesize target_b;
@synthesize target_d;
@synthesize target_mse;

@synthesize delegate;


-(void) notification
{
    if ( [[self delegate] respondsToSelector:@selector(onChanged)] ) {
        [[self delegate] onOptionsChanged];
    }
}


- (void)setShip_c:(double) value
{
    ship_c = value;

    if ( [[self delegate] respondsToSelector:@selector(onShip_cChanged)] ) {
        [[self delegate] onShip_cChanged];
    }
    
    [self notification];
}


- (void)setShip_v:(double) value
{
    ship_v = value;

    if ( [[self delegate] respondsToSelector:@selector(onShip_vChanged)] ) {
        [[self delegate] onShip_vChanged];
    }
    
    [self notification];
}


- (void)setTarget_c :(double) value
{
    target_c = value;

    if ( [[self delegate] respondsToSelector:@selector(onTarget_cChanged)] ) {
        [[self delegate] onTarget_cChanged];
    }
    
    [self notification];
}


- (void)setTarget_v :(double) value
{
    target_v = value;

    if ( [[self delegate] respondsToSelector:@selector(onTarget_vChanged)] ) {
        [[self delegate] onTarget_vChanged];
    }
    
    [self notification];
}

- (void)setTarget_b :(double) value
{
    target_b = value;

    if ( [[self delegate] respondsToSelector:@selector(onTarget_bChanged)] ) {
        [[self delegate] onTarget_bChanged];
    }
    
    [self notification];
}

- (void)setTarget_d :(double) value
{
    target_d = value;

    if ( [[self delegate] respondsToSelector:@selector(onTarget_dChanged)] ) {
        [[self delegate] onTarget_dChanged];
    }
    
    [self notification];
}


@end
