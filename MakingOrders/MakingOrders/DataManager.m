//
//  DataManager.m
//  MakingOrders
//
//  Created by jbott on 2/13/14.
//  Copyright (c) 2014 Jon Bott. All rights reserved.
//

#import "DataManager.h"
#import "AFNetworking/AFNetworking.h"
#import "JJRCatalogItem.h"
#import "JJRCartItem.h"
#import "JJROrder.h"

NSMutableArray *_items;
NSMutableArray *_history;
NSMutableArray *_cart;



@implementation DataManager

+ (void)loadProducts
{
	_items = @[].mutableCopy;
	_history = @[].mutableCopy;
	_cart = @[].mutableCopy;

//#if DEBUG
//	[[self class] populateCartWithFakeData];
//#endif

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = AFJSONResponseSerializer.serializer;
    [manager GET:@"http://bnr-fruititems.appspot.com/" parameters:@{}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {

			 [[self class] parseProducts:responseObject];
             [NSOperationQueue.mainQueue addOperationWithBlock:^{
				 [[self class] loadHistory];
             }];

         }
		 failure:^(AFHTTPRequestOperation *operation, NSError *error) {}
     ];
    

}

+ (void)parseProducts:(id)responseObject
{
//				"color" : ["#000000", "#ff0000", "#00ff00", "#0000ff"],
//				"sizes" : ["Small", "Medium", "Large", "X-Large", "2X-Large"]

	for(NSDictionary *item in responseObject)
	{
		JJRCatalogItemCustomization *customization = [JJRCatalogItemCustomization new];
		customization.text = [item valueForKeyPath:@"customizations.text"] ?: @"";
		customization.logo = [item valueForKeyPath:@"customizations.logo"] ?: @"";
		customization.color = [item valueForKeyPath:@"customizations.color"] ?: @[];
		customization.sizes = [item valueForKeyPath:@"customizations.sizes"] ?: @[];

		JJRCatalogItem *catalogItem = [JJRCatalogItem new];
		catalogItem.name = [item valueForKeyPath:@"name"] ?: @"";
		catalogItem.basePrice = ((NSString *)[item valueForKeyPath:@"basePrice"]).integerValue ?: 0;
		catalogItem.imageUrl = [item valueForKeyPath:@"image"] ?: @"";
		catalogItem.customizations = customization;

		[_items addObject:catalogItem];
	}

	NSLog(@"%@", _items);
    dispatch_async(dispatch_get_main_queue(), ^{
		[NSNotificationCenter.defaultCenter postNotificationName:kJJRCatalogReady object:self userInfo:nil];
    });

}

+ (NSMutableArray *)history;
{
	return _history;
}

+ (NSArray *)items
{
	return _items;
}

+ (NSMutableArray *)cartItems
{
    return _cart;
}

+ (void)addCartItem:(JJRCartItem *)cartItem
{
    [_cart addObject:cartItem];
    [NSNotificationCenter.defaultCenter postNotificationName:kJJRNewCartItem object:self userInfo:nil];

}

+ (void)loadHistory
{
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

	manager.responseSerializer = AFHTTPResponseSerializer.serializer;
	[manager GET:@"http://bnr-fruititems.appspot.com/history" parameters:@{}
		 success:^(AFHTTPRequestOperation *operation, id responseObject) {

             NSString *historyString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

			 [[self class] parseHistory:historyString];
			 [NSOperationQueue.mainQueue addOperationWithBlock:^{

                 dispatch_async(dispatch_get_main_queue(), ^{
                     [NSNotificationCenter.defaultCenter postNotificationName:kJJRHistoryReady object:self userInfo:nil];
                 });
                 
			 }];

		 }
		 failure:^(AFHTTPRequestOperation *operation, NSError *error) {}
	];
}

