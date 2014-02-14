//
//  JJRCartItem.h
//  MakingOrders
//
//  Created by Jay on 2/13/14.
//  Copyright (c) 2014 Jon Bott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJRCartItem : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic)int basePrice;
@property (nonatomic, copy)NSString *optionalTextSelection;
@property (nonatomic, copy)NSString *optionalLogoSelection;
@property (nonatomic, copy)NSString *optionalColorSelection;
@property (nonatomic, copy)NSString *optionalSizeSelection;
@property (nonatomic, readonly)BOOL hasOptionalTextSelection;
@property (nonatomic, readonly)BOOL hasOptionalLogoSelection;
@property (nonatomic, readonly)BOOL hasOptionalSizeSelection;
@property (nonatomic, readonly)BOOL hasOptionalColorSelection;
@property (nonatomic, strong) NSString *imageUrl;

-(instancetype)initWithName:(NSString *)name basePrice:(int)basePrice;

@end
