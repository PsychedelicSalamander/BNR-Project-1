//
//  DataManager.m
//  MakingOrders
//
//  Created by jbott on 2/13/14.
//  Copyright (c) 2014 Jon Bott. All rights reserved.
//

#import "DataManager.h"
#import "AFNetworking/AFNetworking.h"

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
    
}

@end
