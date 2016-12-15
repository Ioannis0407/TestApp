//
//  AppDelegate.h
//  TestApp
//
//  Created by Ioannis Silvestridis on 15/12/16.
//  Copyright © 2016 Ioannis Silvestridis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

