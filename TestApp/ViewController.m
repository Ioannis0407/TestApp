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
    NSMutableArray *previousData;
    NSTimer *timer;
    WebServices *ws;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    previousData = [[NSMutableArray alloc]init];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    [self.tableView registerNib:[UINib nibWithNibName:@"SignalsTableViewCell" bundle:nil]forCellReuseIdentifier:@"SignalsTableViewCell"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud showAnimated:YES];
    
    ws = [[WebServices alloc]init];
    ws.delegate =self;
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self
                                           selector:@selector(getRates) userInfo:nil repeats:YES];
    //
  
 
}
-(void)getRates{
    
    previousData = data;
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
    if(!data){
        return cell;
    }
    cell.pairNameLabel.text = [[data valueForKey:@"name"]objectAtIndex:indexPath.row];
    
    float spread = ([[[data valueForKey:@"buy"]objectAtIndex:indexPath.row ] floatValue] - [[[data valueForKey:@"sell"]objectAtIndex:indexPath.row ] floatValue])*[[[data valueForKey:@"pipMultiplier"]objectAtIndex:indexPath.row ] floatValue];
    cell.spreadLabel.text = [NSString stringWithFormat:@"%.1f",spread];
    
    
    //sell rate values and colors
    float currentValue =[[[data valueForKey:@"sell"]objectAtIndex:indexPath.row]floatValue];
    float previousValue =[[[previousData valueForKey:@"sell"]objectAtIndex:indexPath.row]floatValue];
    if([[[data valueForKey:@"sell"]objectAtIndex:indexPath.row]floatValue]>[[[previousData valueForKey:@"sell"]objectAtIndex:indexPath.row]floatValue]){
        cell.sellView.backgroundColor = [UIColor greenColor];
    }
    else  if([[[data valueForKey:@"sell"]objectAtIndex:indexPath.row]floatValue]<[[[previousData valueForKey:@"sell"]objectAtIndex:indexPath.row]floatValue]){
        cell.sellView.backgroundColor = [UIColor redColor];

    }
    else if( [[[data valueForKey:@"sell"]objectAtIndex:indexPath.row]floatValue] == [[[previousData valueForKey:@"sell"]objectAtIndex:indexPath.row]floatValue]){
        cell.sellView.backgroundColor = [UIColor grayColor];
    }
    NSString *sellValue =[NSString stringWithFormat:@"%f", [[[data valueForKey:@"sell"]objectAtIndex:indexPath.row]floatValue]*[[[data valueForKey:@"pipMultiplier"]objectAtIndex:indexPath.row]floatValue]];
    
    NSString *fractionalPip = [[sellValue componentsSeparatedByString:@"."] lastObject];
    NSString *fractionalPipOneDigit = [fractionalPip substringToIndex:1];
    
    NSString *highlightedValue=[[[sellValue componentsSeparatedByString:@"."] firstObject] substringFromIndex:[[[sellValue componentsSeparatedByString:@"."] firstObject]  length]-2];
    ;
    
    cell.sellRateLAbel.text = [NSString stringWithFormat:@"%.2f",[[[data valueForKey:@"sell"] objectAtIndex:indexPath.row]floatValue]];
    cell.sellFractionalPipLabel.text =fractionalPipOneDigit;
    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    cell.sellHighlightPipLabel.attributedText =[[NSAttributedString alloc] initWithString:highlightedValue attributes:underlineAttribute];
    
    
    //buy rates values and colors
    if([[[data valueForKey:@"buy"]objectAtIndex:indexPath.row]floatValue]>[[[previousData valueForKey:@"buy"]objectAtIndex:indexPath.row]floatValue]){
        cell.buyView.backgroundColor = [UIColor greenColor];
    }
    else  if([[[data valueForKey:@"buy"]objectAtIndex:indexPath.row]floatValue]<[[[previousData valueForKey:@"buy"]objectAtIndex:indexPath.row]floatValue]){
        cell.buyView.backgroundColor = [UIColor redColor];
        
    }
    else if([[[data valueForKey:@"buy"]objectAtIndex:indexPath.row]floatValue]==[[[previousData valueForKey:@"buy"]objectAtIndex:indexPath.row]floatValue]) {
        
        cell.buyView.backgroundColor = [UIColor grayColor];
        
    }
    
    NSString *buyValue =[NSString stringWithFormat:@"%f", [[[data valueForKey:@"buy"]objectAtIndex:indexPath.row]floatValue]*[[[data valueForKey:@"pipMultiplier"]objectAtIndex:indexPath.row]floatValue]];
    
    NSString *buyfractionalPip = [[buyValue componentsSeparatedByString:@"."] lastObject];
   // NSString *fractionalPip = [[sellValue componentsSeparatedByString:@"."] lastObject];
    NSString *buyfractionalPipOneDigit = [buyfractionalPip substringToIndex:1];
    
    NSString *buyhighlightedValue=[[[buyValue componentsSeparatedByString:@"."] firstObject] substringFromIndex:[[[sellValue componentsSeparatedByString:@"."] firstObject]  length]-2];
    
    cell.buyRateLabel.text = [NSString stringWithFormat:@"%.2f",[[[data valueForKey:@"buy"] objectAtIndex:indexPath.row]floatValue]];;
    cell.buyFractionalPip.text =buyfractionalPipOneDigit;
    NSDictionary *buyunderlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    cell.buyHighlightPipLabel.attributedText = [[NSAttributedString alloc] initWithString:buyhighlightedValue attributes:buyunderlineAttribute];
    
   
    return cell;
}

#pragma Web Services delegate

-(void)returnRatesWith:(NSDictionary *)dictionary{
    
     data = [[NSMutableArray alloc]init];
    for(id signal in dictionary){
        
        [data addObject:signal];
    }
   dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    
    
}

@end
