//
//  FirstViewController.m
//  MakingOrders
//
//  Created by jbott on 2/13/14.
//  Copyright (c) 2014 Jon Bott. All rights reserved.
//

#import "FirstViewController.h"
#import "DataManager.h"
#import "JJRCatalogCell.h"
#import "JJRCatalogItem.h"
#import "JJRCatalogItemCustomization.h"
#import "UIImageView+AFNetworking.h"

@interface FirstViewController ()

@property (nonatomic, strong) NSArray *catalogItems;

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"Something" object:nil];
}

- (void)loadData
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.catalogItems = [DataManager items];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.catalogItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JJRCatalogCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"catalogCell"];
    
    JJRCatalogItem *catalogItem = (JJRCatalogItem *)self.catalogItems[indexPath.row];
    
    cell.Title.text = catalogItem.name;
    cell.subtitle.text = @"";
    cell.value.text = [NSString stringWithFormat:@"%d", catalogItem.basePrice];
    [cell.imageView setImageWithURL:[NSURL URLWithString:catalogItem.imageUrl]];

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


@end
