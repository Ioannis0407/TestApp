//
//  ViewController.m
//  TestApp
//
//  Created by Ioannis Silvestridis on 15/12/16.
//  Copyright © 2016 Ioannis Silvestridis. All rights reserved.
//

#import "ViewController.h"
#import "WebServices.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WebServices *ws = [[WebServices alloc]init];
    [ws getRates];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
