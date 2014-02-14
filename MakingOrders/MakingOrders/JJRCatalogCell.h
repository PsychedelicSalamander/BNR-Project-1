//
//  JJRCatalogCell.h
//  MakingOrders
//
//  Created by DKC_User on 2/13/14.
//  Copyright (c) 2014 Jon Bott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJRCatalogCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UILabel *value;

@end
