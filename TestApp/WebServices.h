//
//  WebServices.h
//  TestApp
//
//  Created by Ioannis Silvestridis on 15/12/16.
//  Copyright © 2016 Ioannis Silvestridis. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol RatesReturn <NSObject>

-(void) returnRatesWith:(NSDictionary*)dictionary;

@end

@interface WebServices : NSObject
@property (nonatomic,weak) id<RatesReturn> delegate;

-(void) getRates;

@end
