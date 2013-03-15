//
//  TTXCameraModuleView.m
//  GenericCameraControl
//
//  Created by Yoon Lee on 3/13/13.
//  Copyright (c) 2013 Yoon Lee. All rights reserved.
//

#import "CameraModuleView.h"
typedef enum {
    TTX_CAMERA_CAPTURE = 0,
    TTX_CLOSE,
}TTX_CAMERA_CAPTURE_BUTTONS;

NSString * const CAMERA_SHOULD_LAUNCH_NOTIFICATION          = @"CAMERA_SHOULD_LAUNCH_NOTIFICATION";
NSString * const CAMERA_SHOULD_CLOSE_NOTIFICATION           = @"CAMERA_SHOULD_CLOSE_NOTIFICATION";
@interface CameraModuleView()

@property(assign)SystemSoundID soundID;

-(void)setModule:(CGRect)_frame;

-(void)buttonClicked:(UIButton*)button;

@end

@implementation CameraModuleView
@synthesize captureManager;
@synthesize previewLayer;
@synthesize soundID;

- (id)initWithFrame:(CGRect)_frame
{
    if (self = [super initWithFrame:_frame]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cam_click" ofType:@"aifc"];
        AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &soundID);
        [self setModule:_frame];
    }
    
    return self;
}

-(void)setModule:(CGRect)_frame
{
    // MODULE!!!
    [self setBackgroundColor:CCLEAR()];
    UIImage *cameraBarImg = [UIImage imageNamed:@"CameraBar.png"];
    UIImageView *backPanel = [[UIImageView alloc] initWithImage:cameraBarImg];
    [backPanel setUserInteractionEnabled:YES];
    [backPanel setFrame:CGRectMake(0, self.frame.size.height - cameraBarImg.size.height, cameraBarImg.size.width, cameraBarImg.size.height)];
    UIButton *aBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [aBtn setTag:TTX_CAMERA_CAPTURE];
    UIImage *img = [UIImage imageNamed:@"shutterBtn_blank_norm.png"];
    [aBtn setImage:img forState:UIControlStateNormal];
    [aBtn setFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    [aBtn setCenter:CGPointMake(backPanel.frame.size.width / 2, 25.0f)];
    [aBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backPanel addSubview:aBtn];
    [self addSubview:backPanel];
    [backPanel release];
    
    [self.layer setBorderColor:CBLACK().CGColor];
    [self.layer setBorderWidth:0.75f];
    [self.layer setCornerRadius:3.5f];
    [self.layer setMasksToBounds:YES];
    
    if (!self.captureManager) {
        AVCamCaptureManager *manager = [[AVCamCaptureManager alloc] init];
        [self setCaptureManager:manager];
        [manager release];
        
        if ([self.captureManager setupSession]) {
            previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:[self.captureManager session]];
            CGRect bounds = self.bounds;
            CALayer *layer = self.layer;
            [layer setBorderColor:CDGRAY().CGColor];
            [layer setBorderWidth:0.75f];
            [layer setCornerRadius:3.5f];
            [layer setMasksToBounds:YES];
            [previewLayer setFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height - cameraBarImg.size.height)];
            [layer addSublayer:previewLayer];
            [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self.captureManager.session startRunning];
            });
        }
    }
    
    UIImage *closeImg = [UIImage imageNamed:@"fs-tray-delete-button.png"];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setTag:TTX_CLOSE];
    [closeBtn setImage:closeImg forState:UIControlStateNormal];
    [closeBtn setFrame:CGRectMake(self.frame.size.width - 29, -2, closeImg.size.width, closeImg.size.height)];
    [closeBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
}

-(void)buttonClicked:(UIButton*)button
{
    switch (button.tag) {
        case TTX_CAMERA_CAPTURE:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CAMERA_SHOULD_LAUNCH_NOTIFICATION" object:nil userInfo:nil];
            // PLAY SIMPLE SOUND
            AudioServicesPlaySystemSound(soundID);
            // Capture a still image
            #if !TARGET_IPHONE_SIMULATOR
            [self.captureManager captureStillImage];
            #endif
            // Flash the screen white and fade it out to give UI feedback that a still image was taken
            UIView *flashView = [[UIView alloc] initWithFrame:previewLayer.frame];
            [flashView setBackgroundColor:CWHITE()];
            [self addSubview:flashView];
            [UIView animateWithDuration:.4f
                             animations:^{
                                 [flashView setAlpha:0.f];
                             }
                             completion:^(BOOL finished){
                                 [flashView removeFromSuperview];
                                 [flashView release];
                             }
             ];
            break;
        case TTX_CLOSE:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CAMERA_SHOULD_CLOSE_NOTIFICATION" object:nil userInfo:nil];
            [self removeFromSuperview];
            [self release];
            break;
    }
}

-(void)dealloc
{
    [previewLayer release];
    previewLayer = nil;
    
    [captureManager release];
    captureManager = nil;
    AudioServicesDisposeSystemSoundID(soundID);
    [super dealloc];
}

@end
