//
//  JJRCatalogItemCustomization.h
//  MakingOrders
//
//  Created by jbott on 2/13/14.
//  Copyright (c) 2014 Jon Bott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJRCatalogItemCustomization : NSObject

@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSMutableArray *color;
@property (nonatomic, strong) NSMutableArray *sizes;

@end
