//
//  SignalsTableViewCell.h
//  TestApp
//
//  Created by Ioannis Silvestridis on 15/12/16.
//  Copyright © 2016 Ioannis Silvestridis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignalsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *pairNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *spreadLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellRateLAbel;
@property (weak, nonatomic) IBOutlet UILabel *sellHighlightPipLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellFractionalPipLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyHighlightPipLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyFractionalPip;
@property (weak, nonatomic) IBOutlet UIView *sellView;
@property (weak, nonatomic) IBOutlet UIView *buyView;

@end
