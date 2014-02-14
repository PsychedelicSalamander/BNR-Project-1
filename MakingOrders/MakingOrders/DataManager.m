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

NSMutableArray *_items;
NSMutableArray *_cart;



@implementation DataManager

+ (void)loadProducts
{
	_items = @[].mutableCopy;

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = AFJSONResponseSerializer.serializer;
    [manager GET:@"http://bnr-fruititems.appspot.com/" parameters:@{}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {

			 [[self class] parseProducts:responseObject];
             [NSOperationQueue.mainQueue addOperationWithBlock:^{
				 [[self class] loadHistory];
             }];

         }
		 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             // get the json here
             //        id json = error.userInfo[JSONResponseSerializerWithDataKey];
             //        NSLog(@"failure %@", json);
         }];
    

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

+ (NSArray *)items
{
	return _items;
}

+ (NSArray *)cartItems
{
    return _cart;
}

+ (void)addCartItem:(JJRCartItem *)cartItem
{
    [_cart addObject:cartItem];
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSNotificationCenter.defaultCenter postNotificationName:kJJRNewCartItem object:self userInfo:nil];
    });
}

+ (void)loadHistory
{
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

	manager.responseSerializer = AFHTTPResponseSerializer.serializer;
	[manager GET:@"http://bnr-fruititems.appspot.com/history" parameters:@{}
		 success:^(AFHTTPRequestOperation *operation, id responseObject) {

             NSString *historyString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

			 [[self class] parseHistory:historyString];
//			 [NSOperationQueue.mainQueue addOperationWithBlock:^{
//				 [[self class] loadHistory];
//			 }];

		 }
		 failure:^(AFHTTPRequestOperation *operation, NSError *error) {}
	];
}

+ (void)parseHistory:(NSString *)historyString
{
//	NSLog(@"%@", historyString);
    NSArray *lines = [historyString componentsSeparatedByString:@"\n"];

	NSInteger lengthMinusLastLine = lines.count - 1;
	for (NSInteger i = 1; i < lengthMinusLastLine; i++)
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


		NSRange groupId = [match rangeAtIndex:1];
		NSString *orderID = [substring substringWithRange:groupId];
		NSLog(@"orderID: %@", orderID);

		NSRange groupSummary = [match rangeAtIndex:2];
		NSString *orderSummary = [substring substringWithRange:groupSummary];
		NSLog(@"orderSummary: %@", orderSummary);

		NSRange groupKey = [match rangeAtIndex:3];
		NSString *key = [substring substringWithRange:groupKey];
		NSLog(@"key: %@", key);

	}
}


@end
