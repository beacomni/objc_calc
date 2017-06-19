//
//  AppDelegate.h
//  calculator_beacomni
//
//  Created by beacomni on 6/19/17.
//  Copyright © 2017 beacomni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

