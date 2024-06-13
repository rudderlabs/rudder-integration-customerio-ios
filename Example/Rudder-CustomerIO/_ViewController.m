//
//  _ViewController.m
//  Rudder-CustomerIO
//
//  Created by arnabp92 on 02/11/2020.
//  Copyright (c) 2020 arnabp92. All rights reserved.
//

#import "_ViewController.h"
#import <Rudder/Rudder.h>

@interface _ViewController ()

@end

@implementation _ViewController

RSClient *client;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    client = [RSClient sharedInstance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)identifyAction:(UIButton *)sender {
    [client identify:@"Test_User_127" traits: @{@"email": @"satheesh@rudderstack.com", @"firstName": @"Satheesh Kannan", @"lastName": @"Arumugam"}];
}

- (IBAction)trackAction:(UIButton *)sender {
    [client track:@"Test_User127_Track"];
}

- (IBAction)screenAction:(UIButton *)sender {
    [client screen:@"Test_User127_Screen"];
}

- (IBAction)resetAction:(UIButton *)sender {
    [client reset:YES];
}

@end
