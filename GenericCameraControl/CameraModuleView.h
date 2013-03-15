//
//  TTXCameraModuleView.h
//  GenericCameraControl
//
//  Created by Yoon Lee on 3/13/13.
//  Copyright (c) 2013 Yoon Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVCamCaptureManager.h"

extern NSString * const CAMERA_SHOULD_LAUNCH_NOTIFICATION;
extern NSString * const CAMERA_SHOULD_CLOSE_NOTIFICATION;

@class AVCamCaptureManager, AVCamPreviewView, AVCaptureVideoPreviewLayer;
@interface CameraModuleView : UIView <UIImagePickerControllerDelegate>
{
    AVCamCaptureManager *captureManager;
    
    AVCaptureVideoPreviewLayer *previewLayer;
}

@property(nonatomic, retain)AVCamCaptureManager *captureManager;

@property(nonatomic, retain)AVCaptureVideoPreviewLayer *previewLayer;

@end
