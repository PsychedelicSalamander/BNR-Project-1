//
//  CatalogItemDetailViewController.h
//  MakingOrders
//
//  Created by Jay on 2/13/14.
//  Copyright (c) 2014 Jon Bott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJRCatalogItem.h"

@interface JJRCatalogItemDetailViewController : UITableViewController
@property (nonatomic, strong) JJRCatalogItem *item;
@end
