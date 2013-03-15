//
//  AppDelegate.h
//  GenericCameraControl
//
//  Created by Yoon Lee on 3/12/13.
//  Copyright (c) 2013 Yoon Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@class RootViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    RootViewController *rootViewController;
}

@property(retain, nonatomic)UIWindow *window;

@property(nonatomic, retain)RootViewController *rootViewController;

@end
