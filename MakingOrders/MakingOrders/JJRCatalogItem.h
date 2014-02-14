//
//  JJRCatalogItem.h
//  MakingOrders
//
//  Created by jbott on 2/13/14.
//  Copyright (c) 2014 Jon Bott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJRCatalogItemCustomization.h"

@interface JJRCatalogItem : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int basePrice;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) JJRCatalogItemCustomization *customizations;

@end
