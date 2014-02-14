//
//  ThirdViewController.m
//  MakingOrders
//
//  Created by DKC_User on 2/13/14.
//  Copyright (c) 2014 Jon Bott. All rights reserved.
//

#import "ThirdViewController.h"
#import "DataManager.h"
#import "JJROrder.h"
#import "ItemStatusViewController.h"

@interface ThirdViewController ()

@property (nonatomic, strong) NSArray *itemHistory;

@end

@implementation ThirdViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:kJJRHistoryReady object:nil];
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)loadData
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.itemHistory = [DataManager history];
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.itemHistory count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"historyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"historyCell"];
    }
    // Configure the cell...
    JJROrder *order = (JJROrder *)self.itemHistory[indexPath.row];
    cell.textLabel.text = order.accountNumber;
    cell.detailTextLabel.text = order.detail;
    
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ItemStatusViewController *vc = (ItemStatusViewController *)segue.destinationViewController;
    if (vc)
    {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        JJROrder *order = self.itemHistory[path.row];
        
        vc.url = [NSString stringWithFormat:@"http://bnr-fruititems.appspot.com/status?order_id=%@", order.key];
    }
}

@end
