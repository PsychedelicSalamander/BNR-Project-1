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

- (NSString *)orderSummary
{
	NSMutableString * _orderSummary = @"".mutableCopy;
	[_orderSummary appendFormat:@"%@", self.name ?: @""];
    if (self.hasOptionalTextSelection)
	[_orderSummary appendFormat:@",%@", self.optionalTextSelection ?: @""];
    if (self.hasOptionalLogoSelection)
	[_orderSummary appendFormat:@",%@", self.optionalLogoSelection ?: @""];
    if (self.hasOptionalColorSelection)
	[_orderSummary appendFormat:@",%@", self.optionalColorSelection ?: @""];
    if (self.hasOptionalSizeSelection)
	[_orderSummary appendFormat:@",%@", self.optionalSizeSelection ?: @""];

	return _orderSummary;
}


@end
