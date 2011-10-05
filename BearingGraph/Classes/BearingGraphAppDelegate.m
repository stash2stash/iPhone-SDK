//
//  BearingGraphAppDelegate.m
//  BearingGraph
//
//  Created by StasH on 29.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BearingGraphAppDelegate.h"
#import "NavyFunctions.h"
#import "BearingViewController.h"
#import "BCVViewController.h"


@implementation BearingGraphAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize optionsViewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
    
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];

    // init options
    options = [[OptionsData alloc] init];
    
    options.ship_c = [NavyFunctions degToRad: 12];
    options.ship_v = [NavyFunctions uzToMps: 8];
    options.target_c = [NavyFunctions degToRad: 210];
    options.target_v = [NavyFunctions uzToMps: 100];
    options.target_b = [NavyFunctions degToRad: 10];
    options.target_d = [NavyFunctions kabToM: 5];
    
    options.delegate = self;
    
    [optionsViewController setOptions: options];

    
    // init objects
    ship = [[MovingObject alloc] initWithPosition: CGPointMake (0.0, 0.0) course: options.ship_c velocity: options.ship_v];
    
    CGPoint position = [NavyFunctions positionFromPoint: [ship position] Bearing: options.target_b Distance: options.target_d];
    
    target = [[MovingObject alloc] initWithPosition: position course: options.target_c velocity: options.target_v];
    
    //NSLog(@"%@", ship);
    //NSLog(@"%@", target);

    // init graphs
    
    BearingViewController *bearingViewController = [tabBarController.viewControllers objectAtIndex: 0];

    // force load graph
    // NB: It's very bad idea, keep data in visual class, 
    //     in future we need two classes: for data and for visualization!
    bearingViewController.view;
    
    bearingGraph = bearingViewController.graphView; 

    
    BCVViewController *bcvViewController = [tabBarController.viewControllers objectAtIndex: 1];
    bcvViewController.view;
    bcvGraph = bcvViewController.graphView; 
    
    timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
    
    return YES;
}


-(void) onShip_cChanged
{
    ship.course = options.ship_c;
}


-(void) onShip_vChanged
{
    ship.velocity = options.ship_v;
}


-(void) onTarget_cChanged
{
    target.course = options.target_c;
}


-(void) onTarget_vChanged
{
    target.velocity = options.target_v;
}


-(void) onTarget_bChanged
{
    NSLog(@"target_b changed");
}


-(void) onTarget_dChanged
{
    NSLog(@"target_d changed");
}


-(void) handleTimer:(NSTimer *)timer
{
    static time_t last_time = 0;
    static double prev_bearing = -1;
    
    
    if (0 == last_time) {
        last_time = time (0);
    }
    
    int delta_time = time (0) - last_time;
    
    if (delta_time <= 0) {
        NSLog(@"Wrong delta time: %d", delta_time);
        return;
    }
    
    last_time = time (0);
    
    // moving
    [ship extrapolateWithTimeInterval: delta_time];
    [target extrapolateWithTimeInterval: delta_time];
    
    
    // add bearing point
    double bearing = [NavyFunctions getBearingFromPosition: ship.position toPosition: target.position];
    
    //bearing = [NavyFunctions radToDeg: bearing];

    [bearingGraph addPoint: [NSNumber numberWithDouble: [NavyFunctions radToDeg: bearing]]];
    
    
    // add BVC point
    if (prev_bearing < 0) {
        prev_bearing = bearing;
        return;
    }
    
    if (fabs(bearing - prev_bearing) > M_PI) {
        if (prev_bearing < M_PI) {
            prev_bearing += 2 * M_PI;
        }
        else {
            prev_bearing -= 2* M_PI;
        }

    }
    
    
    [bcvGraph addPoint: [NSNumber numberWithDouble: [NavyFunctions radToDeg: (bearing - prev_bearing)]]];
    
    prev_bearing = bearing;
    
    //NSLog(@"Ship: %@", ship);
    //NSLog(@"Target: %@", target);
}


- (void)dealloc 
{
    [ship release];
    [target release];
    
    [options release];
    [tabBarController release];
    [window release];
    
    [super dealloc];
}

@end

