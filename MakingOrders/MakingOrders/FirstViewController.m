//
//  FirstViewController.m
//  MakingOrders
//
//  Created by jbott on 2/13/14.
//  Copyright (c) 2014 Jon Bott. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"catalogCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"catalogCell"];
    }
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"BORP"];
    
    return cell;
}


@end
