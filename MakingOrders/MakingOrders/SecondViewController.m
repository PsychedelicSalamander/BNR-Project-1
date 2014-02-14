//
//  SecondViewController.m
//  MakingOrders
//
//  Created by jbott on 2/13/14.
//  Copyright (c) 2014 Jon Bott. All rights reserved.
//

#import "SecondViewController.h"
#import "JJRCatalogCell.h"
#import "JJRCartItem.h"
#import "UIImageView+AFNetworking.h"

@interface SecondViewController ()
@property (nonatomic, strong) NSArray *cartItems;
@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newCartItem) name:kJJRNewCartItem object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cartItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JJRCatalogCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"catalogCell"];
    
    if (cell == nil)
    {
        cell = [[JJRCatalogCell alloc]init];
    }
    
    JJRCartItem *cartItem = (JJRCartItem *)self.cartItems[indexPath.row];
    
    cell.Title.text = cartItem.name;
    cell.subtitle.text = @"";
    cell.value.text = [NSString stringWithFormat:@"%d", cartItem.basePrice];
    [cell.imageView setImageWithURL:[NSURL URLWithString:cartItem.imageUrl] placeholderImage:[UIImage imageNamed:@"trollface.jpg"]];

    
    //
    //    NSDictionary *event = self.ghEvents[indexPath.row];
    //    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", event[@"type"], event[@"created_at"]];
    //    NSString *user = [event valueForKeyPath:@"actor.login"];
    //    NSString *desc = [event valueForKeyPath:@"payload.description"];
    //    if (desc == nil)
    //    {
    //        desc = [event valueForKeyPath:@"repo.name"];
    //    }
    //
    //    NSString *avatarURLStr = [event valueForKeyPath:@"actor.avatar_url"];
    //    [cell.imageView setImageWithURL:[NSURL URLWithString:avatarURLStr] placeholderImage:[UIImage imageNamed:@"flowers.jpg"]];
    //    
    
    
    
    return cell;
}

- (void)newCartItem
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.cartItems = [DataManager cartItems];
        [self.tableView reloadData];
    }];
}
- (IBAction)purchaseCart:(id)sender {
    NSLog(@"OHMYGERSH buying teh cart!");
    if ([self.cartItems count] == 0)
    {
        return;
    }
    
    
}

@end
