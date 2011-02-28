//--------------------------------------------------------------------------
//  FILENAME
//
//  (c) FULLUSERNAME, YEAR
//--------------------------------------------------------------------------


#import "TableDemoViewController.h"


@implementation TableDemoViewController


-(id) init
{
    self = [super init];
    
    if (self != nil)
    {
        // Создать список файлов
        [self reload];
        
        // Инициализация кнопок навигации
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                                   initWithBarButtonSystemItem: UIBarButtonSystemItemEdit
                                                   target: self
                                                   action: @selector (startEditing)] autorelease];
        
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] 
                                                  initWithTitle: @"Reload" 
                                                  style: UIBarButtonItemStylePlain
                                                  target: self
                                                  action: @selector (reload)] autorelease];
    }
    return self;
}


-(void) startEditing
{
    [self.tableView setEditing: YES animated: YES];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                               target: self 
                                               action: @selector (stopEditing)] autorelease];
}


-(void) stopEditing
{
    [self.tableView setEditing: NO animated: YES];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem: UIBarButtonSystemItemEdit
                                               target: self
                                               action: @selector (startEditing)] autorelease];
}


-(void) reload
{
    NSDirectoryEnumerator *dirEnum;
    NSString *file;
    
    fileList = [[NSMutableArray alloc] init];
    dirEnum = [[NSFileManager defaultManager] enumeratorAtPath: NSHomeDirectory()];
    
    while ((file = [dirEnum nextObject]))
        [fileList addObject: file];

    // Устанавливаем бейдж приложения - количество файлов в каталоге
    [UIApplication sharedApplication].applicationIconBadgeNumber = [fileList count];
    
    
    [self.tableView reloadData];
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section
{
    return [fileList count];
}


-(UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
    NSString *CellIdentifier = [fileList objectAtIndex: [indexPath indexAtPosition: 1]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithFrame: CGRectZero reuseIdentifier: CellIdentifier] autorelease];
        
        cell.textLabel.text = CellIdentifier;
        
        //UIFont *font = [UIFont fontWithName: @"Courier" size: 12.0];
        //cell.font = font;
    }
    
    return cell;
}


-(void) tableView: (UITableView *) tableView commitEditingStyle: (UITableViewCellEditingStyle) editingStyle forRowAtIndexPath: (NSIndexPath *) indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Удаление ячейки
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];
        
        for (int i = 0; i < [fileList count]; ++i)
            if ([cell.textLabel.text isEqualToString: [fileList objectAtIndex: i]])
                [fileList removeObjectAtIndex: i];
    
        // Удаление ячейки из таблицы
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        [array addObject: indexPath];
        
        [self.tableView deleteRowsAtIndexPaths: array withRowAnimation: UITableViewRowAnimationTop];
    }
}


-(void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];
    
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle: @"File Selected"
                          message: [NSString stringWithFormat: @"You selected the file '%@'", cell.text]
                          delegate: nil
                          cancelButtonTitle: nil
                          otherButtonTitles: @"OK", nil];
    
    [alert show];
}


-(void) loadView
{
    [super loadView];
}


-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}


-(void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void) dealloc
{
    [fileList release];
    [super dealloc];
}


@end

