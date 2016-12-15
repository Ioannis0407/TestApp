//
//  ViewController.m
//  TestApp
//
//  Created by Ioannis Silvestridis on 15/12/16.
//  Copyright © 2016 Ioannis Silvestridis. All rights reserved.
//

#import "ViewController.h"
#import "WebServices.h"
#import "SignalsTableViewCell.h"
#import "MBProgressHUD.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableArray *data;
    NSTimer *timer;
    WebServices *ws;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    data = [[NSMutableArray alloc]init];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    [self.tableView registerNib:[UINib nibWithNibName:@"SignalsTableViewCell" bundle:nil]forCellReuseIdentifier:@"SignalsTableViewCell"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud showAnimated:YES];
    
    ws = [[WebServices alloc]init];
    ws.delegate =self;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self
                                           selector:@selector(getRates) userInfo:nil repeats:YES];
    //
  
 
}
-(void)getRates{
    
      [ws getRates];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(!data){
        return 1;
    }
    else{
        return [data count];
        }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float heightForRow = 151;
    return heightForRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SignalsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SignalsTableViewCell" forIndexPath:indexPath];
    
    cell.pairNameLabel.text = [[data valueForKey:@"name"]objectAtIndex:indexPath.row];
    
    float spread = ([[[data valueForKey:@"buy"]objectAtIndex:indexPath.row ] floatValue] - [[[data valueForKey:@"sell"]objectAtIndex:indexPath.row ] floatValue])*[[[data valueForKey:@"pipMultiplier"]objectAtIndex:indexPath.row ] floatValue];
    cell.spreadLabel.text = [NSString stringWithFormat:@"%.1f",spread];
    
    
    
    return cell;
}

#pragma Web Services delegate

-(void)returnRatesWith:(NSDictionary *)dictionary{
    
    
    for(id signal in dictionary){
        
        [data addObject:signal];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    
    
}

@end
