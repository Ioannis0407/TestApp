//
//  WebServices.m
//  TestApp
//
//  Created by Ioannis Silvestridis on 15/12/16.
//  Copyright © 2016 Ioannis Silvestridis. All rights reserved.
//

#import "WebServices.h"
#import "Settings.h"

@implementation WebServices

-(void) getRates{
    
    NSURL *url = [NSURL URLWithString:Network];
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    [rq setHTTPMethod:@"POST"];
    [rq setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    // NSString *post = [NSString stringWithFormat:@"command1=c1&command2=c2"];
    // NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
   // deviceID = [[NSUserDefaults standardUserDefaults] stringForKey:@"deviceID"];
    
    //build an info object and convert to json
    NSMutableDictionary *content = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"true",@"includeMultiplier",nil];
    
    //,@"password",deviceName,@"device_name",[[NSUserDefaults standardUserDefaults]valueForKey:@"FirebaseToken"],@"notif_token", nil];
    
    NSDictionary *newDatasetInfo = @{@"includeMultiplier":@"true"};
    // @{@"foo": @"bar", @"baz": @[@"firstName", @"lastName", @"Email"]};
    //convert object to data
    NSError *error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:newDatasetInfo options:kNilOptions error:&error];
    [rq setHTTPBody:jsonData];
   // [rq setHTTPBody:[newDatasetInfo dataUsingEncoding:NSUTF8StringEncoding]];
//        [rq setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:rq queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ([data length] > 0 && error == nil){
             NSError *parseError = nil;
             NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
             NSLog(@"Server Response (we want to see a 200 return code) %@",response);
             NSLog(@"dictionary %@",dictionary);
             
             
             [self.delegate returnRatesWith:dictionary];
             
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"no data returned");
             //no data, but tried
         }
         else if (error != nil)
         {
             NSLog(@"there was a download error");
             //couldn't download
             
         }
         
     }];
    
}

@end
