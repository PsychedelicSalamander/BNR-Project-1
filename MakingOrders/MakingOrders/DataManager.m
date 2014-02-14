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

NSMutableArray *_items;

@implementation DataManager

+ (void)loadProducts
{
	_items = @[].mutableCopy;

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//[JSONResponseSerializerWithData serializer];
    [manager GET:@"http://bnr-fruititems.appspot.com/" parameters:@{}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSLog(@"success %@", responseObject);
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

+ (void)loadHistory
{

}

@end
