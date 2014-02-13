//
//  JJRCatalogItem.m
//  MakingOrders
//
//  Created by jbott on 2/13/14.
//  Copyright (c) 2014 Jon Bott. All rights reserved.
//

#import "JJRCatalogItem.h"

@implementation JJRCatalogItem

- (id)init
{
    if (self = [super init])
    {
        self.customizations = [JJRCatalogItemCustomization new];
    }
    
    return self;
}

@end
