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

@interface DataManager : NSObject

+ (void)loadProducts;
+ (NSArray *)items;

@end
