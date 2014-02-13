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

NSArray *_items;

@implementation DataManager

+ (void)loadProducts
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//[JSONResponseSerializerWithData serializer];
    //    [manager POST:@"https://api.github.com/events" parameters:@{@"key1": @"value1", @"key2": @"value2"}
    [manager GET:@"http://bnr-fruititems.appspot.com/" parameters:@{}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSLog(@"success %@", responseObject);
             [[self class] generateCatalog:responseObject];
//             self.ghEvents = responseObject;
//             [NSOperationQueue.mainQueue addOperationWithBlock:^{
//                 [self.tableView reloadData];
//             }];
             
         }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             // get the json here
             //        id json = error.userInfo[JSONResponseSerializerWithDataKey];
             //        NSLog(@"failure %@", json);
         }];
    

}

+ (void)generateCatalog:(id)responseObject
{


//	{
//		"name": "T-Shirt",
//				"basePrice": "15",
//				"image" : "http://bnr-fruititems.appspot.com/images/tshirt.jpg",
//				"customizations" : {
//			"text" : "What a hack",
//					"logo" : "sheesh",
//					"color" : ["#000000", "#ff0000", "#00ff00", "#0000ff"],
//					"sizes" : ["Small", "Medium", "Large", "X-Large", "2X-Large"]
//		}
//	},

	_items = responseObject;


	for(NSDictionary *item in _items)
	{
		NSString *name = [item valueForKeyPath:@"name"];
		NSString *basePrice = [item valueForKeyPath:@"basePrice"];
		NSString *image = [item valueForKeyPath:@"image"];

		NSString *text = [item valueForKeyPath:@"customizations.text"];
		if(text == nil) text = @"";

		NSString *logo = [item valueForKeyPath:@"customizations.logo"];

		NSArray *colors = [item valueForKeyPath:@"customizations.color"];
		NSArray *sizes = [item valueForKeyPath:@"customizations.sizes"];

//		JJRCatalogItemCustomization *customizations = [JJRCatalogItemCustomization new];
//
//
//		JJRCatalogItem *catalogItem = [[JJRCatalogItem new];
//		catalogItem.name = name;
//		catalogItem.basePrice = basePrice;
//		catalogItem.imageUrl = image;
//		catalogItem.customizations = customizations;
		
		
//		"text" : "What a hack",
//				"logo" : "sheesh",
//				"color" : ["#000000", "#ff0000", "#00ff00", "#0000ff"],
//				"sizes" : ["Small", "Medium", "Large", "X-Large", "2X-Large"]

	}





//	cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", user, desc];
//	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", event[@"type"], event[@"created_at"]];
//	[cell.imageView setImageWithURL:[NSURL URLWithString:avatarURLStr] placeholderImage:[UIImage imageNamed:@"naruto.jpg"]];

}

+ (void)setItems:(id)items
{
	_items = items;
}

+ (NSArray *)items
{
	return _items;
}

@end
