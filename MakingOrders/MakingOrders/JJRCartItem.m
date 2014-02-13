//
//  JJRCartItem.m
//  MakingOrders
//
//  Created by Jay on 2/13/14.
//  Copyright (c) 2014 Jon Bott. All rights reserved.
//

#import "JJRCartItem.h"

@implementation JJRCartItem

-(BOOL)hasOptionalColorSelection{
    return !(self.optionalColorSelection == nil);
}

-(BOOL)hasOptionalLogoSelection{
    return !(self.optionalLogoSelection == nil);
}

-(BOOL)hasOptionalTextSelection{
    return !(self.optionalTextSelection == nil);
}

-(BOOL)hasOptionalSizeSelection{
    return !(self.optionalSizeSelection == nil);
}

- (id)initWithName:(NSString *)name basePrice:(int)basePrice
{
    self = [super init];
    if (self) {
        self.name = name;
        self.basePrice = basePrice;
    }
    return self;
}

@end
