//--------------------------------------------------------------------------
//  OptionsViewController.m
//
//  (c) StasH, 2011
//--------------------------------------------------------------------------

#import "OptionsViewController.h"
#import "NavyFunctions.h"


@implementation OptionsViewController


@synthesize shipCell_c;
@synthesize shipCell_v;
@synthesize targetCell_c;
@synthesize targetCell_v;
@synthesize targetCell_b;
@synthesize targetCell_d;
@synthesize targetCell_mse;

@synthesize shipText_c;
@synthesize shipText_v;
@synthesize targetText_c;
@synthesize targetText_v;
@synthesize targetText_b;
@synthesize targetText_d;

@synthesize shipSlider_c;
@synthesize shipSlider_v;
@synthesize targetSlider_c;
@synthesize targetSlider_v;
@synthesize targetSlider_b;
@synthesize targetSlider_d;


-(void) onUpdateOptions
{
    if (nil == options) {
        return;
    }
    
    //NSLog (@"options:");
    //NSLog (@"   ship_c: %.1f", options.ship_c);
    //NSLog (@"   ship_v: %.1f", options.ship_v);
    //NSLog (@"   target_c: %.1f", options.target_c);
    //NSLog (@"   target_v: %.1f", options.target_v);
    //NSLog (@"   target_b: %.1f", options.target_b);
    //NSLog (@"   target_d: %.1f", options.target_d);
    
    shipText_c.text = [NSString stringWithFormat: @"%.0f", [NavyFunctions radToDeg: options.ship_c]];
    shipText_v.text = [NSString stringWithFormat: @"%.0f", [NavyFunctions mpsToUz: options.ship_v]];
    targetText_c.text = [NSString stringWithFormat: @"%.0f", [NavyFunctions radToDeg: options.target_c]];
    targetText_v.text = [NSString stringWithFormat: @"%.0f", [NavyFunctions mpsToUz: options.target_v]];
    targetText_b.text = [NSString stringWithFormat: @"%.0f", [NavyFunctions radToDeg: options.target_b]];
    targetText_d.text = [NSString stringWithFormat: @"%.0f", [NavyFunctions mToKab: options.target_d]];
    
    shipSlider_c.value = [NavyFunctions radToDeg: options.ship_c];
    shipSlider_v.value = [NavyFunctions mpsToUz: options.ship_v];
    targetSlider_c.value = [NavyFunctions radToDeg: options.target_c];
    targetSlider_v.value = [NavyFunctions mpsToUz: options.target_v];
    targetSlider_b.value = [NavyFunctions radToDeg: options.target_b];
    targetSlider_d.value = [NavyFunctions mToKab: options.target_d];
    
}


-(void)viewDidLoad
{
    self.editing = NO;
    
    [shipCell_c setSelectionStyle:UITableViewCellSelectionStyleNone];
    [shipCell_v setSelectionStyle:UITableViewCellSelectionStyleNone];
    [targetCell_c setSelectionStyle:UITableViewCellSelectionStyleNone];
    [targetCell_v setSelectionStyle:UITableViewCellSelectionStyleNone];
    [targetCell_b setSelectionStyle:UITableViewCellSelectionStyleNone];
    [targetCell_d setSelectionStyle:UITableViewCellSelectionStyleNone];
    [targetCell_mse setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //[self onUpdateOptions];
}


-(void)viewWillAppear:(BOOL)animated
{
    [self onUpdateOptions];
}


-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Ship";
    }
    if (section == 1) {
        return @"Target";
    }
    return nil;
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 5;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: 
            switch (indexPath.row) {
                case 0: return shipCell_c;
                    break;
                case 1: return shipCell_v;
                    break;
                default:
                    break;
            }
            break;
        case 1: 
            switch (indexPath.row) {
                case 0: return targetCell_c;                   
                    break;
                case 1: return targetCell_v;
                    break;
                case 2: return targetCell_b;
                    break;
                case 3: return targetCell_d;
                    break;
                case 4: return targetCell_mse;
                    break;
                default:
                    break;
            }
            break;
    }
    return nil;

}


-(IBAction) sliderValueChanged_ship_c: (id)sender
{
    UISlider *slider = sender;
    shipText_c.text = [NSString stringWithFormat: @"%.0f", slider.value];
    
    options.ship_c = [NavyFunctions degToRad: slider.value];
}


-(IBAction) sliderValueChanged_ship_v: (id)sender
{
    UISlider *slider = sender;
    shipText_v.text = [NSString stringWithFormat: @"%.0f", slider.value];
    
    options.ship_v = [NavyFunctions uzToMps: slider.value];
}


-(IBAction) sliderValueChanged_target_c: (id)sender
{
    UISlider *slider = sender;
    targetText_c.text = [NSString stringWithFormat: @"%.0f", slider.value];
    
    options.target_c = [NavyFunctions degToRad: slider.value];
}


-(IBAction) sliderValueChanged_target_v: (id)sender
{
    UISlider *slider = sender;
    targetText_v.text = [NSString stringWithFormat: @"%.0f", slider.value];
    
    options.target_v = [NavyFunctions uzToMps: slider.value];
}


-(IBAction) sliderValueChanged_target_b: (id)sender
{
    UISlider *slider = sender;
    targetText_b.text = [NSString stringWithFormat: @"%.0f", slider.value];
    
    options.target_b = [NavyFunctions degToRad: slider.value];
}


-(IBAction) sliderValueChanged_target_d: (id)sender
{
    UISlider *slider = sender;
    targetText_d.text = [NSString stringWithFormat: @"%.0f", slider.value];
    
    options.target_d = [NavyFunctions kabToM: slider.value];
}


-(void) setOptions:(OptionsData *)optionsData
{
    if (optionsData != options) {
        options = optionsData;

        if ([self isViewLoaded]) {
            [self onUpdateOptions];
        }
    }
}


- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
    [super dealloc];
}


@end
