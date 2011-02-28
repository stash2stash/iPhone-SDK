//--------------------------------------------------------------------------
//  FILENAME
//
//  (c) FULLUSERNAME, YEAR
//--------------------------------------------------------------------------


#import <UIKit/UIKit.h>


@interface TableDemoViewController : UITableViewController 
{
    NSMutableArray *fileList;
}

-(void) startEditing;
-(void) stopEditing;
-(void) reload;

@end
