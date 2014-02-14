//
//  CatalogItemDetailViewController.m
//  MakingOrders
//
//  Created by Jay on 2/13/14.
//  Copyright (c) 2014 Jon Bott. All rights reserved.
//

#import "JJRCatalogItemDetailViewController.h"
#import "JJRCatalogItemDetailNameCell.h"
#import "JJRCatalogItemDetailImageCell.h"
#import "JJRCartItem.h"

@interface JJRCatalogItemDetailViewController ()

@end

@implementation JJRCatalogItemDetailViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (self.item.customizations.logo || self.item.customizations.text || self.item.customizations.sizes || self.item.customizations.color)
        return 2;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 1) {
        return 231;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section: %d row: %d", indexPath.section, indexPath.row);
    if (indexPath.section == 0  && indexPath.row == 0)
    {
        JJRCatalogItemDetailNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell"];
        if (!cell) {
            cell = [[JJRCatalogItemDetailNameCell alloc] init];
        }
        cell.nameLabel.text = self.item.name;
        cell.priceLabel.text = [NSString stringWithFormat:@"$%d", self.item.basePrice];
        return cell;
    }else if (indexPath.section == 0  && indexPath.row == 1)
    {
        JJRCatalogItemDetailImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell"];
        if (!cell) {
            cell= [[JJRCatalogItemDetailImageCell alloc]init];
        }
        //load the image here
        return cell;
    }else{
        static NSString *CellIdentifier = @"CustomizationCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        return cell;
    }

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
- (IBAction)addItem:(id)sender {
    
    JJRCartItem *cartItem = [[JJRCartItem alloc] init];
    cartItem.name = self.item.name;
    cartItem.basePrice = self.item.basePrice;
    cartItem.imageUrl = self.item.imageUrl;
    [[DataManager cartItems] addObject:cartItem];
}

@end