+ (void)loadOrderStatusWithOrderKey:(NSString *)key
{
	NSString *statusUrl = [NSString stringWithFormat:@"http://bnr-fruititems.appspot.com/status?order_id=%@", key];

	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

	manager.responseSerializer = AFHTTPResponseSerializer.serializer;
	[manager GET:statusUrl parameters:@{}
		 success:^(AFHTTPRequestOperation *operation, id responseObject) {

			 NSString *statusString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

			 [NSOperationQueue.mainQueue addOperationWithBlock:^{

				 dispatch_async(dispatch_get_main_queue(), ^{
                     [NSNotificationCenter.defaultCenter postNotificationName:kJJRStatusReady object:self userInfo:@{@"status":statusString}];
				 });

			 }];

		 }
		 failure:^(AFHTTPRequestOperation *operation, NSError *error) {}
	];
}

+ (void)parseHistory:(NSString *)historyString
{
//	NSLog(@"%@", historyString);
    NSArray *lines = [historyString componentsSeparatedByString:@"\n"];

	for (NSInteger i = 1; i < lines.count; i++)
	{
		[self getOrderAndKeyString:lines index:i];
	}
}

+ (void)getOrderAndKeyString:(NSArray *)lines index:(NSInteger)i
{
	NSString *substring = lines[i];
	NSRange searchedRange = NSMakeRange(0, substring.length);
	NSString *pattern = @"ACCOUNT (.*),.* ORDER (.*) KEY (.*)";
	NSError  *error = nil;
    
	NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
	NSArray* matches = [regex matchesInString:substring options:0 range:searchedRange];
    
	for (NSTextCheckingResult* match in matches) {

		JJROrder *order = [JJROrder new];


		NSRange groupId = [match rangeAtIndex:1];

		NSRange groupSummary = [match rangeAtIndex:2];

		NSRange groupKey = [match rangeAtIndex:3];

		order.accountNumber = [substring substringWithRange:groupId] ?: @"";
		order.detail = [substring substringWithRange:groupSummary] ?: @"";
		order.key = [substring substringWithRange:groupKey] ?: @"";

		NSLog(@"\n~~~~~~~~~~~~~~~~");
		NSLog(@"orderID: %@", [substring substringWithRange:groupId]);
		NSLog(@"orderSummary: %@", [substring substringWithRange:groupSummary]);
		NSLog(@"key: %@", [substring substringWithRange:groupKey]);

		[DataManager.history addObject:order];
	}

	NSLog(@"%i", DataManager.history.count);
}


+ (void)placeOrder
{
	NSString *orderUrl = [[self class] buildOrderString];

	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	manager.responseSerializer = AFJSONResponseSerializer.serializer;
	[manager POST:orderUrl parameters:@{}
		 success:^(AFHTTPRequestOperation *operation, id responseObject) {
			 [DataManager loadHistory];
             [_cart removeAllObjects];
             [NSNotificationCenter.defaultCenter postNotificationName:kJJRNewCartItem object:self userInfo:nil];
		 }
		 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Something bad happened: %@", [error localizedDescription]);
			 // get the json here
			 //        id json = error.userInfo[JSONResponseSerializerWithDataKey];
			 //        NSLog(@"failure %@", json);
		 }];
}

+ (NSString *)buildOrderString
{
	NSMutableString *totallyUglyAndSuperLongCartDescriptor = @"".mutableCopy;

	for (JJRCartItem *item in _cart)
	{
		[totallyUglyAndSuperLongCartDescriptor appendFormat:@"__ITEM__%@", item.orderSummary ?: @""];
	}

	NSString *orderUrl = [NSString stringWithFormat:@"http://bnr-fruititems.appspot.com/order?account=TZ123&items=%@", totallyUglyAndSuperLongCartDescriptor];
	return orderUrl;
}


+ (void)populateCartWithFakeData
{
	for(NSInteger i = 0; i < 3; i++)
	{
		JJRCartItem *item = [JJRCartItem new];
		item.name = [NSString stringWithFormat:@"item_%i", i];
		item.optionalColorSelection = [NSString stringWithFormat:@"color_%i", i];
		item.optionalLogoSelection = [NSString stringWithFormat:@"logo_%i", i];
		item.optionalTextSelection = [NSString stringWithFormat:@"text_%i", i];
		item.optionalSizeSelection = [NSString stringWithFormat:@"size_%i", i];

		[_cart addObject:item];
	}

	[[self class] loadOrderStatusWithOrderKey:@"ahBzfmJuci1mcnVpdGl0ZW1zcg0LEgVPcmRlchi51RUM"];

}



@end
