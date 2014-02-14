//
//  ItemStatusViewController.m
//  MakingOrders
//
//  Created by DKC_User on 2/13/14.
//  Copyright (c) 2014 Jon Bott. All rights reserved.
//

#import "ItemStatusViewController.h"

@interface ItemStatusViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *WebView;

@end

@implementation ItemStatusViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.WebView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
