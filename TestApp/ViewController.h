//
//  ViewController.h
//  TestApp
//
//  Created by Ioannis Silvestridis on 15/12/16.
//  Copyright © 2016 Ioannis Silvestridis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServices.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,RatesReturn>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) id<RatesReturn> delegate;

@end

