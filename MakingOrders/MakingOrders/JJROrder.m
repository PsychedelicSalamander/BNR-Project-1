//
//  JJROrder.m
//  MakingOrders
//
//  Created by Jay on 2/13/14.
//  Copyright (c) 2014 Jon Bott. All rights reserved.
//

#import "JJROrder.h"

@implementation JJROrder
- (id)initWithKey:(NSString *)key accountNumber:(NSString *)accountNumber detail:(NSString *)detail
{
    self = [super init];
    if (self) {
        self.accountNumber = accountNumber;
        self.key = key;
        self.detail  = detail;
    }
    return self;
}
@end
