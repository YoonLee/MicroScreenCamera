//
//  RootViewController.m
//  GenericCameraControl
//
//  Created by Yoon Lee on 3/12/13.
//  Copyright (c) 2013 Yoon Lee. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController


-(void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:CCLEAR()];
    
    // MODULE!!!
    CameraModuleView *cameraModule = [[CameraModuleView alloc] initWithFrame:CGRectMake(0, 0, 220, 220)];
    [cameraModule setCenter:CGPointMake(deviceScreen().size.width / 2, 220.0f)];
    [self.view addSubview:cameraModule];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionCameraModule:) name:CAMERA_SHOULD_LAUNCH_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionCloseModule) name:CAMERA_SHOULD_CLOSE_NOTIFICATION object:nil];
}

-(void)actionCameraModule:(NSNotification*)notification
{
    
}

-(void)actionCloseModule:(NSNotification*)notification
{
    
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end
