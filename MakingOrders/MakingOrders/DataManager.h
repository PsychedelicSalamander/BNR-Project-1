//
//  DataManager.h
//  MakingOrders
//
//  Created by jbott on 2/13/14.
//  Copyright (c) 2014 Jon Bott. All rights reserved.
//

#import <Foundation/Foundation.h>

// Prefs.h
static NSString * const kJJRCatalogReady = @"kJJRCatalogReady";
static NSString * const kJJRNewCartItem = @"kJJRNewCartItem";

@interface DataManager : NSObject

+ (void)loadProducts;
+ (NSArray *)items;
+ (NSMutableArray *)history;
+ (NSMutableArray *)cartItems;

+ (void)placeOrder;
@end
