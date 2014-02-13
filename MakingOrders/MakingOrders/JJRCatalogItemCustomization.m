//
//  JJRCatalogItemCustomization.m
//  MakingOrders
//
//  Created by jbott on 2/13/14.
//  Copyright (c) 2014 Jon Bott. All rights reserved.
//

#import "JJRCatalogItemCustomization.h"

@implementation JJRCatalogItemCustomization

-(id)init
{
    if (self = [super init])
    {
        self.color = @[].mutableCopy;
        self.sizes = @[].mutableCopy;
    }
    
    return self;
}

@end
